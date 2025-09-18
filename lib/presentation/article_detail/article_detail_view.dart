import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:news/data/models/news_response.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailView extends StatelessWidget {
  final Article article;
  const ArticleDetailView({super.key, required this.article});

  String _normalizeUrl(String raw) {
    // Remove line breaks and trim
    String url = raw.replaceAll('\n', '').replaceAll('\r', '').trim();
    // If there's any internal whitespace, percent-encode it
    url = url.replaceAll(RegExp(r"\s+"), '%20');
    // Add https scheme if missing
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://' + url;
    }
    return url;
  }

  bool _isValidHttpUrl(String? url) {
    if (url == null || url.trim().isEmpty) return false;
    final normalized = _normalizeUrl(url);
    final uri = Uri.tryParse(normalized);
    return uri != null && (uri.isScheme('http') || uri.isScheme('https'));
  }

  Future<void> _openUrl(BuildContext context) async {
    final url = article.url;
    if (url == null || url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No URL available for this article')),
      );
      return;
    }
    final normalized = _normalizeUrl(url);
    final uri = Uri.tryParse(normalized);
    if (uri == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Invalid article URL')));
      return;
    }
    try {
      if (kIsWeb) {
        final ok = await launchUrl(uri, webOnlyWindowName: '_blank');
        if (!ok) throw Exception('launch failed');
        return;
      }
      // Mobile/desktop: prefer external app, fall back to in-app browser view
      bool ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!ok) {
        // Fallback: open in in-app WebView page
        // ignore: use_build_context_synchronously
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => _InAppWebViewPage(initialUrl: uri.toString()),
          ),
        );
        ok = true;
      }
    } catch (e) {
      if (kDebugMode) {
        // Helpful debug log to pinpoint failing URL
        // ignore: avoid_print
        print(
          'Launch failed for URL: ' + normalized + ' error: ' + e.toString(),
        );
      }
      // Fallback to in-app webview on platform channel errors
      try {
        // ignore: use_build_context_synchronously
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => _InAppWebViewPage(initialUrl: normalized),
          ),
        );
      } catch (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the article URL')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article.source?.name ?? 'Article')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_isValidHttpUrl(article.urlToImage))
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  _normalizeUrl(article.urlToImage!),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.broken_image, size: 50),
                      ),
                    );
                  },
                ),
              )
            else
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(Icons.image_not_supported, size: 50),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              article.title ?? '',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              (article.description?.isNotEmpty == true)
                  ? article.description!
                  : (article.content ?? ''),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _openUrl(context),
                icon: const Icon(Icons.open_in_new),
                label: const Text('Open full article'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InAppWebViewPage extends StatefulWidget {
  final String initialUrl;
  const _InAppWebViewPage({required this.initialUrl});

  @override
  State<_InAppWebViewPage> createState() => _InAppWebViewPageState();
}

class _InAppWebViewPageState extends State<_InAppWebViewPage> {
  late final WebViewController _controller;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) => setState(() => _loading = false),
        ),
      )
      ..loadRequest(Uri.parse(widget.initialUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Article')),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_loading)
            const Center(child: CircularProgressIndicator(color: Colors.blue)),
        ],
      ),
    );
  }
}
