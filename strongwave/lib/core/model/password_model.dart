import 'package:flutter/material.dart';

class PasswordModel extends ChangeNotifier {
  bool isWithLetters = true;
  bool isWithUppercase = false;
  bool isWithNumbers = false;
  bool isWithSpecial = false;

  void updateLettersValue(bool value) {
    isWithLetters = value;
    notifyListeners();
  }

  void updateUppercaseValue(bool value) {
    isWithUppercase = value;
    notifyListeners();
  }

  void updateNumbersValue(bool value) {
    isWithNumbers = value;
    notifyListeners();
  }

  void updateSpecialValue(bool value) {
    isWithSpecial = value;
    notifyListeners();
  }
}
