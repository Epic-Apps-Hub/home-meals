import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:home_made/models/kitchen.dart';
import 'package:home_made/models/rating.dart';
import 'package:home_made/models/specificKitchen.dart';
import 'package:home_made/repositories/kitchensRepo.dart';

part 'kitchens_event.dart';
part 'kitchens_state.dart';

class KitchensBloc extends Bloc<KitchensEvent, KitchensState> {
  final KitechensRepo kitechensRepo;

  KitchensBloc(this.kitechensRepo) : super(KitchensInitial());

  @override
  Stream<KitchensState> mapEventToState(
    KitchensEvent event,
  ) async* {
    if (event is FetchKitchens) {
      yield KitchensLoading();
      List<Kitchen> items = await kitechensRepo.getAllKitchens();
      print("items are $items");
      if (items == null) {
        yield KitchenLoadFailed("an error occured");
      } else {
        yield KitchensLoaded(items);
      }
    }
    if (event is FetchSpecificKitchen) {
      yield KitchensLoading();
      SpecificKitchen specificKitchen =
          await kitechensRepo.getSpecificKitchen(event.slug);
      if (specificKitchen == null) {
        yield KitchenLoadFailed("an error occured");
      } else {
        yield KitchenLoaded(specificKitchen);
      }
    }
  
  }
}
