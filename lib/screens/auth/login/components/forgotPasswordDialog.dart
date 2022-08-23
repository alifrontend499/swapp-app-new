import 'package:flutter/material.dart';

// app consts
import 'package:app/screens/auth/login/const/textConsts.dart';

// colors
import 'package:app/theme/colors.dart';

// google fonts
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  bool submitBtnLoading = false;
  final _formKey = GlobalKey<FormState>();
  String userEmail = '';

  // styles
  final pageHeadingStyles = GoogleFonts.montserrat(
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );
  final btnStylesSubmit = ElevatedButton.styleFrom(
    splashFactory: NoSplash.splashFactory,
    minimumSize: const Size(260, 48),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    primary: appPrimaryBtnColor,
    onPrimary: appPrimaryBtnColorOnPrimary,
    textStyle: GoogleFonts.montserrat(
      textStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600
      ),
    ),
  );
  final additionalTextStyles = GoogleFonts.montserrat(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: appTextColorPrimary,
    letterSpacing: 2
  );

  // submit forgot password form
  void onSubmit() async {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();

      setState(() => submitBtnLoading = true);
      await Future.delayed(const Duration(seconds: 2));
      setState(() => submitBtnLoading = false);
    }
  }

  // build snack bar
  void buildSnackBar(String text, String type) => SnackBar(
    content: Text(text),
    backgroundColor: type == 'error' ? Colors.redAccent : Colors.green,
    dismissDirection: DismissDirection.startToEnd,
  );


  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        width: double.infinity,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                // page heading
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    FORGOT_PASSWORD_HEADING,
                    style: pageHeadingStyles,
                  ),
                  const SizedBox(height: 5),
                  const SizedBox(
                    width: 40.0,
                    height: 3,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: appPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Form(
                child: buildUserEmailField(),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (!submitBtnLoading) {
                    onSubmit();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    submitBtnLoading ? const SizedBox(
                      height: 17,
                      width: 17,
                      child: CircularProgressIndicator(
                        color: Colors.black,
                        strokeWidth: 2,
                      ),
                    ) : const Text(FORGOT_PASSWORD_SUBMIT_BTN)
                  ],
                ),
                style: btnStylesSubmit,
              ),
              const SizedBox(height: 25),

              Column(
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: appGreyLightestBGColor,
                    borderRadius: BorderRadius.circular(5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text(
                        ACCOUNT_ALREADY_EXIST,
                        style: additionalTextStyles,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            ],
        ),
      ),
    );
  }

  // fields
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
    onSaved: (value) => setState(() => userEmail = value!),
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
}
