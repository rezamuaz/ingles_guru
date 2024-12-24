import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_created.freezed.dart';
part 'payment_created.g.dart';

@freezed
class PaymentCreated with _$PaymentCreated {
  factory PaymentCreated(
          {@Default("") @JsonKey(name: "order_id") final String orderId,
          @Default("") @JsonKey(name: "user_id") final String userId,
          @Default("") @JsonKey(name: "payment_url") final String paymentUrl,
          @Default(0) @JsonKey(name: "created_at") final int createdAt}) =
      _PaymentCreated;

  factory PaymentCreated.fromJson(Map<String, dynamic> json) =>
      _$PaymentCreatedFromJson(json);
}
