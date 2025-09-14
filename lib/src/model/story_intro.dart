import "package:equatable/equatable.dart";

class StoryIntro extends Equatable {
  const StoryIntro({
    required this.title,
    required this.description,
    required this.genre,
  });

  final String title;
  final String description;
  final String genre;

  @override
  List<Object?> get props => [title, description, genre];

  @override
  bool? get stringify => true;
}
