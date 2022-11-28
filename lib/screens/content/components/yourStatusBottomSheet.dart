import 'package:flutter/material.dart';

// google fonts
import 'package:google_fonts/google_fonts.dart';

// consts
import 'package:app/screens/content/const/textConsts.dart';

// icons
import 'package:unicons/unicons.dart';

// colors
import 'package:app/theme/colors.dart';

// package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/screens/content/components/state/leftDrawerState.dart';

// toast
import 'package:fluttertoast/fluttertoast.dart';

// styles
final optionTextStyles = GoogleFonts.montserrat(
  fontSize: 16.5,
  fontWeight: FontWeight.w600,
);
final optionTextDescription = GoogleFonts.montserrat(
  fontSize: 14,
);

// helpers functions
void showToast(String msg) => Fluttertoast.showToast(msg: msg, fontSize: 15);

class YourStatusBottomSheet extends ConsumerWidget {
  const YourStatusBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedUserStatus = ref.watch(selectedUserStatusProvider);

    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            // option item
            splashColor: Colors.transparent,
            highlightColor: appGreyHighlightBGColor,
            borderRadius: BorderRadius.circular(5),
            onTap: () {
              if (selectedUserStatus != STATUS_WORK) {
                // setting active status
                ref.read(selectedUserStatusProvider.notifier).state =
                    STATUS_WORK;

                // showing toast
                showToast('Status changed to $STATUS_WORK');

                // closing dialog
                Navigator.pop(context);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: selectedUserStatus == STATUS_WORK
                    ? appPrimaryColor
                    : Colors.white,
              ),
              child: Row(
                children: [
                  if (selectedUserStatus == STATUS_WORK) ...[
                    const Icon(
                      UniconsLine.check_circle,
                      size: 26,
                    ),
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          STATUS_WORK,
                          style: optionTextStyles,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          STATUS_WORK_DESCRIPTION,
                          style: optionTextDescription,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          InkWell(
            // option item
            splashColor: Colors.transparent,
            highlightColor: appGreyHighlightBGColor,
            borderRadius: BorderRadius.circular(5),
            onTap: () {
              if (selectedUserStatus != STATUS_OFF_FROM_WORK) {
                // setting active status
                ref.read(selectedUserStatusProvider.notifier).state =
                    STATUS_OFF_FROM_WORK;

                // showing toast
                showToast('Status changed to $STATUS_OFF_FROM_WORK');

                // closing dialog
                Navigator.pop(context);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: selectedUserStatus == STATUS_OFF_FROM_WORK
                    ? appPrimaryColor
                    : Colors.white,
              ),
              child: Row(
                children: [
                  if (selectedUserStatus == STATUS_OFF_FROM_WORK) ...[
                    const Icon(
                      UniconsLine.check_circle,
                      size: 25,
                    ),
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          STATUS_OFF_FROM_WORK,
                          style: optionTextStyles,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          STATUS_OFF_FROM_WORK_DESCRIPTION,
                          style: optionTextDescription,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          InkWell(
            // option item
            splashColor: Colors.transparent,
            highlightColor: appGreyHighlightBGColor,
            borderRadius: BorderRadius.circular(5),
            onTap: () {
              if (selectedUserStatus != STATUS_AFTER_WORK) {
                // setting active status
                ref.read(selectedUserStatusProvider.notifier).state =
                    STATUS_AFTER_WORK;

                // showing toast
                showToast('Status changed to $STATUS_AFTER_WORK');

                // closing dialog
                Navigator.pop(context);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: selectedUserStatus == STATUS_AFTER_WORK
                    ? appPrimaryColor
                    : Colors.white,
              ),
              child: Row(
                children: [
                  if (selectedUserStatus == STATUS_AFTER_WORK) ...[
                    const Icon(
                      UniconsLine.check_circle,
                      size: 25,
                    ),
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          STATUS_AFTER_WORK,
                          style: optionTextStyles,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          STATUS_AFTER_WORK_DESCRIPTION,
                          style: optionTextDescription,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
