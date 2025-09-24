import "package:flutter/material.dart";

class LlmTextWidget extends StatelessWidget {
  const LlmTextWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
