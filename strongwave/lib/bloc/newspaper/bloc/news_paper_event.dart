part of 'news_paper_bloc.dart';

abstract class NewsPaperEvent extends Equatable {
  const NewsPaperEvent();
}

class LoadNewsPaperEvent extends NewsPaperEvent {
  @override
  List<Object?> get props => [];
}
