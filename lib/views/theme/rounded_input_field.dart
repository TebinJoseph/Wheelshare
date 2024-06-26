import 'package:flutter/material.dart';
import 'package:wheel/views/theme/text_field_container.dart';
import 'package:wheel/views/theme/login_colors.dart';

class RoundedInputField extends StatelessWidget {
  final Key key;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    required this.key,
    required this.hintText,
    this.icon = Icons.location_on,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}