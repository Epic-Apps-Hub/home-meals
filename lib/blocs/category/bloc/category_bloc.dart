import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_made/models/category.dart';
import 'package:home_made/repositories/kitchensRepo.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final KitechensRepo kitechensRepo;
  CategoryBloc(this.kitechensRepo) : super(CategoryInitial());

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    if (event is FetchCategories) {
      yield CategoryLoading();
      Category category = await kitechensRepo.getCategories();

     if (category == null) {
        yield CategoryLoadFailed();
      } else {
        yield CategoryLoaded(category);
      }
    }
  }
}
