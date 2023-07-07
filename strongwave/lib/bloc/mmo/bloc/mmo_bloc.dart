// ignore_for_file: unnecessary_null_comparison

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:strongwave/core/model/mmoModel/mmo_models.dart';
import 'package:strongwave/core/service/mmo%20Service/mmo_service.dart';

part 'mmo_event.dart';
part 'mmo_state.dart';

class MmoBloc extends Bloc<MmoEvent, MmoState> {
  final MMOFetchApi mmoFetchApi;
  MmoBloc(this.mmoFetchApi) : super(MMOLoadingState()) {
    on<MmoEvent>((event, emit) async {
      emit(MMOLoadingState());

      try {
        final games = await mmoFetchApi.fetchMMO();

        if (games != null) {
          emit(MMOLoadedState(games));
        } else {
          emit(const MMOErrorState('HATA'));
        }
      } catch (err) {
        debugPrint('BIG DATA ERROR 2 $err');
      }
    });
  }
}
