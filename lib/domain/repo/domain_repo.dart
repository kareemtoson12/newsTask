import 'package:news/data/models/api_result.dart';
import 'package:news/data/models/news_response.dart';

abstract class DomainRepo {
  Future<ApiResult<NewsResponse>> getTopHeadlines({
    required String country,
    required String category,
  });
}
