part of 'news_paper_bloc.dart';

abstract class NewsPaperState extends Equatable {
  const NewsPaperState();

  @override
  List<Object> get props => [];
}

class NewsPaperLoadingState extends NewsPaperState {
  @override
  List<Object> get props => [];
}

class NewsPaperLoadedState extends NewsPaperState {
  const NewsPaperLoadedState(this.article);

  final List<Article> article;
  @override
  List<Object> get props => [article];
}

class NewsPaperErrorState extends NewsPaperState {
  const NewsPaperErrorState(this.errorMessage);
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
