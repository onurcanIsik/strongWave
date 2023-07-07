// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, unrelated_type_equality_checks, unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/password_model.dart';

class CheckBoxWidget extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CheckBoxWidget({
    Key? key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  @override
  Widget build(BuildContext context) {
    var passwordModel = Provider.of<PasswordModel>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 5),
      child: Container(
        width: MediaQuery.of(context).size.width / 15,
        height: MediaQuery.of(context).size.height / 15,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.value ? Colors.green : Colors.black,
            width: 3,
          ),
          color: widget.value ? Colors.green : Colors.transparent,
        ),
        child: Checkbox(
          value: widget.value,
          onChanged: widget.onChanged,
          shape: const CircleBorder(),
          checkColor: Colors.white,
          activeColor: Colors.transparent,
        ),
      ),
    );
  }
}
