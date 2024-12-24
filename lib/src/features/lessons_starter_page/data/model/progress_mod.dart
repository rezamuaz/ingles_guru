import 'package:freezed_annotation/freezed_annotation.dart';

part 'progress_mod.freezed.dart';

enum ProgressStatus { completed,uncompleted,todo }
@freezed
class ProgressMod with _$ProgressMod {
  factory ProgressMod({@Default(ProgressStatus.todo) final ProgressStatus? status}) = _ProgressMod;

}