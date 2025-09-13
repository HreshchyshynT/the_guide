import "package:flutter/material.dart";

class TypingTextWidget extends StatefulWidget {
  const TypingTextWidget(this.text, {super.key});
  final String text;

  @override
  State<TypingTextWidget> createState() => _TypingTextWidgetState();
}

class _TypingTextWidgetState extends State<TypingTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text);
  }
}
