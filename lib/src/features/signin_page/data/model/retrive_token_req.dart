import 'package:freezed_annotation/freezed_annotation.dart';

part 'retrive_token_req.freezed.dart';
part 'retrive_token_req.g.dart';

@freezed
class RetriveTokenReq with _$RetriveTokenReq {

  factory RetriveTokenReq({
    final String? appId,
    final String? email
  }) = _RetriveTokenReq;

  factory RetriveTokenReq.fromJson(Map<String, dynamic> json) => _$RetriveTokenReqFromJson(json);
}