import "package:freezed_annotation/freezed_annotation.dart";
import "package:the_guide/src/ai/model/part.dart";

part "content.freezed.dart";
part "content.g.dart";

@freezed
abstract class Content with _$Content {
  const factory Content({
    required List<Part> parts,
    String? role,
  }) = _Content;

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
}
