import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_made/models/kitchen.dart';
import 'package:home_made/repositories/kitchensRepo.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  final KitechensRepo kitechensRepo;

  PopularBloc(this.kitechensRepo) : super(PopularInitial());

  @override
  Stream<PopularState> mapEventToState(
    PopularEvent event,
  ) async* {if(event is FetchPopular){
   yield PopularLoading();
    List<Kitchen> items = await kitechensRepo.getPopularKitchens();
    if (items == null) {
      yield PopularFailed();
    } else if (items.length == 0) {
      yield PopularEmpty();
    } else {
      yield PopularLoaded(items);
    }
  }
 
  }
}
