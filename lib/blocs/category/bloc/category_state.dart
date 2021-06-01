part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}


class CategoryLoaded extends CategoryState{
  final Category category;

  CategoryLoaded(this.category);
  
}

class CategoryLoading extends CategoryState{

}
class CategoryLoadFailed extends CategoryState{

}