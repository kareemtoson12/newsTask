import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:news/app/networking/dio_factory.dart';
import 'package:news/data/data_source/retrofit.dart';
import 'package:news/data/repo/domain_repo_impl.dart';
import 'package:news/domain/usecases/get_top_headlines_usecase.dart';
import 'package:news/presentation/home/cubit/home_cubit.dart';
import 'package:news/presentation/article_detail/cubit/article_detail_cubit.dart';

final GetIt getIt = GetIt.instance;

void initServiceLocator() {
  // Network layer
  getIt.registerSingletonAsync<Dio>(() async => DioFactory.createDio());
  getIt.registerSingletonWithDependencies<AppServiceClient>(
    () => AppServiceClient(getIt<Dio>()),
    dependsOn: [Dio],
  );

  // Repos / Use cases
  getIt.registerSingletonWithDependencies<DomainRepoImpl>(
    () => DomainRepoImpl.fromClient(getIt<AppServiceClient>()),
    dependsOn: [AppServiceClient],
  );
  getIt.registerSingletonWithDependencies<GetTopHeadlinesUseCase>(
    () => GetTopHeadlinesUseCase(getIt<DomainRepoImpl>()),
    dependsOn: [DomainRepoImpl],
  );

  // Cubits
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(getIt<GetTopHeadlinesUseCase>()),
  );
  getIt.registerFactory<ArticleDetailCubit>(() => ArticleDetailCubit());
}
