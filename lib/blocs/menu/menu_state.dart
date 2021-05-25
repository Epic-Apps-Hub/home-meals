part of 'menu_bloc.dart';

abstract class MenuState extends Equatable {
  const MenuState();
  
  @override
  List<Object> get props => [];
}

class MenuInitial extends MenuState {}


class MenuLoading extends MenuState{

}


class MenuLoaded extends MenuState{
  final List<Cat> categories;

  MenuLoaded(this.categories);
}
class MenuError extends MenuState{

}