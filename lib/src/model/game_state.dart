import "package:freezed_annotation/freezed_annotation.dart";
import "package:the_guide/src/model/chapter.dart";
import "package:the_guide/src/model/story_intro.dart";

part "game_state.freezed.dart";

@freezed
abstract class GameState with _$GameState {
  const factory GameState({
    required StoryIntro intro,
    @Default([]) List<Chapter> completedChapters,
    String? characterName,
  }) = _GameState;
}
