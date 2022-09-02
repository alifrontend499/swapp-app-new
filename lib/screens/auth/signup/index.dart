import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// app consts
import 'package:app/theme/commonConst/textConsts.dart';

// page consts
import 'package:app/screens/auth/signup/const/textConsts.dart';

// google fonts
import 'package:google_fonts/google_fonts.dart';

// colors
import 'package:app/theme/colors.dart';

// icons
import 'package:unicons/unicons.dart';

// routing
import 'package:app/theme/routing/routing_constants.dart';

// image picker
import 'package:image_picker/image_picker.dart';

// common components
import 'package:app/theme/commonComponents/snackBar.dart';

// signup steps
import 'package:app/screens/auth/signup/steps/signupStep1.dart';
import 'package:app/screens/auth/signup/steps/signupStep2.dart';

// http
import 'package:http/http.dart' as http;

// apis urls
import 'package:app/theme/apis/api_urls.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool submitBtnLoading = false;
  
  int currentStep = 1;
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  final step1_formKey = GlobalKey<FormState>();
  final step2_formKey = GlobalKey<FormState>();

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

  // on submit of the form
  void onSubmit_step1() {
    final form = step1_formKey.currentState;

    // unfocused the inputs
    FocusManager.instance.primaryFocus?.unfocus();

    if(form != null && form.validate()) {
      // changing to 2nd step
      setState(() => {
        currentStep = 2
      });
    }
  }

  // on submit of the form
  void onSubmit_step2() async {
    final form = step2_formKey.currentState;

    final errorSnackBar = buildSnackBar(SNACKBAR_MSG_UNKNOWN_ERROR, 'error');
    final successSnackBar = buildSnackBar(SNACKBAR_MSG_SIGNUP_SUCCESSFULL, 'success');

    // unfocused the inputs
    FocusManager.instance.primaryFocus?.unfocus();

    if(form != null && form.validate()) {
      // showing loading
      setState(() => {
        submitBtnLoading = true
      });

      try {
        // network request
        final response = await http.post(Uri.parse(userSignupApi),
            body: {
              'userEmail': field_userEmail,
              'password': field_userPassword,
              'userName': field_userName,
              'jobTitle': field_jobTitle,
              'industry': field_industry,
            }
        );
        print('Response status: ${response.statusCode}');

        // showing snack
        ScaffoldMessenger.of(context).showSnackBar(successSnackBar);

        // hiding loading
        setState(() => {
          submitBtnLoading = false
        });

        // navigate to login screen after 3 seconds
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, loginScreenRoute);
        // Navigator.pushNamedAndRemoveUntil(context, loginScreenRoute, (r) => false);
      } catch (err) {
        print('Error Occurred: $err');

        // hiding loading
        setState(() => submitBtnLoading = false);

        // showing snack
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
      }
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
                child: currentStep == 1 ? SignUpStep1(
                    formKey: step1_formKey,
                    showImageOptions: showImageOptions,
                    image: image,
                    userImageBtnStyle: userImageBtnStyle,
                    chooseImageTextStyles: chooseImageTextStyles,
                    labelTextStyles: labelTextStyles,
                    buildUserEmailField: buildUserEmailField(),
                    buildUserPasswordField: buildUserPasswordField(),
                    buildUserConfirmPasswordField: buildUserConfirmPasswordField()
                  ) : SignUpStep2(
                    formKey: step2_formKey,
                    showImageOptions: showImageOptions,
                    image: image,
                    userImageBtnStyle: userImageBtnStyle,
                    chooseImageTextStyles: chooseImageTextStyles,
                    labelTextStyles: labelTextStyles,
                    buildUserUsernameField: buildUserUsernameField(),
                    buildUserJobTitleField: buildUserJobTitleField(),
                    buildUserIndustryField: buildUserIndustryField()
                  ),
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
                              if(!submitBtnLoading) {
                                if(currentStep == 1) {
                                  onSubmit_step1();
                                } else {
                                  onSubmit_step2();
                                }
                              }
                            },
                            // child: currentStep == 1 ? const Text(STEP_NEXT) : const Text(SIGNUP_SUBMIT),
                            child: submitBtnLoading ? const SizedBox(
                              height: 17,
                              width: 17,
                              child: CircularProgressIndicator(
                                color: Colors.black,
                                strokeWidth: 2,
                              ),
                            ) : Text(currentStep == 1 ? STEP_NEXT : SIGNUP_SUBMIT),
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
    // onSaved: (value) => setState(() => field_userEmail = value!),
    onChanged: (value) => setState(() => field_userEmail = value!),
    initialValue: field_userEmail,
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
    // onSaved: (value) => setState(() => field_userPassword = value!),
    onChanged: (value) => setState(() => field_userPassword = value!),
    initialValue: field_userPassword,
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
    // onSaved: (value) => setState(() => field_userConfirmPassword = value!),
    onChanged: (value) => setState(() => field_userConfirmPassword = value!),
    initialValue: field_userConfirmPassword,
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
    // onSaved: (value) => setState(() => field_userName = value!),
    onChanged: (value) => setState(() => field_userName = value!),
    initialValue: field_userName,
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
    // onSaved: (value) => setState(() => field_jobTitle = value!),
    onChanged: (value) => setState(() => field_jobTitle = value!),
    initialValue: field_jobTitle,
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
    // onSaved: (value) => setState(() => field_industry = value!),
    onChanged: (value) => setState(() => field_industry = value!),
    initialValue: field_industry,
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
