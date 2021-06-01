part of 'dessert_bloc.dart';

abstract class DessertEvent extends Equatable {
  const DessertEvent();

  @override
  List<Object> get props => [];
}


class FetchDessert extends DessertEvent{
  
}