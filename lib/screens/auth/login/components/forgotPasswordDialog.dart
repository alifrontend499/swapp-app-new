import 'package:flutter/material.dart';

// common colors
import 'package:app/theme/colors.dart';

// page consts
import 'package:app/screens/auth/login/const/textConsts.dart';


class ForgotPasswordDialog extends StatelessWidget {
  final TextStyle pageHeadingStyles;
  final TextStyle additionalTextStyles;
  final Widget buildUserEmailField;
  final bool submitBtnLoading;
  final ButtonStyle btnStylesSubmit;
  final Function onSubmit;
  final GlobalKey<FormState> formKey;


  const ForgotPasswordDialog({
    Key? key,
    required this.pageHeadingStyles,
    required this.additionalTextStyles,
    required this.buildUserEmailField,
    required this.submitBtnLoading,
    required this.btnStylesSubmit,
    required this.onSubmit,
    required this.formKey,

  }) : super(key: key);

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
            // child | heading
            Column(
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

            // child | form
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // child | form
                Form(
                  key: formKey,
                  child: buildUserEmailField,
                ),
                const SizedBox(height: 30),

                // child | submit btn
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
              ],
            ),
            const SizedBox(height: 25),

            // child | additional details
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
    );
  }
}
