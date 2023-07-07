import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:strongwave/core/model/newsPaper/news_paper.dart';
import 'package:strongwave/core/service/news%20Paper%20Service/news_paper_service.dart';

part 'news_paper_event.dart';
part 'news_paper_state.dart';

class NewsPaperBloc extends Bloc<NewsPaperEvent, NewsPaperState> {
  final NewsPaperApi newsPaperApi;
  NewsPaperBloc(this.newsPaperApi) : super(NewsPaperLoadingState()) {
    on<NewsPaperEvent>((event, emit) async {
      emit(NewsPaperLoadingState());

      try {
        final newsPaper = await newsPaperApi.fetchNewsPaper();
        emit(NewsPaperLoadedState(newsPaper as List<Article>));
      } catch (err) {
        emit(const NewsPaperErrorState('BLOC HATA 2'));
        debugPrint('BLOC HATA $err');
      }
    });
  }
}
