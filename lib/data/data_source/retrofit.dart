import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:news/data/models/news_response.dart';

part 'retrofit.g.dart';

@RestApi(baseUrl: "https://newsapi.org/v2/")
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  /// get top headlines (business news in US)
  @GET("top-headlines")
  Future<NewsResponse> getBusinessHeadlines(
    @Query("country") String country,
    @Query("category") String category,
  );
}
