// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../model/password_model.dart';
import 'checkbox_widget.dart';

class CheckBoxRowWidget extends StatelessWidget {
  const CheckBoxRowWidget({
    super.key,
    required bool isWithLetters,
    required bool isWithUppercase,
    required bool isWithNumbers,
    required bool isWithSpecial,
  })  : _isWithLetters = isWithLetters,
        _isWithUppercase = isWithUppercase,
        _isWithNumbers = isWithNumbers,
        _isWithSpecial = isWithSpecial;

  final bool _isWithLetters;
  final bool _isWithUppercase;
  final bool _isWithNumbers;
  final bool _isWithSpecial;

  @override
  Widget build(BuildContext context) {
    var passwordModel = Provider.of<PasswordModel>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CheckBoxWidget(
          value: passwordModel.isWithLetters,
          onChanged: (value) {
            passwordModel.updateLettersValue(value!);
          },
        ),
        Text(
          'Letters',
          style: GoogleFonts.balooDa2(fontSize: 13),
        ),
        CheckBoxWidget(
          value: _isWithUppercase,
          onChanged: (value) {
            passwordModel.updateUppercaseValue(value!);
          },
        ),
        Text(
          'Upper Case',
          style: GoogleFonts.balooDa2(fontSize: 13),
        ),
        CheckBoxWidget(
          value: _isWithNumbers,
          onChanged: (value) {
            passwordModel.updateNumbersValue(value!);
          },
        ),
        Text(
          'Numbers',
          style: GoogleFonts.balooDa2(fontSize: 13),
        ),
        CheckBoxWidget(
          value: _isWithSpecial,
          onChanged: (value) {
            passwordModel.updateSpecialValue(value!);
          },
        ),
        Text(
          'SpecialKey',
          style: GoogleFonts.balooDa2(fontSize: 13),
        ),
      ],
    );
  }
}
