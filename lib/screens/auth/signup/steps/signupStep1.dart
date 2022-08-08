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

class SignUpStep1Screen extends StatefulWidget {
  const SignUpStep1Screen({Key? key}) : super(key: key);

  @override
  State<SignUpStep1Screen> createState() => _SignUpStep1ScreenState();
}

class _SignUpStep1ScreenState extends State<SignUpStep1Screen> {
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  // styles
  final labelTextStyles = GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w600
  );
  final chooseImageTextStyles = GoogleFonts.montserrat(
      fontSize: 15,
      fontWeight: FontWeight.w500
  );
  final optionTextStyles = GoogleFonts.montserrat(
    fontSize: 15,
  );
  final progressTextStyle = GoogleFonts.montserrat(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Colors.black
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
          fontWeight: FontWeight.w600
        )
    ),
  );

  // IMAGE PICKER
  File? image;
  Future imgPickerFromGallery() async {
    try {
      // closing bottom sheet
      Navigator.pop(context);

      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } catch(e) {
      print('Failed to pick image: $e');
    }
  }

  Future imgPickerFromCamera() async {
    try {
      // closing bottom sheet
      Navigator.pop(context);

      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if(image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

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
          leading: IconButton(
            icon: const Icon(
              UniconsLine.angle_left,
              size: 30,
            ),
            color: Colors.black,
            splashColor: Colors.transparent,
            onPressed: () => Navigator.pushNamed(context, initialScreenRoute),
          ),
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
                        // child | image selector
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: appGreyDarkBGColor,
                                onPrimary: Colors.black87,
                                minimumSize: const Size(105, 105),
                                splashFactory: NoSplash.splashFactory,
                                shadowColor: Colors.transparent,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              CHOOSE_IMAGE,
                              style: chooseImageTextStyles,
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),

                        // child | enter email
                        Text(
                          EMAIL_ADDRESS,
                          style: labelTextStyles,
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: ENTER_EMAIL_ADDRESS,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(45),
                                borderSide: const BorderSide(color: Colors.red, width: 2.0)
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                          ),
                        ),
                        const SizedBox(height: 15),

                        // child | enter password
                        Text(
                          PASSWORD,
                          style: labelTextStyles,
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          obscureText: isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: ENTER_PASSWORD,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(45),
                                borderSide: const BorderSide(color: Colors.red, width: 2.0)
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                              icon: isPasswordVisible
                                  ? const Icon(UniconsLine.eye_slash)
                                  : const Icon(UniconsLine.eye),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),

                        // child | enter confirm password
                        Text(
                          CONFIRM_PASSWORD,
                          style: labelTextStyles,
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          obscureText: isConfirmPasswordVisible,
                          decoration: InputDecoration(
                            hintText: ENTER_PASSWORD,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(45),
                                borderSide: const BorderSide(color: Colors.red, width: 2.0)
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isConfirmPasswordVisible = !isConfirmPasswordVisible;
                                });
                              },
                              icon: isConfirmPasswordVisible
                                  ? const Icon(UniconsLine.eye_slash)
                                  : const Icon(UniconsLine.eye),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
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
                          '1 of 2',
                          style: progressTextStyle,
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: const LinearProgressIndicator(
                            color: appProgressBarType1BarColor,
                            value: 1 / 2,
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
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => Navigator.pushNamed(context, signupStep2ScreenRoute),
                            child: const Text(STEP_NEXT),
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

  // bottom sheet | image options
  Widget showImageOptions() => Container(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell( // option item
          splashColor: Colors.transparent,
          highlightColor: appGreyHighlightBGColor,
          onTap: () => imgPickerFromCamera(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
            child: Row(
              children: [
                const Icon(
                  UniconsLine.camera,
                  size: 21,
                ),
                const SizedBox(width: 13),

                Text(
                  USE_CAMERA,
                  style: optionTextStyles,
                ),
              ],
            ),
          ),
        ),

        InkWell( // option item
          splashColor: Colors.transparent,
          highlightColor: appGreyHighlightBGColor,
          onTap: () => imgPickerFromGallery(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
            child: Row(
              children: [
                const Icon(
                  UniconsLine.image,
                  size: 21,
                ),
                const SizedBox(width: 13),

                Text(
                  USE_GALLERY,
                  style: optionTextStyles,
                ),
              ],
            ),
          ),
        ),

        if(image != null) ...[
          InkWell( // option item
            splashColor: Colors.transparent,
            highlightColor: appGreyHighlightBGColor,
            onTap: () => {
              // closing bottom sheet
              Navigator.pop(context),

              // emptying image value
              setState(() {
                image = null;
              })
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
              child: Row(
                children: [
                  const Icon(
                    UniconsLine.trash_alt,
                    size: 21,
                  ),
                  const SizedBox(width: 13),

                  Text(
                    REMOVE_IMAGE,
                    style: optionTextStyles,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    ),
  );
}
