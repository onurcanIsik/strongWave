part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();
  @override
  List<Object> get props => [];
}

class NewsLoadingState extends NewsState {
  @override
  List<Object> get props => [];
}

class NewsLoadedState extends NewsState {
  const NewsLoadedState(this.news);
  final List<Datum> news;

  @override
  List<Object> get props => [news];
}

class NewsErrorState extends NewsState {
  final String errorMessage;
  const NewsErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
