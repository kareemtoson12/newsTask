import 'package:dio/dio.dart';
import 'package:news/app/networking/dio_factory.dart';
import 'package:news/data/data_source/retrofit.dart';
import 'package:news/data/models/api_error.dart';
import 'package:news/data/models/api_result.dart';
import 'package:news/data/models/news_response.dart';
import 'package:news/domain/repo/domain_repo.dart';

class DomainRepoImpl implements DomainRepo {
  final AppServiceClient _client;

  DomainRepoImpl._(this._client);

  static Future<DomainRepoImpl> create() async {
    final dio = await DioFactory.createDio();
    final client = AppServiceClient(dio);
    return DomainRepoImpl._(client);
  }

  @override
  Future<ApiResult<NewsResponse>> getTopHeadlines({
    required String country,
    required String category,
  }) async {
    try {
      final res = await _client.getBusinessHeadlines(country, category);
      return ApiResult.success(res);
    } on DioException catch (e) {
      try {
        final data = e.response?.data;
        final err = data is Map<String, dynamic>
            ? ApiError.fromJson(data, statusCode: e.response?.statusCode)
            : ApiError.unknown(e.message);
        return ApiResult.failure(err);
      } catch (_) {
        return ApiResult.failure(ApiError.unknown(e.message));
      }
    } catch (e) {
      return ApiResult.failure(ApiError.unknown(e.toString()));
    }
  }
}
