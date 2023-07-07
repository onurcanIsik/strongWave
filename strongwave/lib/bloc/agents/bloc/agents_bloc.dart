import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:strongwave/core/service/valorant%20Service/valo_agents_response.dart';

import '../../../core/model/valorant/valo_agent_model.dart';

part 'agents_event.dart';
part 'agents_state.dart';

class AgentsBloc extends Bloc<AgentsEvent, AgentsState> {
  final ValorantAgentApi _valorantEventApi;
  AgentsBloc(this._valorantEventApi) : super(AgentsLoadingState()) {
    on<AgentsEvent>((event, emit) async {
      emit(AgentsLoadingState());

      try {
        final agents = await _valorantEventApi.fetchAgents();
        if (agents != null) {
          emit(AgentsLoadedState(agents));
        } else {
          emit(const AgentsErrorState('HATAA'));
        }
      } catch (err) {
        debugPrint("HATA3 : $err");
      }
    });
  }
}
