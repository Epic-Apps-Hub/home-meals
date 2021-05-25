part of 'reviewsbloc_bloc.dart';

abstract class ReviewsblocState extends Equatable {
  const ReviewsblocState();
  
  @override
  List<Object> get props => [];
}

class ReviewsblocInitial extends ReviewsblocState {}

class ReviewsFetched extends ReviewsblocState{
  final Rating rating;

  ReviewsFetched(this.rating);
}

class ReviewsFailed extends ReviewsblocState{
  
}
class ReviewsLoading extends ReviewsblocState{
  
}
