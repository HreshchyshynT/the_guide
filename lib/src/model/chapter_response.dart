import "package:freezed_annotation/freezed_annotation.dart";
import "package:the_guide/src/ai/model/schema.dart";

part "chapter_response.freezed.dart";
part "chapter_response.g.dart";

@freezed
abstract class ChapterResponse with _$ChapterResponse {
  const factory ChapterResponse({
    required String narration,
    required List<String> choices,
  }) = _ChapterResponse;

  factory ChapterResponse.fromJson(Map<String, dynamic> json) =>
      _$ChapterResponseFromJson(json);

  static Schema get schema => Schema.object(
        properties: {
          "narration": Schema.string(
            description:
                "A string containing the next chapter of the story. This is the narrator's full, immersive description based on the player's last action",
            nullable: false,
          ),
          "choices": Schema.array(
            items: Schema.string(
              description:
                  "represents a distinct, actionable decision for the player to make next",
              nullable: false,
            ),
            description:
                "An array of **2–5** strings. Each string represents a distinct, actionable decision for the player to make next.",
            minItems: 2,
            maxItems: 5,
          ),
        },
        nullable: false,
        required: ["narration", "choices"],
        propertyOrdering: ["narration", "choices"],
      );
}
