part of 'kitchens_bloc.dart';

abstract class KitchensEvent extends Equatable {
  const KitchensEvent();

  @override
  List<Object> get props => [];
}



class FetchKitchens extends KitchensEvent{
  
}


class FetchSpecificKitchen extends KitchensEvent{
  final String slug;

  FetchSpecificKitchen(this.slug);
  
}



