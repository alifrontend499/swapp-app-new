import 'package:app/theme/routing/routing_constants.dart';
import 'package:flutter/material.dart';

// google fonts
import 'package:google_fonts/google_fonts.dart';

// colors
import 'package:app/theme/colors.dart';

// page text
import 'package:app/screens/auth/login/const/textConsts.dart';

// icons
import 'package:unicons/unicons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = true;

  // styles
  final btnStylesFacebook = ElevatedButton.styleFrom(
    splashFactory: NoSplash.splashFactory,
    minimumSize: const Size(260, 48),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40)
    ),
    primary: btnColorFacebook,
    onPrimary: Colors.white,
    textStyle: GoogleFonts.montserrat(
      textStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600
      ),
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
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40)
    ),
    primary: btnColorApple,
    onPrimary: Colors.white,
    textStyle: GoogleFonts.montserrat(
      textStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
  final orTextStyles = GoogleFonts.montserrat(
    fontSize: 17,
    fontWeight: FontWeight.w700
  );
  final labelTextStyles = GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w600
  );

  final additionalTextStyles = GoogleFonts.montserrat(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: appTextColorPrimary,
    letterSpacing: 2
  );
  final btnStylesSubmit = ElevatedButton.styleFrom(
    splashFactory: NoSplash.splashFactory,
    minimumSize: const Size(260, 48),
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
  final pageHeadingStyles = GoogleFonts.montserrat(
    fontSize: 17,
    fontWeight: FontWeight.w600,
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
                    onPressed: () { },
                    child: const Text(LOGIN_WITH_FACEBOOK),
                    style: btnStylesFacebook,
                  ),
                  const SizedBox(height: 15),

                  ElevatedButton(
                    onPressed: () { },
                    child: const Text(LOGIN_WITH_GOOGLE),
                    style: btnStylesGoogle,
                  ),
                  const SizedBox(height: 15),

                  ElevatedButton(
                    onPressed: () { },
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
                  const SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, contentMainScreenRoute),
                    child: const Text(LOGIN),
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
    builder: (context) => Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column( // page heading
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
            const SizedBox(height: 15),

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

            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, contentMainScreenRoute),
              child: const Text(FORGOT_PASSWORD_SUBMIT_BTN),
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
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
    )
  );
}
