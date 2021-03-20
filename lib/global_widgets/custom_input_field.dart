import 'package:budget_app_prelimm/constants/style.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final EdgeInsetsGeometry padding;
  final TextInputType keyboardType;
  final bool readOnly;
  final Function onTap;
  final Widget prefixIcon;
  final Function(String) validator;

  const CustomInputField({
    Key key,
    this.textController,
    this.hintText,
    this.padding = EdgeInsets.zero,
    this.keyboardType,
    this.readOnly = false,
    this.onTap,
    this.prefixIcon,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        onTap: onTap,
        validator: validator,
        readOnly: readOnly,
        keyboardType: keyboardType,
        controller: textController,
        decoration: InputDecoration(
          errorStyle: kSubText.copyWith(
            color: kColorWhite,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(),
          filled: true,
          fillColor: kColorWhite,
          hintText: hintText,
          hintStyle: kSubText.copyWith(fontSize: 15),
        ),
      ),
    );
  }
}
