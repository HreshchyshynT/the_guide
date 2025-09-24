import "package:freezed_annotation/freezed_annotation.dart";
import "package:the_guide/src/ai/model/content.dart";
import "package:the_guide/src/ai/model/schema.dart";

part "generate_content_request.freezed.dart";
part "generate_content_request.g.dart";

@freezed
abstract class GenerateContentRequest with _$GenerateContentRequest {
  const factory GenerateContentRequest({
    required List<Content> contents,
    Content? systemInstruction,
    GenerationConfig? generationConfig,
  }) = _GenerateContentRequest;

  factory GenerateContentRequest.fromJson(Map<String, dynamic> json) =>
      _$GenerateContentRequestFromJson(json);
}

@freezed
abstract class GenerationConfig with _$GenerationConfig {
  const factory GenerationConfig({
    int? candidateCount,
    List<String>? stopSequences,
    double? temperature,
    int? maxOutputTokens,
    double? topP,
    int? topK,
    ThinkingConfig? thinkingConfig,
    String? responseMimeType,
    Schema? responseSchema,
  }) = _GenerationConfig;

  factory GenerationConfig.fromJson(Map<String, dynamic> json) =>
      _$GenerationConfigFromJson(json);
}

@freezed
abstract class ThinkingConfig with _$ThinkingConfig {
  const factory ThinkingConfig({
    bool? includeThoughts,
    int? thinkingBudget,
  }) = _ThinkingConfig;

  factory ThinkingConfig.fromJson(Map<String, dynamic> json) =>
      _$ThinkingConfigFromJson(json);
}
