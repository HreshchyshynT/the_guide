import "package:freezed_annotation/freezed_annotation.dart";
import "package:the_guide/src/ai/model/content.dart";

part "generate_content_response.freezed.dart";
part "generate_content_response.g.dart";

@freezed
abstract class GenerateContentResponse with _$GenerateContentResponse {
  @JsonSerializable(includeIfNull: false)
  const factory GenerateContentResponse({
    List<Candidate>? candidates,
    PromptFeedback? promptFeedback,
    UsageMetadata? usageMetadata,
  }) = _GenerateContentResponse;

  factory GenerateContentResponse.fromJson(Map<String, dynamic> json) =>
      _$GenerateContentResponseFromJson(json);
}

@freezed
abstract class Candidate with _$Candidate {
  @JsonSerializable(includeIfNull: false)
  const factory Candidate({
    Content? content,
    String? finishReason,
    int? index,
    List<SafetyRating>? safetyRatings,
  }) = _Candidate;

  factory Candidate.fromJson(Map<String, dynamic> json) =>
      _$CandidateFromJson(json);
}

@freezed
abstract class SafetyRating with _$SafetyRating {
  @JsonSerializable(includeIfNull: false)
  const factory SafetyRating({
    String? category,
    String? probability,
  }) = _SafetyRating;

  factory SafetyRating.fromJson(Map<String, dynamic> json) =>
      _$SafetyRatingFromJson(json);
}

@freezed
abstract class PromptFeedback with _$PromptFeedback {
  @JsonSerializable(includeIfNull: false)
  const factory PromptFeedback({
    String? blockReason,
    List<SafetyRating>? safetyRatings,
  }) = _PromptFeedback;

  factory PromptFeedback.fromJson(Map<String, dynamic> json) =>
      _$PromptFeedbackFromJson(json);
}

@freezed
abstract class UsageMetadata with _$UsageMetadata {
  @JsonSerializable(includeIfNull: false)
  const factory UsageMetadata({
    int? promptTokenCount,
    int? candidatesTokenCount,
    int? totalTokenCount,
  }) = _UsageMetadata;

  factory UsageMetadata.fromJson(Map<String, dynamic> json) =>
      _$UsageMetadataFromJson(json);
}
