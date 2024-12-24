import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_item.freezed.dart';
part 'payment_item.g.dart';

@freezed
class PaymentItem with _$PaymentItem {
  const factory PaymentItem({
    @Default("") @JsonKey(name: "order_id") final String orderId,
    @Default("") @JsonKey(name: "user_id") final String userId,
    @Default("") @JsonKey(name: "status") final String status,
    @Default("") @JsonKey(name: "payment_url") final String paymentUrl,
    @Default("") @JsonKey(name: "payment_method") final String paymentMethod,
    @Default(0) @JsonKey(name: "settlement") final int settlement,
    @Default(0) @JsonKey(name: "expired_at") final int expiredAt,
    @Default(0) @JsonKey(name: "updated_at") final int updatedAt,
    @Default(0) @JsonKey(name: "created_at") final int createdAt,
  }) = _PaymentItem;

  factory PaymentItem.fromJson(Map<String, dynamic> json) =>
      _$PaymentItemFromJson(json);
}

@freezed
class PurchaseMod with _$PurchaseMod {
  factory PurchaseMod({@Default([]) final List<PaymentItem> result}) =
      _PurchaseMod;

  factory PurchaseMod.fromJson(Map<String, dynamic> json) =>
      _$PurchaseModFromJson(json);
}
