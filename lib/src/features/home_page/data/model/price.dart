import 'package:freezed_annotation/freezed_annotation.dart';

part 'price.freezed.dart';
part 'price.g.dart';

@freezed
class Price with _$Price {

  factory Price({
     String? id,
  String? name,
  int? price,
  String? tag

  }) = _Price;

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
}