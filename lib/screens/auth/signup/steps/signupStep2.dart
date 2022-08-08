import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// google fonts
import 'package:google_fonts/google_fonts.dart';

// colors
import 'package:app/theme/colors.dart';

// page text
import 'package:app/screens/auth/signup/const/textConsts.dart';

// icons
import 'package:unicons/unicons.dart';

// routing
import 'package:app/theme/routing/routing_constants.dart';

// image picker
import 'package:image_picker/image_picker.dart';

class SignUpStep2Screen extends StatefulWidget {
  const SignUpStep2Screen({Key? key}) : super(key: key);

  @override
  State<SignUpStep2Screen> createState() => _SignUpStep2ScreenState();
}

class _SignUpStep2ScreenState extends State<SignUpStep2Screen> {
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  // styles
  final labelTextStyles = GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  final chooseImageTextStyles = GoogleFonts.montserrat(
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );
  final optionTextStyles = GoogleFonts.montserrat(
    fontSize: 15,
  );
  final progressTextStyle = GoogleFonts.montserrat(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.black
  );
  final pageHeadingStyles = GoogleFonts.montserrat(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  final btnBottomNextStyles = ElevatedButton.styleFrom(
    splashFactory: NoSplash.splashFactory,
    minimumSize: const Size(double.minPositive, 48),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40)
    ),
    primary: appPrimaryBtnColor,
    onPrimary: appPrimaryBtnColorOnPrimary,
    textStyle: GoogleFonts.montserrat(
      textStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
  final btnBottomPrevStyles = ElevatedButton.styleFrom(
    splashFactory: NoSplash.splashFactory,
    minimumSize: const Size(110, 48),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40)
    ),
    primary: appGrayBtnColor,
    onPrimary: appGrayBtnColorOnPrimary,
    textStyle: GoogleFonts.montserrat(
      textStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(APPBAR_TITLE),
          titleTextStyle: GoogleFonts.montserrat(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          centerTitle: true,
          leading: null,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // child | top Part
              Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // child | heading
                        Text(
                          PERSONAL_DETAILS,
                          style: pageHeadingStyles,
                        ),
                        const SizedBox(height: 15),

                        // child | enter name
                        Text(
                          YOUR_NAME,
                          style: labelTextStyles,
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          decoration: InputDecoration(
                            hintText: ENTER_YOUR_NAME,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(45),
                                borderSide: const BorderSide(color: Colors.red, width: 2.0)
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                          ),
                        ),
                        const SizedBox(height: 15),

                        // child | enter job title
                        Text(
                          YOUR_JOB_TITLE,
                          style: labelTextStyles,
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          decoration: InputDecoration(
                            hintText: ENTER_JOB_TITLE,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(45),
                              borderSide: const BorderSide(color: Colors.red, width: 2.0)
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                          ),
                        ),
                        const SizedBox(height: 15),

                        // child | enter industry
                        Text(
                          YOUR_INDUSTRY,
                          style: labelTextStyles,
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          decoration: InputDecoration(
                            hintText: ENTER_INDUSTRY,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(45),
                              borderSide: const BorderSide(color: Colors.red, width: 2.0)
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  )
              ),

              // child | bottom Part
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  children: [
                    // child | steps counter
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '2 of 2',
                          style: progressTextStyle,
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: const LinearProgressIndicator(
                            color: appProgressBarType1BarColor,
                            value: 2 / 2,
                            backgroundColor: appProgressBarType1BgColor,
                            minHeight: 10,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),

                    // child | steps counter
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(STEP_PREV),
                          style: btnBottomPrevStyles,
                        ),

                        const SizedBox(width: 20),

                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => {},
                            child: const Text(SIGNUP_SUBMIT),
                            style: btnBottomNextStyles,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
