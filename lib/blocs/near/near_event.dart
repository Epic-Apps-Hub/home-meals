part of 'near_bloc.dart';

abstract class NearEvent extends Equatable {
  const NearEvent();

  @override
  List<Object> get props => [];
}


class NearFetch extends NearEvent{}