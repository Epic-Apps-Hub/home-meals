part of 'near_bloc.dart';

abstract class NearState extends Equatable {
  const NearState();

  @override
  List<Object> get props => [];
}

class NearInitial extends NearState {}

class NearLoading extends NearState {}

class NearLoaded extends NearState {
  final List<Kitchen> kitchens;

  NearLoaded(this.kitchens);
}

class NearFailed extends NearState {}

class NearEmpty extends NearState {}
