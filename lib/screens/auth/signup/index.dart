import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// app consts
import 'package:app/theme/commonConst/textConsts.dart';

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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  int currentStep = 1;
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  final formKey = GlobalKey<FormState>();
  String field_userEmail = '';
  String field_userPassword = '';
  String field_userConfirmPassword = '';
  String field_userName = '';
  String field_jobTitle = '';
  String field_industry = '';

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
        fontWeight: FontWeight.w600
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
  final userImageBtnStyle = ElevatedButton.styleFrom(
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
                  child: currentStep == 1 ? signUpStep1() : signUpStep2()
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
                          '$currentStep of 2',
                          style: progressTextStyle,
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: LinearProgressIndicator(
                            color: appProgressBarType1BarColor,
                            value: currentStep / 2,
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
                        if(currentStep == 2) ...[
                          ElevatedButton(
                            onPressed: () {
                              if(currentStep == 2) {
                                setState(() {
                                  currentStep = 1;
                                });
                              }
                            },
                            child: const Text(STEP_PREV),
                            style: btnBottomPrevStyles,
                          ),
                          const SizedBox(width: 20),
                        ],

                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if(currentStep == 1) {
                                setState(() {
                                  currentStep = 2;
                                });
                              } else if(currentStep == 2) {

                              }
                            },
                            child: currentStep == 1 ? const Text(STEP_NEXT) : const Text(SIGNUP_SUBMIT),
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

  // STEPS
  // step 1
  Widget signUpStep1() => SingleChildScrollView(
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

          buildUserEmailField(),
          const SizedBox(height: 15),

          // child | field | password
          Text(
            PASSWORD,
            style: labelTextStyles,
          ),
          const SizedBox(height: 5),

          buildUserPasswordField(),
          const SizedBox(height: 15),

          // child | field | confirm password
          Text(
            CONFIRM_PASSWORD,
            style: labelTextStyles,
          ),
          const SizedBox(height: 5),

          buildUserConfirmPasswordField(),
          const SizedBox(height: 15),
        ],
      )
  );

  // step 2
  Widget signUpStep2() => SingleChildScrollView(
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

          buildUserUsernameField(),
          const SizedBox(height: 15),

          // child | field | job title
          Text(
            YOUR_JOB_TITLE,
            style: labelTextStyles,
          ),
          const SizedBox(height: 5),

          buildUserJobTitleField(),
          const SizedBox(height: 15),

          // child | field | industry
          Text(
            YOUR_INDUSTRY,
            style: labelTextStyles,
          ),
          const SizedBox(height: 5),

          buildUserIndustryField(),
          const SizedBox(height: 15),
        ],
      )
  );

  // FIELDS
  // field: email
  Widget buildUserEmailField() => TextFormField(
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      hintText: ENTER_EMAIL_ADDRESS,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(45),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
    ),
    onSaved: (value) => setState(() => field_userEmail = value!),
    validator: (value) {
      const emailPattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
      final regExpEmail = RegExp(emailPattern);

      if (value!.isEmpty) {
        // checking for empty value
        return ERROR_MSG_ENTER_VALUE;
      } else if (!regExpEmail.hasMatch(value)) {
        // checking for valid email
        return ERROR_MSG_ENTER_EMAIL;
      }
      return null;
    },
    autovalidateMode: AutovalidateMode.onUserInteraction,
  );

  // field: password
  Widget buildUserPasswordField() => TextFormField(
    obscureText: isPasswordVisible,
    decoration: InputDecoration(
      hintText: ENTER_EMAIL_ADDRESS,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(45),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
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
    onSaved: (value) => setState(() => field_userPassword = value!),
    validator: (value) {
      if (value!.isEmpty) {
        // checking for empty value
        return ERROR_MSG_ENTER_VALUE;
      }
      return null;
    },
    autovalidateMode: AutovalidateMode.onUserInteraction,
  );

  // field: confirm password
  Widget buildUserConfirmPasswordField() => TextFormField(
    obscureText: isPasswordVisible,
    decoration: InputDecoration(
      hintText: ENTER_EMAIL_ADDRESS,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(45),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
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
    onSaved: (value) => setState(() => field_userConfirmPassword = value!),
    validator: (value) {
      if (value!.isEmpty) {
        // checking for empty value
        return ERROR_MSG_ENTER_VALUE;
      } else if(field_userConfirmPassword != field_userPassword) {
        // checking for empty value
        return "Confirm password should be same as the password";
      }
      return null;
    },
    autovalidateMode: AutovalidateMode.onUserInteraction,
  );

  // field: user name
  Widget buildUserUsernameField() => TextFormField(
    decoration: InputDecoration(
      hintText: ENTER_YOUR_NAME,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(45),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
    ),
    onSaved: (value) => setState(() => field_userName = value!),
    initialValue: '',
    validator: (value) {
      if (value!.isEmpty) {
        // checking for empty value
        return ERROR_MSG_ENTER_VALUE;
      }
      return null;
    },
    autovalidateMode: AutovalidateMode.onUserInteraction,
  );

  // field: job title
  Widget buildUserJobTitleField() => TextFormField(
    decoration: InputDecoration(
      hintText: ENTER_JOB_TITLE,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(45),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
    ),
    onSaved: (value) => setState(() => field_jobTitle = value!),
    validator: (value) {
      if (value!.isEmpty) {
        // checking for empty value
        return ERROR_MSG_ENTER_VALUE;
      }
      return null;
    },
    autovalidateMode: AutovalidateMode.onUserInteraction,
  );

  // field: industry
  Widget buildUserIndustryField() => TextFormField(
    decoration: InputDecoration(
      hintText: YOUR_INDUSTRY,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(45),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
    ),
    onSaved: (value) => setState(() => field_industry = value!),
    validator: (value) {
      if (value!.isEmpty) {
        // checking for empty value
        return ERROR_MSG_ENTER_VALUE;
      }
      return null;
    },
    autovalidateMode: AutovalidateMode.onUserInteraction,
  );

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
