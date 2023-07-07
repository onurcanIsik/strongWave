part of 'agents_bloc.dart';

abstract class AgentsEvent extends Equatable {
  const AgentsEvent();
}

class LoadAgentEvent extends AgentsEvent {
  @override
  List<Object?> get props => [];
}
