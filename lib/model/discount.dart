import 'package:freezed_annotation/freezed_annotation.dart';

part 'discount.freezed.dart';
part 'discount.g.dart';

@freezed
class Discount with _$Discount {
  factory Discount({
    required int id,
    required String title,
    required String image,
    @JsonKey(name: "discount_percentage") required int discountPercentage,
    @JsonKey(name: "discount_items") List<Map<String, dynamic>>? discountItems,
  }) = _Discount;
  factory Discount.fromJson(Map<String, dynamic> json) =>
      _$DiscountFromJson(json);
}
