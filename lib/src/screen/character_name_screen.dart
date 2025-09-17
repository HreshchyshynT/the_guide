import "package:flutter/material.dart";
import "package:the_guide/src/model/story_intro.dart";

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

  @override
  void initState() {
    super.initState();
    _generateIntroduction();
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
        child: Center(
          child:
              story != null ? Text(story) : const CircularProgressIndicator(),
        ),
      ),
    );
  }

  void _generateIntroduction() {}
}
