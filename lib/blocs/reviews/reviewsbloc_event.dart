part of 'reviewsbloc_bloc.dart';

abstract class ReviewsblocEvent extends Equatable {
  const ReviewsblocEvent();

  @override
  List<Object> get props => [];
}
class FetchSpecificKitchenComments extends ReviewsblocEvent{
  final String id;

  FetchSpecificKitchenComments(this.id);
}