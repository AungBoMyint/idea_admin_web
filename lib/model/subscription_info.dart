import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_info.freezed.dart';
part 'subscription_info.g.dart';

@freezed
class SubscriptionInfo with _$SubscriptionInfo {
  factory SubscriptionInfo({
    @JsonKey(name: "expiration_date") required DateTime expirationDate,
    @JsonKey(name: "day_left") required double dayLeft,
    @JsonKey(name: "minute_left") required double minuteLeft,
    @JsonKey(name: "is_expired") required bool isExpired,
  }) = _SubscriptionInfo;
  factory SubscriptionInfo.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionInfoFromJson(json);
}
