import "package:the_guide/src/model/chapter.dart";
import "package:the_guide/src/model/story_intro.dart";

/// Example of the story context:
/// ### STORY PREMISE
/// Title: {intro.title}
/// Genre: {intro.genre}
/// Premise: {intro.description}
///
/// ### PROTAGONIST
/// Name: {characterName}
///
/// ---
///
/// ### TURN 1: NARRATION
/// {LLM's first output, the introduction}
///
/// ### TURN 1: PLAYER CHOICE
/// {Player's first choice, which will always be implied as "Start the adventure." You can even hardcode this.}
///
/// ---
///
/// ### TURN 2: NARRATION
/// {LLM's output for the next chapter}
///
/// ### TURN 2: PLAYER CHOICE
/// {The choice the player made, e.g., "[1] Investigate the strange glowing symbol on the wall."}
///
/// ---
///
/// ### TURN 3: NARRATION
/// {...and so on...}
class StoryContextBuilder {
  final StringBuffer _buffer = StringBuffer();

  void addCharacterName(String name) => _buffer
    ..writeln("### PROTAGONIST")
    ..writeln("Name: $name")
    ..divider();

  void addIntro(StoryIntro intro) {
    _buffer
      ..writeln("### STORY PREMISE")
      ..writeln("Title: ${intro.title}")
      ..writeln("Genre: ${intro.genre}")
      ..writeln("Premise: ${intro.description}")
      ..divider();
  }

  void addChapter(int number, Chapter chapter) => _buffer
    ..writeln("### TURN $number: NARRATION")
    ..writeln(chapter.text)
    ..writeln()
    ..writeln("### TURN $number: PLAYER CHOICE")
    ..writeln(chapter.userChoice)
    ..divider();

  @override
  String toString() => _buffer.toString();

  void clear() => _buffer.clear();
}

extension _BufferExt on StringBuffer {
  void divider() => this
    ..writeln()
    ..writeln("---")
    ..writeln();
}
