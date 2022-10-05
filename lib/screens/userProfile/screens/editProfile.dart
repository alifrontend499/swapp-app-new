import 'package:flutter/material.dart';

// colors
import 'package:app/theme/colors.dart';

// global consts
import 'package:app/theme/commonConst/textConsts.dart';

// page consts
import 'package:app/screens/userProfile/const/textConsts.dart';

// google fonts
import 'package:google_fonts/google_fonts.dart';

// icons
import 'package:unicons/unicons.dart';

// STYLES | ALL
final headingTextStyles = GoogleFonts.montserrat(
  fontSize: 17,
  fontWeight: FontWeight.w600,
);
final labelTextStyles = GoogleFonts.montserrat(
  fontSize: 14,
  fontWeight: FontWeight.w600,
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

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  GlobalKey formKey = GlobalKey();
  bool submitBtnLoading = false;

  String field_userEmail = '';
  String field_userPassword = '';
  String field_userConfirmPassword = '';
  String field_userName = '';
  String field_jobTitle = '';
  String field_industry = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

      child: Scaffold(
        appBar: AppBar(
          title: const Text(EDIT_PROFILE_PAGE_TITLE),
          titleTextStyle: GoogleFonts.montserrat(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 2,
          shadowColor: Colors.black26,
          leading: IconButton(
            icon: const Icon(
              UniconsLine.angle_left,
              size: 30,
            ),
            color: Colors.black,
            splashColor: Colors.transparent,
            onPressed: () => Navigator.pop(context),
          ),
        ),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // child | field | name
                            Text(
                              "Name",
                              style: labelTextStyles,
                            ),
                            const SizedBox(height: 5),

                            buildUserUsernameField(),
                            const SizedBox(height: 15),

                            // child | field | job title
                            Text(
                              "Title",
                              style: labelTextStyles,
                            ),
                            const SizedBox(height: 5),

                            buildUserJobTitleField(),
                            const SizedBox(height: 15),

                            // child | field | industry
                            Text(
                              "Industry",
                              style: labelTextStyles,
                            ),
                            const SizedBox(height: 5),

                            buildUserIndustryField(),
                          ],
                        ),
                        const SizedBox(height: 25),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // child | details
                            Text(
                              "Payment Details",
                              style: headingTextStyles,
                            ),
                            const SizedBox(height: 10),

                            // child | field | card number
                            Text(
                              "Card Number",
                              style: labelTextStyles,
                            ),
                            const SizedBox(height: 5),
                            buildUserUsernameField(),
                            const SizedBox(height: 15),

                            // child | field | expiry Date
                            Text(
                              "Expiry Date",
                              style: labelTextStyles,
                            ),
                            const SizedBox(height: 5),
                            buildUserUsernameField(),
                            const SizedBox(height: 15),

                            // child | field | CVV
                            Text(
                              "CVV",
                              style: labelTextStyles,
                            ),
                            const SizedBox(height: 5),
                            buildUserUsernameField(),
                            const SizedBox(height: 15),


                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              )
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: ElevatedButton(
                onPressed: () {},
                // child: currentStep == 1 ? const Text(STEP_NEXT) : const Text(SIGNUP_SUBMIT),
                child: submitBtnLoading ? const SizedBox(
                  height: 17,
                  width: 17,
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 2,
                  ),
                ) : Text("Save Details"),
                style: btnBottomNextStyles,
              ),
            ),


          ],
        ),
      ),
    );
  }

  // field: user name
  Widget buildUserUsernameField() => TextFormField(
    style: const TextStyle(height: 1.3, fontSize: 15),
    decoration: InputDecoration(
      hintText: ENTER_YOUR_NAME,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(45),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
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
    style: const TextStyle(height: 1.3, fontSize: 15),
    decoration: InputDecoration(
      hintText: ENTER_JOB_TITLE,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(45),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
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
    style: const TextStyle(height: 1.3, fontSize: 15),
    decoration: InputDecoration(
      hintText: YOUR_INDUSTRY,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(45),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
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
}