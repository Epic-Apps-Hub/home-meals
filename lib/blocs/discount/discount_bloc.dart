import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_made/models/kitchen.dart';
import 'package:home_made/repositories/kitchensRepo.dart';

part 'discount_event.dart';
part 'discount_state.dart';

class DiscountBloc extends Bloc<DiscountEvent, DiscountState> {  final KitechensRepo kitechensRepo;

  DiscountBloc(this.kitechensRepo) : super(DiscountInitial());

  @override
  Stream<DiscountState> mapEventToState(
    DiscountEvent event,
  ) async* {
    if(event is FetchDiscounts){
      yield DiscountLoading();
          List<Kitchen> items = await kitechensRepo.getDiscount();
          if(items==null){
            yield DiscountFailed();
          }else{
            yield DiscountLoaded(items);
          }

    }
  }
}
