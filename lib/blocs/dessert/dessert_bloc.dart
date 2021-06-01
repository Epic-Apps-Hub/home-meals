import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_made/models/kitchen.dart';
import 'package:home_made/repositories/kitchensRepo.dart';

part 'dessert_event.dart';
part 'dessert_state.dart';

class DessertBloc extends Bloc<DessertEvent, DessertState> {
    final KitechensRepo kitechensRepo;

  DessertBloc(this.kitechensRepo) : super(DessertInitial());

  @override
  Stream<DessertState> mapEventToState(
    DessertEvent event,
  ) async* {
    yield DessertLoading();
        List<Kitchen> items = await kitechensRepo.getDessert();
    if (items == null) {yield DessertFailed();

    }else{
yield DessertLoaded(items);
    }
  }
}
