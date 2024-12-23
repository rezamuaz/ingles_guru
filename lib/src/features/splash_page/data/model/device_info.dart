import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_info.freezed.dart';
part 'device_info.g.dart';

@freezed
class DeviceInfo with _$DeviceInfo {

  factory DeviceInfo({
    final String? id,
    final String? deviceOs,
  }) = _DeviceInfo;

  factory DeviceInfo.fromJson(Map<String, dynamic> json) => _$DeviceInfoFromJson(json);
}