part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];
}


class FetchMenu extends MenuEvent{
  final String slug;

  FetchMenu(this.slug);
}