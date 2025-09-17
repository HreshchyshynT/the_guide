import "package:freezed_annotation/freezed_annotation.dart";

part "part.freezed.dart";
part "part.g.dart";

@freezed
abstract class Part with _$Part {
  const factory Part({
    String? text,
  }) = _Part;

  factory Part.fromJson(Map<String, dynamic> json) => _$PartFromJson(json);
}

