import 'dart:io';
import 'package:flutter/material.dart';

// app consts
import 'package:app/screens/auth/signup/const/textConsts.dart';

// icons
import 'package:unicons/unicons.dart';

class SignUpStep1 extends StatelessWidget {
  final Function showImageOptions;
  final File? image;
  final ButtonStyle userImageBtnStyle;
  final TextStyle chooseImageTextStyles;
  final TextStyle labelTextStyles;
  final Widget buildUserEmailField;
  final Widget buildUserPasswordField;
  final Widget buildUserConfirmPasswordField;


  const SignUpStep1({
    Key? key,
    required this.showImageOptions,
    required this.image,
    required this.userImageBtnStyle,
    required this.chooseImageTextStyles,
    required this.labelTextStyles,
    required this.buildUserEmailField,
    required this.buildUserPasswordField,
    required this.buildUserConfirmPasswordField,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // child | image selector
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // child | image selector
                  ElevatedButton(
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => showImageOptions(),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(15)
                        ),
                      ),
                    ),
                    child: image != null ? ClipRRect(
                      child: Image.file(
                        image!,
                        height: 105,
                        width: 105,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ) : const Icon(
                      UniconsLine.camera,
                      size: 35,
                    ),
                    style: userImageBtnStyle,
                  ),
                  const SizedBox(height: 10),

                  // child | text
                  Text(
                    CHOOSE_IMAGE,
                    style: chooseImageTextStyles,
                  ),
                ]
            ),
            const SizedBox(height: 30),

            // child | field | email address
            Text(
              EMAIL_ADDRESS,
              style: labelTextStyles,
            ),
            const SizedBox(height: 5),

            buildUserEmailField,
            const SizedBox(height: 15),

            // child | field | password
            Text(
              PASSWORD,
              style: labelTextStyles,
            ),
            const SizedBox(height: 5),

            buildUserPasswordField,
            const SizedBox(height: 15),

            // child | field | confirm password
            Text(
              CONFIRM_PASSWORD,
              style: labelTextStyles,
            ),
            const SizedBox(height: 5),

            buildUserConfirmPasswordField,
            const SizedBox(height: 15),
          ],
        )
    );
  }
}
