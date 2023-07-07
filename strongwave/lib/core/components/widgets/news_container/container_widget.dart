// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../colors/colors.dart';

class ContainerWidget extends StatelessWidget {
  String title;
  String imagePath;
  ContainerWidget({
    super.key,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                offset: Offset(4, 4),
                spreadRadius: 1,
                blurRadius: 3,
                color: Colors.black38,
              ),
            ],
            color: btmColor,
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              scale: 1.0,
              opacity: 10.2,
              image: AssetImage(imagePath),
            ),
          ),
          height: MediaQuery.of(context).size.height / 6,
          width: MediaQuery.of(context).size.width / 1.2,
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.balooDa2(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: btmBarColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
