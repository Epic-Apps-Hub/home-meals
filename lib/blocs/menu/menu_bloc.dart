import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_made/models/cat.dart';
import 'package:home_made/repositories/kitchensRepo.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final KitechensRepo kitechensRepo;
  MenuBloc(this.kitechensRepo) : super(MenuInitial());

  @override
  Stream<MenuState> mapEventToState(
    MenuEvent event,
  ) async* {
    if (event is FetchMenu) {
      yield MenuLoading();
      var categories = await kitechensRepo.getKitchenMenu(event.slug);
      if (categories == null) {
        yield MenuError();
      } else {
        yield MenuLoaded(categories);
      }
    }
  }
}
