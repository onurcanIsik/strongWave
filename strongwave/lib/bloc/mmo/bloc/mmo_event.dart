part of 'mmo_bloc.dart';

abstract class MmoEvent extends Equatable {
  const MmoEvent();
}

class LoadMMOEvent extends MmoEvent {
  @override
  List<Object?> get props => [];
}
