part of 'dessert_bloc.dart';

abstract class DessertState extends Equatable {
  const DessertState();
  
  @override
  List<Object> get props => [];
}

class DessertInitial extends DessertState {}


class DessertLoading extends DessertState{

}


class DessertLoaded extends DessertState{
  final List<Kitchen> kitchens;

  DessertLoaded(this.kitchens);

}

class DessertFailed  extends DessertState{

}
