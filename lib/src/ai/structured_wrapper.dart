import "dart:convert";

import "package:the_guide/src/ai/ai_client.dart";

typedef Mapper<R> = R Function(Map<String, dynamic> json);

class StructuredWrapper<R> {
  StructuredWrapper({
    required Mapper<R> adapter,
    required AiClient aiClient,
  })  : _adapter = adapter,
        _aiClient = aiClient;

  final AiClient _aiClient;
  final Mapper<R> _adapter;

  Future<R> generateContent(String prompt) async {
    try {
      final result = await _aiClient.generateContent(prompt);
      print("result received");
      final json = jsonDecode(result);
      print("decoded");
      return _adapter(json);
    } catch (e) {
      print("error: $e");
      rethrow;
    }
  }
}
