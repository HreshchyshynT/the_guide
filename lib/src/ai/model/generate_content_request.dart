import "package:freezed_annotation/freezed_annotation.dart";
import "package:the_guide/src/ai/model/content.dart";

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
  }) = _GenerationConfig;

  factory GenerationConfig.fromJson(Map<String, dynamic> json) =>
      _$GenerationConfigFromJson(json);
}
