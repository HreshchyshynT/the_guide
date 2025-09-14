import "package:dotenv/dotenv.dart";

class AppConfig {
  AppConfig._({
    required this.geminiApiKey,
  });

  static AppConfig? _instance;

  AppConfig get instance {
    final obj = _instance;
    if (obj == null) {
      throw Exception("AppConfig is not initialized");
    }
    return obj;
  }

  final String geminiApiKey;

  static void init() {
    final env = DotEnv()..load();
    final apiKey = env["GEMINI_KEY"];

    assert(apiKey != null, "gemini api key must be provided");

    _instance = AppConfig._(
      geminiApiKey: apiKey!,
    );
  }
}
