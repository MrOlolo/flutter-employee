import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_task/util/date_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final List<TextInputFormatter> formatters;
  final Function(String text) validator;
  final Function(String text) onChanged;
  final TextCapitalization capitalization;
  final String label;
  final bool datePickMode;
  final String hint;
  final Function onTap;
  final bool enabled;
  final int maxLines;

  const CustomTextField({
    Key key,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.formatters,
    this.validator,
    @required this.label,
    this.onChanged,
    this.capitalization = TextCapitalization.words,
    this.datePickMode = false,
    this.hint,
    this.onTap,
    this.enabled = true,
    this.maxLines = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text(
            label ?? '',
            textAlign: TextAlign.start,
          ),
        ),
        TextFormField(
          onTap: onTap,
          enabled: enabled,
          minLines: 1,
          maxLines: maxLines,
          controller: controller,
          focusNode:
              datePickMode ? NoKeyboardEditableTextFocusNode() : focusNode,
          keyboardType: keyboardType,
          validator: validator,
          inputFormatters: formatters,
          decoration: InputDecoration(
              //helperText: '',
              suffixIcon: datePickMode ? Icon(Icons.calendar_today) : null,
              errorMaxLines: 5,
              hintText: datePickMode ? 'ДД.ММ.ГГГГ' : hint,
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
              )),
          textCapitalization: capitalization,
          onChanged: onChanged,
          //onTap: onTap,
        )
      ],
    );
  }
}

class NoKeyboardEditableTextFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;

  @override
  bool consumeKeyboardToken() {
    return false;
  }
}
