part of 'kitchens_bloc.dart';

abstract class KitchensState extends Equatable {
  const KitchensState();
  
  @override
  List<Object> get props => [];
}

class KitchensInitial extends KitchensState {}

class KitchensLoading extends KitchensState{}

class KitchensLoaded extends KitchensState{
  final List<Kitchen> kitchens;

  KitchensLoaded(this.kitchens);
}

class KitchenLoaded extends KitchensState{
final SpecificKitchen kitchen;

  KitchenLoaded(this.kitchen);
}

class KitchenLoadFailed extends KitchensState{
  final String message;

  KitchenLoadFailed(this.message);
}


