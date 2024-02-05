part of 'discount_bloc.dart';

class DiscountEvent {}

class GetStartDiscount extends DiscountEvent {}

class GetMoreDiscount extends DiscountEvent {}

class ChangeSelectedDiscount extends DiscountEvent {
  final Discount? disocunt;
  ChangeSelectedDiscount({required this.disocunt});
}

class ChangeTitle extends DiscountEvent {
  final String value;
  ChangeTitle({required this.value});
}

class ChangeImage extends DiscountEvent {
  final List<int> value;
  ChangeImage({required this.value});
}

class ChangeDiscount extends DiscountEvent {
  final double value;
  ChangeDiscount({required this.value});
}

class ChangeDiscountItem extends DiscountEvent {
  final int id;
  ChangeDiscountItem({required this.id});
}

class AddDiscount extends DiscountEvent {}

class DeleteDiscount extends DiscountEvent {
  final int id;
  DeleteDiscount({required this.id});
}

class UpdateDiscount extends DiscountEvent {}
