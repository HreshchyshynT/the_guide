import "package:equatable/equatable.dart";

class Chapter extends Equatable {
  const Chapter({
    required this.text,
    required this.userChoice,
  });

  final String text;
  final String? userChoice;

  @override
  List<Object?> get props => [text, userChoice];
}
