import "package:the_guide/src/model/chapter.dart";
import "package:the_guide/src/model/story_intro.dart";

class GameState {
  GameState({
    required this.intro,
    this.characterName,
    List<Chapter> completedChapters = const [],
  }) : _chapters = completedChapters;

  final StoryIntro intro;
  final List<Chapter> _chapters;

  String? characterName;

  List<Chapter> get chapters => List.unmodifiable(_chapters);

  int get chaptersCount => _chapters.length;
}
