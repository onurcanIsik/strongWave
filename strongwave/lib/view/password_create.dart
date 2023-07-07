// ignore_for_file: prefer_final_fields, unused_field, camel_case_types, unused_element, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:random_password_generator/random_password_generator.dart';
import 'package:strongwave/colors/colors.dart';
import 'package:strongwave/core/components/widgets/checkbox_row_widget.dart';
import '../core/components/widgets/password_textfield_widget.dart';
import '../core/model/password_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PasswordCreator extends StatefulWidget {
  const PasswordCreator({
    super.key,
  });

  @override
  State<PasswordCreator> createState() => _PasswordCreatorState();
}

class _PasswordCreatorState extends State<PasswordCreator> {
  bool _isWithLetters = true;
  bool _isWithUppercase = false;
  bool _isWithNumbers = false;
  bool _isWithSpecial = false;
  double _numberCharPassword = 10;
  String newPassword = '';
  TextEditingController _passwordLength = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  List<Map<String, dynamic>> _items = [];
  final passwordCard = Hive.box('passwordCard_box');
  TextEditingController txtController = TextEditingController();

  String generateRandomPassword(
    double length,
    bool upper,
    bool special,
    bool numbers,
    bool letters,
  ) {
    RandomPasswordGenerator generator = RandomPasswordGenerator();
    String password = generator.randomPassword(
      passwordLength: length,
      uppercase: upper,
      specialChar: special,
      numbers: numbers,
      letters: letters,
    );
    return newPassword = password;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _refreshItems();
  }

  void _refreshItems() {
    final data = passwordCard.keys.map((key) {
      final value = passwordCard.get(key);
      return {'key': key, 'name': value['name'], 'password': value['password']};
    }).toList();

    setState(() {
      _items = data.reversed.toList();
    });
  }

  Future<void> createCard(Map<String, dynamic> newItem) async {
    await passwordCard.add(newItem);
    _refreshItems();
  }

  Future<void> _deleteItem(int itemKey) async {
    await passwordCard.delete(itemKey);
    _refreshItems();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An item has been deleted')));
  }

  void _copyTextToClipboard(textCopy) {
    setState(() {
      Clipboard.setData(ClipboardData(text: textCopy)).then((value) =>
          Fluttertoast.showToast(msg: "Copied", timeInSecForIosWeb: 3));
    });
  }

  @override
  Widget build(BuildContext context) {
    var passwordModel = Provider.of<PasswordModel>(context);
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: bgColor,
        appBar: _appBar(),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(22),
                        bottomRight: Radius.circular(22),
                      ),
                    ),
                    elevation: 10,
                    child: CheckBoxRowWidget(
                      isWithLetters: passwordModel.isWithLetters,
                      isWithUppercase: passwordModel.isWithUppercase,
                      isWithNumbers: passwordModel.isWithNumbers,
                      isWithSpecial: passwordModel.isWithSpecial,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: TxtFormFieldWidget(
                      lettersValue:
                          Provider.of<PasswordModel>(context).isWithLetters,
                      focusNode: _focusNode,
                      passwordLength: _passwordLength,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: _passwordGenerator(passwordModel, _passwordLength),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Your Password:',
                      style: GoogleFonts.balooDa2(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  newPassword == ""
                      ? Text('Empty',
                          style: GoogleFonts.balooDa2(color: Colors.grey))
                      : Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                newPassword,
                                style: GoogleFonts.balooDa2(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                  newPassword == ""
                      ? Text(
                          "blank",
                          style: GoogleFonts.balooDa2(),
                        )
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              _showForm(
                                context,
                                null,
                                newPassword,
                                txtController,
                                createCard,
                              );
                            });
                          },
                          icon: const Icon(Icons.save),
                        ),
                  const Divider(
                    height: 20,
                    thickness: 2,
                    endIndent: 10,
                    indent: 10,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3.5,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: ListView.builder(
                      reverse: false,
                      shrinkWrap: true,
                      itemCount: _items.length,
                      itemBuilder: (_, index) {
                        final currentItem = _items[index];
                        return GestureDetector(
                          onTap: () {
                            _copyTextToClipboard(newPassword);
                          },
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              isThreeLine: true,
                              trailing: IconButton(
                                icon: const Icon(
                                  Iconsax.trash,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  _deleteItem(currentItem['key']);
                                },
                              ),
                              title: Text(
                                currentItem['name'],
                                style: GoogleFonts.balooDa2(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                currentItem['password'],
                                style: GoogleFonts.balooDa2(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton _passwordGenerator(
    PasswordModel passwordModel,
    TextEditingController lngthController,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: btmColor,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          setState(() {
            if (int.parse(lngthController.text) <= 30) {
              generateRandomPassword(
                double.parse(_passwordLength.text),
                passwordModel.isWithUppercase,
                passwordModel.isWithSpecial,
                passwordModel.isWithNumbers,
                passwordModel.isWithLetters,
              );
            }
          });
        }
      },
      child: Text(
        'Generate Password',
        style: GoogleFonts.balooDa2(),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: appBarColor,
      title: Text(
        'Generate Password',
        style: GoogleFonts.balooDa2(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

void _showForm(
  BuildContext ctx,
  int? itemKey,
  String password,
  TextEditingController txtController,
  Future<void> Function(Map<String, dynamic>) fonk,
) async {
  final formKey = GlobalKey<FormState>();

  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    context: ctx,
    elevation: 5,
    isScrollControlled: false,
    builder: (_) {
      return Form(
        key: formKey,
        child: Column(
          children: [
            Center(
              child: Text(
                'Save Your Password',
                style: GoogleFonts.balooDa2(
                  fontSize: 25,
                ),
              ),
            ),
            Text(
              'Password: $password',
              style: GoogleFonts.balooDa2(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50, top: 50),
              child: TextFormField(
                controller: txtController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Cannot be empty";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                cursorColor: btmBarColor,
                style: GoogleFonts.balooDa2(),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Instagram Password",
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TextButton(
                style: TextButton.styleFrom(
                  elevation: 10,
                  backgroundColor: btmColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    fonk({
                      "name": txtController.text,
                      "password": password.toString()
                    }).then((value) => txtController.clear());
                  }
                },
                child: Text(
                  'Save Password',
                  style: GoogleFonts.balooDa2(
                    color: bgColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}
