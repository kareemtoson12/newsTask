import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'article_detail_state.dart';

class ArticleDetailCubit extends Cubit<ArticleDetailState> {
  ArticleDetailCubit() : super(const ArticleDetailInitial());

  String normalizeUrl(String raw) {
    String url = raw.replaceAll('\n', '').replaceAll('\r', '').trim();
    url = url.replaceAll(RegExp(r"\s+"), '%20');
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://' + url;
    }
    return url;
  }

  Future<void> openUrl(String? rawUrl) async {
    if (rawUrl == null || rawUrl.isEmpty) {
      emit(const ArticleDetailError('No URL available for this article'));
      return;
    }

    emit(const ArticleDetailLaunching());
    final normalized = normalizeUrl(rawUrl);
    final uri = Uri.tryParse(normalized);
    if (uri == null) {
      emit(const ArticleDetailError('Invalid article URL'));
      return;
    }

    try {
      if (kIsWeb) {
        final ok = await launchUrl(uri, webOnlyWindowName: '_blank');
        if (!ok) throw Exception('launch failed');
        emit(const ArticleDetailLaunched());
        return;
      }
      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!ok) throw Exception('launch failed');
      emit(const ArticleDetailLaunched());
    } on PlatformException catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print('PlatformException launching URL: ' + e.toString());
      }
      emit(const ArticleDetailError('Could not open the article URL'));
    } catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print('Error launching URL: ' + e.toString());
      }
      emit(const ArticleDetailError('Could not open the article URL'));
    }
  }
}
