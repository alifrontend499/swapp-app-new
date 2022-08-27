import 'package:flutter/material.dart';

// app consts
import 'package:app/theme/commonConst/textConsts.dart';

// routing consts
import 'package:app/theme/routing/routing_constants.dart';

// google fonts
import 'package:google_fonts/google_fonts.dart';

// colors
import 'package:app/theme/colors.dart';

// page text
import 'package:app/screens/auth/login/const/textConsts.dart';
import 'package:shared_preferences/shared_preferences.dart';

// icons
import 'package:unicons/unicons.dart';

// components
import 'package:app/screens/auth/login/components/forgotPasswordDialog.dart';
// common components
import 'package:app/theme/commonComponents/snackBar.dart';

// http
import 'package:http/http.dart' as http;

// apis urls
import 'package:app/theme/apis/api_urls.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = true;
  bool loadingLogin = false;
  final _formKey = GlobalKey<FormState>();
  String userEmail = '';
  String userPassword = '';

  // styles
  final btnStylesFacebook = ElevatedButton.styleFrom(
    splashFactory: NoSplash.splashFactory,
    minimumSize: const Size(260, 48),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    primary: btnColorFacebook,
    onPrimary: Colors.white,
    textStyle: GoogleFonts.montserrat(
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    ),
  );
  final btnStylesGoogle = ElevatedButton.styleFrom(
    splashFactory: NoSplash.splashFactory,
    minimumSize: const Size(260, 48),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40),
    ),
    primary: btnColorGoogle,
    onPrimary: Colors.white,
    textStyle: GoogleFonts.montserrat(
      textStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
  final btnStylesApple = ElevatedButton.styleFrom(
    splashFactory: NoSplash.splashFactory,
    minimumSize: const Size(260, 48),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    primary: btnColorApple,
    onPrimary: Colors.white,
    textStyle: GoogleFonts.montserrat(
      textStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
  final orTextStyles = GoogleFonts.montserrat(fontSize: 17, fontWeight: FontWeight.w700);
  final labelTextStyles = GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600);
  final additionalTextStyles = GoogleFonts.montserrat(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: appTextColorPrimary,
    letterSpacing: 2
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
  final pageHeadingStyles = GoogleFonts.montserrat(
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );

  // submit login form
  void onSubmit() async {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();

      final errorSnackBar = buildSnackBar(SNACKBAR_MSG_INVALID_CREDS, 'error');
      final successSnackBar = buildSnackBar(SNACKBAR_MSG_VALID_CREDS, 'success');

      // showing loading
      setState(() => loadingLogin = true);
      final sharedPrefs = await SharedPreferences.getInstance();

      try {
        // unfocus the inputs
        FocusManager.instance.primaryFocus?.unfocus();

        // network request
        final response = await http.post(Uri.parse(userLoginApi),
          body: {'email': userEmail, 'password': userPassword}
        );

        print('Response status: ${response.statusCode}');

        // showing snackbar
        ScaffoldMessenger.of(context).showSnackBar(successSnackBar);

        // removing value from shared preferences
        sharedPrefs.remove(SHARED_PREF_KEY_IS_USER_LOGGED_IN);
        // setting value in shared preferences
        sharedPrefs.setBool(SHARED_PREF_KEY_IS_USER_LOGGED_IN, true);

        // navigate to main screen and remove all the history
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pushNamedAndRemoveUntil(context, contentMainScreenRoute, (r) => false);
      } catch (err) {
        print('Error Occurred: ${err}');

        // hiding loading
        setState(() => loadingLogin = false);

        // showing snackbar
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
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(LOGIN_WITH_FACEBOOK),
                  style: btnStylesFacebook,
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(LOGIN_WITH_GOOGLE),
                  style: btnStylesGoogle,
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(LOGIN_WITH_APPLE),
                  style: btnStylesApple,
                ),
                const SizedBox(height: 40),
                Text(
                  OR,
                  style: orTextStyles,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          EMAIL_ADDRESS,
                          style: labelTextStyles,
                        ),
                        const SizedBox(height: 5),
                        buildUserEmailField(),
                        const SizedBox(height: 15),
                        Text(
                          PASSWORD,
                          style: labelTextStyles,
                        ),
                        const SizedBox(height: 5),
                        buildUserPasswordField(),
                      ],
                    ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (!loadingLogin) {
                      onSubmit();
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      loadingLogin ? const SizedBox(
                        height: 17,
                        width: 17,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 2,
                        ),
                      ) : const Text(LOGIN)
                    ],
                  ),
                  style: btnStylesSubmit,
                ),
                const SizedBox(height: 40),
                Column(
                  children: [
                    InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: appGreyLightestBGColor,
                        borderRadius: BorderRadius.circular(5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            FORGOT_PASSWORD,
                            style: additionalTextStyles,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () => openForgotPasswordDialog()
                    ),
                    const SizedBox(height: 13),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: appGreyLightestBGColor,
                      borderRadius: BorderRadius.circular(5),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text(
                          CREATE_ACCOUNT,
                          style: additionalTextStyles,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: () => Navigator.pushNamed(context, signupStep1ScreenRoute),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // forgot password dialog
  Future openForgotPasswordDialog() => showDialog(
    context: context,
    builder: (context) => const ForgotPasswordDialog(),
  );

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

  // field: password
  Widget buildUserPasswordField() => TextFormField(
    obscureText: isPasswordVisible,
    decoration: InputDecoration(
      hintText: ENTER_PASSWORD,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(45),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
      suffixIcon: IconButton(
        onPressed: () {
          setState(() => isPasswordVisible = !isPasswordVisible);
        },
        icon: isPasswordVisible ? const Icon(UniconsLine.eye_slash) : const Icon(UniconsLine.eye),
      ),
    ),
    onSaved: (value) => setState(() => userPassword = value!),
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
