part of 'mmo_bloc.dart';

abstract class MmoState extends Equatable {
  const MmoState();

  @override
  List<Object> get props => [];
}

class MMOLoadingState extends MmoState {
  @override
  List<Object> get props => [];
}

class MMOLoadedState extends MmoState {
  const MMOLoadedState(this.gms);
  final List<MmoGames> gms;

  @override
  List<Object> get props => [gms];
}

class MMOErrorState extends MmoState {
  final String errorMessage;
  const MMOErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
