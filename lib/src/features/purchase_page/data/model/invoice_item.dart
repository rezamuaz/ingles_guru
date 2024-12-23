import 'package:freezed_annotation/freezed_annotation.dart';

part 'invoice_item.freezed.dart';
part 'invoice_item.g.dart';

@freezed
class InvoiceItem with _$InvoiceItem {
  factory InvoiceItem({
    @Default("") @JsonKey(name: "invoice_id") final String invoiceId,
    @Default("") @JsonKey(name: "order_id") final String orderId,
    @Default("") @JsonKey(name: "user_id") final String userId,
    @Default("") @JsonKey(name: "invoice_url") final String invoiceUrl,
    @Default("") @JsonKey(name: "payment_method") final String paymentMethod,
    @Default(0) @JsonKey(name: "settlement") final int settlement,
    @Default("") @JsonKey(name: "ref") final String ref,
    @Default(0) @JsonKey(name: "updated_at") final int updatedAt,
    @Default(0) @JsonKey(name: "created_at") final int createdAt,
  }) = _InvoiceItem;

  factory InvoiceItem.fromJson(Map<String, dynamic> json) =>
      _$InvoiceItemFromJson(json);
}
