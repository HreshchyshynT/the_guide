import "dart:convert";

import "package:collection/collection.dart";
import "package:file_saver/file_saver.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:the_guide/src/ai/ai_client.dart";
import "package:the_guide/src/ai/structured_wrapper.dart";
import "package:the_guide/src/model/app_config.dart";
import "package:the_guide/src/model/chapter.dart";
import "package:the_guide/src/model/chapter_response.dart";
import "package:the_guide/src/model/game_state.dart";
import "package:the_guide/src/prompt/story_context_builder.dart";
import "package:the_guide/src/prompt/system_prompt.dart";
import "package:the_guide/src/screen/welcome_screen.dart";
import "package:the_guide/src/widget/guide_progress_widget.dart";
import "package:the_guide/src/widget/llm_text_widget.dart";
import "package:the_guide/src/widget/user_options_widget.dart";

class ChapterScreen extends StatefulWidget {
  const ChapterScreen({super.key});

  static Future<void> pushReplacement(BuildContext context, GameState state) =>
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Provider.value(
            value: state,
            child: const ChapterScreen(),
          ),
        ),
      );

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  Future<ChapterResponse>? storyFuture;
  late final StructuredWrapper<ChapterResponse> aiClient;

  @override
  void initState() {
    super.initState();
    aiClient = StructuredWrapper<ChapterResponse>(
      aiClient: AiClient(
        apiKey: AppConfig.instance.geminiApiKey,
        systemInstruction: systemPrompt,
        structuredOutput: ChapterResponse.schema,
      ),
      adapter: ChapterResponse.fromJson,
    );

    _generateChapter();
  }

  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Chapter ${gameState.chaptersCount + 1}"),
        actions: [
          IconButton(
            onPressed: _saveStory,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: FutureBuilder(
        future: storyFuture,
        builder: (context, asyncSnapshot) {
          if (!asyncSnapshot.hasData) {
            return const Center(
              child: GuideProgressWidget(),
            );
          }
          if (asyncSnapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("error:\n${asyncSnapshot.error}"),
                ],
              ),
            );
          }
          final data = asyncSnapshot.data!;
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 12.0,
                  ),
                  child: LlmTextWidget(text: data.narration),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: data.choices.isNotEmpty
                    ? UserOptionsWidget(
                        options: data.choices,
                        onOptionSelected: _onOptionSelected,
                      )
                    : TextButton(
                        onPressed: _theEnd,
                        child: const Text("The end"),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _generateChapter() {
    final GameState gameState = context.read();
    final builder = StoryContextBuilder()..addIntro(gameState.intro);

    if (gameState.characterName != null) {
      builder.addCharacterName(gameState.characterName!);
    }
    gameState.chapters.forEachIndexed(builder.addChapter);

    storyFuture = aiClient.generateContent(builder.toString());
  }

  void _onOptionSelected(String option) async {
    final response = await storyFuture!;
    final chapter = Chapter(text: response.narration, userChoice: option);
    if (!mounted) return;
    final GameState gameState = context.read();
    gameState.addChapter(chapter);
    ChapterScreen.pushReplacement(context, gameState).ignore();
  }

  void _theEnd() async {
    final response = await storyFuture!;
    final chapter = Chapter(text: response.narration);
    if (!mounted) return;
    final GameState gameState = context.read();
    gameState.addChapter(chapter);

    WelcomeScreen.pushAsRoot(context).ignore();
  }

  void _saveStory() async {
    final response = await storyFuture!;
    final chapter = Chapter(text: response.narration);
    if (!mounted) return;
    final GameState gameState = context.read();
    gameState.addChapter(chapter);

    final builder = StoryContextBuilder()..addIntro(gameState.intro);

    if (gameState.characterName != null) {
      builder.addCharacterName(gameState.characterName!);
    }
    gameState.chapters.forEachIndexed(builder.addChapter);

    await FileSaver.instance
        .saveFile(
          name: gameState.intro.title,
          bytes: utf8.encode(builder.toString()),
          fileExtension: "txt",
          mimeType: MimeType.text,
        )
        .then(
          (_) => print("file saved"),
          onError: (e) => print("Saving file error: $e"),
        );
  }
}
