part of 'discount_bloc.dart';

abstract class DiscountState extends Equatable {
  const DiscountState();
  
  @override
  List<Object> get props => [];
}

class DiscountInitial extends DiscountState {}

class DiscountLoading extends DiscountState {}

class DiscountLoaded extends DiscountState {
    final List<Kitchen> kitchens;

  DiscountLoaded(this.kitchens);

}
class DiscountFailed extends DiscountState {}