import "package:flutter/material.dart";

class UserOptionsWidget extends StatefulWidget {
  const UserOptionsWidget({
    super.key,
    required this.options,
    required this.onOptionSelected,
  });

  final List<String> options;
  final Function(String) onOptionSelected;

  @override
  State<UserOptionsWidget> createState() => _UserOptionsWidgetState();
}

class _UserOptionsWidgetState extends State<UserOptionsWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: widget.options.map((e) => _OptionTextWidget(e)).toList(),
    );
  }
}

class _OptionTextWidget extends StatelessWidget {
  const _OptionTextWidget(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
    );
  }
}
