import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_made/blocs/popular/popular_bloc.dart';
import 'package:home_made/models/kitchen.dart';
import 'package:home_made/repositories/kitchensRepo.dart';

part 'near_event.dart';
part 'near_state.dart';

class NearBloc extends Bloc<NearEvent, NearState> {  final KitechensRepo kitechensRepo;

  NearBloc(this.kitechensRepo) : super(NearInitial());

  @override
  Stream<NearState> mapEventToState(
    NearEvent event,
  ) async* {if(event is NearFetch){
    yield NearLoading();
        List<Kitchen> items = await kitechensRepo.getNearKitchens();
  if (items == null) {
      yield NearFailed();
    } else if (items.length == 0) {
      yield NearEmpty();
    } else {
      yield NearLoaded(items);
    }
  }

    // TODO: implement mapEventToState
  }
}
