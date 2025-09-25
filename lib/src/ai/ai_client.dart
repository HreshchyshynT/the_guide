import "dart:convert";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:the_guide/src/ai/model/content.dart";
import "package:the_guide/src/ai/model/generate_content_request.dart";
import "package:the_guide/src/ai/model/generate_content_response.dart";
import "package:the_guide/src/ai/model/part.dart";
import "package:the_guide/src/ai/model/schema.dart";

const _contentType = "application/json";

class AiClient {
  AiClient({
    required this.apiKey,
    this.systemInstruction,
    this.structuredOutput,
  });

  final String apiKey;
  final String? systemInstruction;
  final Schema? structuredOutput;

  Future<String> generateContent(String prompt) async {
    debugPrint("generating content");
    final request = GenerateContentRequest(
      contents: [
        Content(parts: [Part(text: prompt)]),
      ],
      systemInstruction: systemInstruction != null
          ? Content(parts: [Part(text: systemInstruction)])
          : null,
      generationConfig: GenerationConfig(
        thinkingConfig: const ThinkingConfig(
          thinkingBudget: 0,
        ),
        responseMimeType: structuredOutput != null ? "application/json" : null,
        responseSchema: structuredOutput,
      ),
    );
    final jsonRequest = jsonEncode(request.toJson());
    print("json request:\n$jsonRequest");
    final response = await http
        .post(
      getUrl(),
      headers: {
        "Content-type": _contentType,
        "x-goog-api-key": apiKey,
      },
      body: jsonRequest,
    )
        .then((response) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return GenerateContentResponse.fromJson(json);
    });

    debugPrint("content generated");

    // TODO: handle properly
    return response.candidates
            ?.firstWhere((e) => e.content?.parts.isNotEmpty ?? false)
            .content
            ?.parts
            .first
            .text ??
        "No response";
  }

  Uri getUrl({
    String model = "gemini-2.5-flash",
  }) =>
      Uri.parse(
        "https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent",
      );
}
