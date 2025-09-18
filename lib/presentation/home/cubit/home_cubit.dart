import 'package:bloc/bloc.dart';
import 'package:news/domain/usecases/get_top_headlines_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetTopHeadlinesUseCase _getTopHeadlines;

  HomeCubit(this._getTopHeadlines) : super(const HomeInitial());

  Future<void> loadHeadlines({
    String country = 'us',
    String category = 'business',
  }) async {
    emit(const HomeLoading());
    final result = await _getTopHeadlines(
      GetTopHeadlinesParams(country: country, category: category),
    );
    if (result.isSuccess) {
      emit(HomeLoaded(result.data!.articles));
    } else {
      emit(HomeError(result.error?.message ?? 'Unknown error'));
    }
  }
}
