import "package:http/http.dart" as http;

const _contentType = "application/json";

class AiClient {
  AiClient({
    required this.apiKey,
  });

  final String apiKey;

  Future<String> generateContent(String prompt) async {
    final response = await http.post(
      getUrl(),
      headers: {
        "Content-type": _contentType,
        "x-goog-api-key": apiKey,
      },
      body: {
        "contents": [
          {
            "parts": [
              {
                "text": prompt,
              },
            ],
          },
        ],
      },
    );
    return response.body;
  }

  Uri getUrl({
    String model = "gemini-2.5-flash",
  }) =>
      Uri.parse(
        "https://generativelanguage.googleapis.com/v1beta/models/model:generateContent",
      );
}
