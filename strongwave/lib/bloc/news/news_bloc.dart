import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:strongwave/core/model/valorant/valorant_events_model.dart';
import 'package:strongwave/core/service/valorant%20Service/valo_event_response.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final ValorantEventApi _valorantEventApi;
  NewsBloc(this._valorantEventApi) : super(NewsLoadingState()) {
    on<NewsEvent>((event, emit) async {
      emit(NewsLoadingState());
      try {
        final news = await _valorantEventApi.fetchEvent();
        if (news != null) {
          emit(NewsLoadedState(news));
        } else {
          emit(const NewsErrorState('HATA'));
        }
      } catch (err) {
        debugPrint("HATA2 : $err");
      }
    });
  }
}
