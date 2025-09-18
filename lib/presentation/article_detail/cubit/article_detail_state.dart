import 'package:equatable/equatable.dart';

abstract class ArticleDetailState extends Equatable {
  const ArticleDetailState();
  @override
  List<Object?> get props => [];
}

class ArticleDetailInitial extends ArticleDetailState {
  const ArticleDetailInitial();
}

class ArticleDetailLaunching extends ArticleDetailState {
  const ArticleDetailLaunching();
}

class ArticleDetailLaunched extends ArticleDetailState {
  const ArticleDetailLaunched();
}

class ArticleDetailError extends ArticleDetailState {
  final String message;
  const ArticleDetailError(this.message);
  @override
  List<Object?> get props => [message];
}
