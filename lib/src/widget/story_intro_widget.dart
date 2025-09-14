import "package:flutter/material.dart";
import "package:the_guide/src/model/story_intro.dart";
import "package:the_guide/src/utils/extension/number.dart";

class StoryIntroWidget extends StatefulWidget {
  const StoryIntroWidget({
    super.key,
    required this.intro,
    required this.onTap,
  });
  final StoryIntro intro;
  final Function(StoryIntro) onTap;

  @override
  State<StoryIntroWidget> createState() => _StoryIntroWidgetState();
}

class _StoryIntroWidgetState extends State<StoryIntroWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(widget.intro),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.intro.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Genre: ",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Text(
                          widget.intro.genre,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: _toggleExpanded,
                  icon: AnimatedRotation(
                    duration: const Duration(milliseconds: 300),
                    turns: isExpanded ? 180.turns() : 0.0,
                    child: const Icon(
                      Icons.arrow_drop_down,
                    ),
                  ),
                ),
              ],
            ),
            if (isExpanded) ...[
              const SizedBox(
                height: 8.0,
              ),
              Text(
                widget.intro.description,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.left,
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }
}
