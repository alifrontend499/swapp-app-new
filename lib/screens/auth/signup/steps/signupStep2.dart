import 'dart:io';
import 'package:flutter/material.dart';

// app consts
import 'package:app/screens/auth/signup/const/textConsts.dart';

// icons
import 'package:unicons/unicons.dart';

class SignUpStep2 extends StatelessWidget {
  final Function showImageOptions;
  final File? image;
  final ButtonStyle userImageBtnStyle;
  final TextStyle chooseImageTextStyles;
  final TextStyle labelTextStyles;
  final Widget buildUserUsernameField;
  final Widget buildUserJobTitleField;
  final Widget buildUserIndustryField;


  const SignUpStep2({
    Key? key,
    required this.showImageOptions,
    required this.image,
    required this.userImageBtnStyle,
    required this.chooseImageTextStyles,
    required this.labelTextStyles,
    required this.buildUserUsernameField,
    required this.buildUserJobTitleField,
    required this.buildUserIndustryField,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // child | field | name
            Text(
              YOUR_NAME,
              style: labelTextStyles,
            ),
            const SizedBox(height: 5),

            buildUserUsernameField,
            const SizedBox(height: 15),

            // child | field | job title
            Text(
              YOUR_JOB_TITLE,
              style: labelTextStyles,
            ),
            const SizedBox(height: 5),

            buildUserJobTitleField,
            const SizedBox(height: 15),

            // child | field | industry
            Text(
              YOUR_INDUSTRY,
              style: labelTextStyles,
            ),
            const SizedBox(height: 5),

            buildUserIndustryField,
            const SizedBox(height: 15),
          ],
        )
    );
  }
}
