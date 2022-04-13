import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatelessWidget {
  Input(
      {Key? key,
      this.labelText,
      this.validator,
      this.onSave,
      this.inputFormatters,
      this.initialValue,
      this.suffixIcon,
      this.focusNode,
      this.onFieldSubmitted,
      this.enable = true,
      this.obscureText = false,
      this.textInputAction = TextInputAction.next,
      this.textInputType,
      this.onChanged,
      this.multiline = false,
      this.controller})
      : super(key: key);

  final String? labelText;
  final String? Function(String? value)? validator;
  final String? Function(String?)? onSave;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final bool? enable;
  final bool obscureText;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction textInputAction;
  final TextInputType? textInputType;
  final Function? onChanged;
  final bool multiline;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.top,
      enabled: enable,
      controller: controller,
      initialValue: initialValue,
      keyboardType: textInputType,
      minLines: multiline ? 5 : null,
      maxLines: null,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: labelText,
        labelStyle: TextStyle(
            overflow: TextOverflow.ellipsis,
            color: focusNode != null
                ? focusNode!.hasFocus
                    ? Colors.red
                    : Colors.grey
                : Colors.black),
        filled: true,
        fillColor: Colors.grey,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.0),
        ),
        suffixIcon: suffixIcon == null ? null : suffixIcon,
      ),
      validator: validator,
      onSaved: onSave,
      textInputAction: textInputAction,
      cursorColor: Colors.red,
      onChanged: onChanged as void Function(String)?,
    );
  }
}
