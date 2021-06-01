part of 'popular_bloc.dart';

abstract class PopularState extends Equatable {
  const PopularState();

  @override
  List<Object> get props => [];
}

class PopularInitial extends PopularState {}

class PopularLoading extends PopularState {}

class PopularLoaded extends PopularState {
  final List<Kitchen> kitchens;

  PopularLoaded(this.kitchens);
}

class PopularFailed extends PopularState {}


class PopularEmpty extends PopularState{}