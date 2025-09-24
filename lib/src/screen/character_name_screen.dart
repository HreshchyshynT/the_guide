import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:the_guide/src/ai/ai_client.dart";
import "package:the_guide/src/prompt/intro_prompt.dart";
import "package:the_guide/src/model/app_config.dart";
import "package:the_guide/src/model/game_state.dart";
import "package:the_guide/src/model/story_intro.dart";
import "package:the_guide/src/widget/edit_text.dart";
import "package:the_guide/src/widget/guide_progress_widget.dart";
import "package:the_guide/src/widget/llm_text_widget.dart";

class CharacterNameScreen extends StatefulWidget {
  const CharacterNameScreen({
    super.key,
    required this.intro,
  });
  final StoryIntro intro;

  static Future<void> pushReplacement(
    BuildContext context, {
    required StoryIntro intro,
  }) {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => Provider(
          create: (_) => GameState(intro: intro),
          child: CharacterNameScreen(
            intro: intro,
          ),
        ),
      ),
    );
  }

  @override
  State<CharacterNameScreen> createState() => _CharacterNameScreenState();
}

class _CharacterNameScreenState extends State<CharacterNameScreen> {
  String? story;
  late final TextEditingController editTextController = TextEditingController();

  final FocusNode editTextFocusNode = FocusNode();

  bool isInputVisible = false;

  @override
  void initState() {
    super.initState();
    _generateIntroduction();
  }

  @override
  void dispose() {
    editTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final story = this.story;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.intro.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24.0,
          horizontal: 40.0,
        ),
        child: Column(
          children: [
            Expanded(
              child: story != null
                  ? LlmTextWidget(text: story)
                  : const Center(
                      child: GuideProgressWidget(),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 24.0,
              ),
              child: SizedBox(
                width: 240.0,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: isInputVisible ? 1.0 : 0.0,
                  child: EditText(
                    hintText: "Enter your name",
                    textInputAction: TextInputAction.done,
                    controller: editTextController,
                    contentPadding: const EdgeInsets.all(16.0),
                    focusNode: editTextFocusNode,
                    inputBorder: const OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    onEditingComplete: () async {
                      editTextFocusNode.unfocus();
                      final name = editTextController.text;
                      // TODO: add min length limitation
                      if (name.isEmpty) return;
                      final confirmed = await _displayConfirmStartDialog(name);
                      if (confirmed == true) {
                        // TODO: move on
                      } else {
                        editTextFocusNode.requestFocus();
                        _requestFocus().ignore();
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _displayConfirmStartDialog(String name) => showDialog<bool>(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
          title: Text("$name, let's start?"),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text("Not yet"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        ),
      );

  void _generateIntroduction() {
    final client = AiClient(apiKey: AppConfig.instance.geminiApiKey);
    client
        .generateContent(
      getStoryIntroPrompt(widget.intro),
    )
        .then(
      (response) async {
        setState(() {
          story = response;
        });
        await Future.delayed(const Duration(seconds: 5));
        setState(() {
          isInputVisible = true;
          editTextFocusNode.requestFocus();
        });
      },
      onError: (e) => setState(() {
        story = "Error: $e";
      }),
    );
  }

  Future<void> _requestFocus() async {
    editTextFocusNode.requestFocus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      editTextController.selection =
          TextSelection.collapsed(offset: editTextController.text.length);
    });
  }
}
