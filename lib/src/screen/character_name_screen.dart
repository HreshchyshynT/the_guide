import "package:flutter/material.dart";
import "package:the_guide/src/ai/ai_client.dart";
import "package:the_guide/src/common/prompts.dart";
import "package:the_guide/src/model/app_config.dart";
import "package:the_guide/src/model/story_intro.dart";
import "package:the_guide/src/widget/edit_text.dart";

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
        builder: (context) => CharacterNameScreen(
          intro: intro,
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
                  ? Text(story)
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
            EditText(
              hintText: "Enter your name",
              textInputAction: TextInputAction.done,
              controller: editTextController,
              onEditingComplete: () async {
                FocusScope.of(context).unfocus();
                final name = editTextController.text;
                // TODO: add min length limitation
                if (name.isEmpty) return;
                final confirmed = await _displayConfirmStartDialog(name);
                if (confirmed == true) {
                  // TODO: move on
                }
              },
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
          Prompts.getStoryIntroductionPrompt(widget.intro),
        )
        .then(
          (response) => setState(() {
            story = response;
          }),
          onError: (e) => setState(() {
            story = "Error: $e";
          }),
        );
  }
}
