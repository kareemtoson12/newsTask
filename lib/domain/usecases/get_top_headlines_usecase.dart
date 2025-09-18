import 'package:news/data/models/api_result.dart';
import 'package:news/data/models/news_response.dart';
import 'package:news/domain/repo/domain_repo.dart';

class GetTopHeadlinesParams {
  final String country;
  final String category;
  const GetTopHeadlinesParams({required this.country, required this.category});
}

class GetTopHeadlinesUseCase {
  final DomainRepo _repo;
  GetTopHeadlinesUseCase(this._repo);

  Future<ApiResult<NewsResponse>> call(GetTopHeadlinesParams params) {
    return _repo.getTopHeadlines(
      country: params.country,
      category: params.category,
    );
  }
}
