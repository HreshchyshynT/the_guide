import "package:freezed_annotation/freezed_annotation.dart";

part "app_config.freezed.dart";

@freezed
class AppConfig with _$AppConfig {
  const AppConfig({
    required this.geminiApiKey,
    this.verbose = false,
  });

  @override
  final String geminiApiKey;
  @override
  final bool verbose;
}
