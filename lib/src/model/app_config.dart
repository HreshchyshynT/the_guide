import "package:flutter_dotenv/flutter_dotenv.dart";

class AppConfig {
  AppConfig._({
    required this.geminiApiKey,
  });

  static AppConfig? _instance;

  static AppConfig get instance {
    final obj = _instance;
    if (obj == null) {
      throw Exception("AppConfig is not initialized");
    }
    return obj;
  }

  final String geminiApiKey;

  static void init() async {
    await dotenv.load();
    const apiKey = String.fromEnvironment("GEMINI_KEY");

    assert(apiKey.isNotEmpty, "gemini api key must be provided");

    _instance = AppConfig._(
      geminiApiKey: apiKey,
    );
  }
}
