import "package:flutter/material.dart";
import "package:flutter/services.dart";

class EditText extends StatelessWidget {
  const EditText({
    super.key,
    this.maxInputLength,
    this.autofocus = false,
    this.hintText,
    this.controller,
    this.textStyle,
    this.hintStyle,
    this.textCapitalization = TextCapitalization.words,
    this.textAlign = TextAlign.center,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.suffixIconColor,
    this.textAlignVertical = TextAlignVertical.center,
    this.autofillHints,
    this.textInputAction,
    this.onEditingComplete,
    this.contentPadding = EdgeInsets.zero,
    this.isDense = true,
    this.inputBorder = InputBorder.none,
    this.focusNode,
  });

  final int? maxInputLength;
  final bool autofocus;
  final String? hintText;
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final Color? suffixIconColor;
  final TextAlignVertical textAlignVertical;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;
  final EdgeInsets contentPadding;
  final bool isDense;
  final InputBorder inputBorder;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: [
        if (maxInputLength != null)
          LengthLimitingTextInputFormatter(maxInputLength),
      ],
      obscureText: obscureText,
      textAlign: textAlign,
      controller: controller,
      textCapitalization: textCapitalization,
      keyboardType: keyboardType,
      cursorRadius: const Radius.circular(4),
      style: textStyle,
      autofocus: autofocus,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: hintText,
        isDense: isDense,
        contentPadding: contentPadding,
        hintStyle: hintStyle,
        border: inputBorder,
        suffixIcon: suffixIcon,
        suffixIconColor: suffixIconColor,
      ),
      autofillHints: autofillHints,
      textInputAction: textInputAction,
      onEditingComplete: onEditingComplete,
      focusNode: focusNode,
    );
  }
}
