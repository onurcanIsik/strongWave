import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../colors/colors.dart';

class TxtFormFieldWidget extends StatelessWidget {
  final bool lettersValue;
  const TxtFormFieldWidget({
    super.key,
    required this.lettersValue,
    required FocusNode focusNode,
    required TextEditingController passwordLength,
  })  : _focusNode = focusNode,
        _passwordLength = passwordLength;

  final FocusNode _focusNode;
  final TextEditingController _passwordLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Cannot be empty";
        } else if (lettersValue == false) {
          return "You must a choise letters";
        }
        return null;
      },
      focusNode: _focusNode,
      keyboardType: TextInputType.number,
      cursorColor: btmBarColor,
      style: GoogleFonts.balooDa2(),
      textAlign: TextAlign.center,
      controller: _passwordLength,
      decoration: InputDecoration(
        hintText: "Password Length max be 30",
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: btmBarColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: appBarColor,
          ),
        ),
      ),
    );
  }
}
