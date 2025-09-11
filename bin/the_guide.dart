import "dart:io";

import "package:args/args.dart";
import "package:dotenv/dotenv.dart";
import "package:the_guide/app_config.dart";
import "package:commander_ui/commander_ui.dart";

const String version = "0.0.1";

ArgParser buildParser() {
  return ArgParser()
    ..addFlag(
      "help",
      abbr: "h",
      negatable: false,
      help: "Print this usage information.",
    )
    ..addFlag(
      "verbose",
      abbr: "v",
      negatable: false,
      help: "Show additional command output.",
    )
    ..addFlag("version", negatable: false, help: "Print the tool version.");
}

void printUsage(ArgParser argParser) {
  print("Usage: dart the_guide.dart <flags> [arguments]");
  print(argParser.usage);
}

AppConfig _initAppConfig(ArgResults args) {
  final env = DotEnv()..load();
  final apiKey = env["GEMINI_KEY"];
  assert(apiKey != null, "gemini api key must be provided");
  bool verbose = false;
  if (args.flag("verbose")) {
    verbose = true;
  }
  return AppConfig(
    geminiApiKey: apiKey!,
    verbose: verbose,
  );
}

void runApp(AppConfig config) {
  final commander = Commander();
  final screen = commander.screen(title: "The Guide");

  try {
    screen.enter();
  } finally {
    screen.leave();
  }
}

void main(List<String> arguments) async {
  final ArgParser argParser = buildParser();
  late final AppConfig appConfig;
  try {
    final ArgResults results = argParser.parse(arguments);

    // Process the parsed arguments.
    if (results.flag("help")) {
      printUsage(argParser);
      return;
    }
    if (results.flag("version")) {
      print("the_guide version: $version");
      return;
    }
    appConfig = _initAppConfig(results);

    // Act on the arguments provided.
    print("Positional arguments: ${results.rest}");
    if (appConfig.verbose) {
      print("[VERBOSE] All arguments: ${results.arguments}");
    }
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print("");
    printUsage(argParser);
    return;
  }

  runApp(appConfig);
}
