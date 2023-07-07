part of 'agents_bloc.dart';

abstract class AgentsState extends Equatable {
  const AgentsState();

  @override
  List<Object> get props => [];
}

class AgentsLoadingState extends AgentsState {
  @override
  List<Object> get props => [];
}

class AgentsLoadedState extends AgentsState {
  const AgentsLoadedState(this.agents);
  final List<Datum> agents;

  @override
  List<Object> get props => [agents];
}

class AgentsErrorState extends AgentsState {
  final String errorMessage;
  const AgentsErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
