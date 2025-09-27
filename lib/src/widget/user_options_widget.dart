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
    final rows = <Widget>[];
    int i = 0;
    final options = widget.options;
    while (i < options.length) {
      rows.add(
        IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _OptionTextWidget(
                  text: options[i++],
                  onTap: widget.onOptionSelected,
                ),
              ),
              if (i < options.length)
                Expanded(
                  child: _OptionTextWidget(
                    text: options[i++],
                    onTap: widget.onOptionSelected,
                  ),
                ),
            ],
          ),
        ),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: rows,
    );
  }
}

class _OptionTextWidget extends StatelessWidget {
  const _OptionTextWidget({
    required this.text,
    required this.onTap,
  });

  final String text;
  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(text),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 12.0,
        ),
        margin: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(border: BoxBorder.all()),
        child: Text(
          text,
        ),
      ),
    );
  }
}
