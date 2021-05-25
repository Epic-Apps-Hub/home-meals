import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_made/models/rating.dart';
import 'package:home_made/repositories/kitchensRepo.dart';

part 'reviewsbloc_event.dart';
part 'reviewsbloc_state.dart';

class ReviewsblocBloc extends Bloc<ReviewsblocEvent, ReviewsblocState> {
  final KitechensRepo kitechensRepo;
  ReviewsblocBloc(this.kitechensRepo) : super(ReviewsblocInitial());

  @override
  Stream<ReviewsblocState> mapEventToState(
    ReviewsblocEvent event,
  ) async* {
      if (event is FetchSpecificKitchenComments) {
        yield ReviewsLoading();
      Rating rating = await kitechensRepo.getSpecificKitchenRating(event.id);
      if (rating == null) {
        yield ReviewsFailed();
      } else {
        yield ReviewsFetched(rating);
      }
    }
  }
}
