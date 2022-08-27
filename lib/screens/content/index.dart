import 'package:flutter/material.dart';

// routing consts
import 'package:app/theme/routing/routing_constants.dart';

// common consts
import 'package:app/theme/commonConst/textConsts.dart';

// colors
import 'package:app/theme/colors.dart';

// common compontns
import 'package:app/theme/commonComponents/toast.dart';
import 'package:app/theme/commonComponents/snackBar.dart';

// page consts
import 'package:app/screens/content/const/textConsts.dart';

// google fonts
import 'package:google_fonts/google_fonts.dart';

// content screens
import 'package:app/screens/content/mapContent/index.dart';
import 'package:app/screens/content/messagesContent/index.dart';
import 'package:app/screens/content/favouritesContent/index.dart';
import 'package:app/screens/content/spotsContent/index.dart';

// icons
import 'package:unicons/unicons.dart';

// toast
import 'package:fluttertoast/fluttertoast.dart';

// components
import 'package:app/screens/content/components/leftDrawerContent.dart';

// app logout
import 'package:app/theme/utils/appLogout.dart';

class ContentMainScreen extends StatefulWidget {
  const ContentMainScreen({Key? key}) : super(key: key);

  @override
  State<ContentMainScreen> createState() => _ContentMainScreenState();
}

class _ContentMainScreenState extends State<ContentMainScreen> {
  // styles
  final labelStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.w600,
    fontSize: 12
  );

  int currentIndex = 0;

  final screens= [
    const MapContent(),
    const SwappSpotsContent(),
    const FavouritesContent(),
    const MessagesContent(),
  ];

  DateTime timeBackPressed = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= const Duration(seconds: 2);

        timeBackPressed = DateTime.now();
        if(isExitWarning) {
          // showing toast message
          showFlutterToast(COMMON_EXIT_APP_ON_DOUBLE_TAP);

          // disabling back action
          return false;
        } else {
          // closing toast message
          Fluttertoast.cancel();

          // allowing back action
          return true;
        }
      },
      child: Scaffold(
        drawer: Drawer(
          child: drawerContent(),
        ),

        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          unselectedItemColor: Colors.black87,
          selectedItemColor: appPrimaryColor,
          selectedLabelStyle: labelStyle,
          unselectedLabelStyle: labelStyle,
          items: const [
            BottomNavigationBarItem(
              label: BNB_MAP,
              icon: Padding(
                padding: EdgeInsets.only(bottom: 5, top: 3),
                child: Icon(
                  UniconsLine.map,
                  size: 22,
                ),
              ),
            ),

            BottomNavigationBarItem(
              label: BNB_SWAPP_SPOTS,
              icon: Padding(
                padding: EdgeInsets.only(bottom: 5, top: 3),
                child: Icon(
                  UniconsLine.map_marker,
                  size: 25,
                ),
              ),
            ),

            BottomNavigationBarItem(
              label: BNB_FAVOURITES,
              icon: Padding(
                padding: EdgeInsets.only(bottom: 5, top: 3),
                child: Icon(
                  UniconsLine.bookmark,
                  size: 24,
                ),
              ),
            ),

            BottomNavigationBarItem(
              label: BNB_MESSAGES,
              icon: Padding(
                padding: EdgeInsets.only(bottom: 5, top: 3),
                child: Icon(
                  UniconsLine.comment_alt,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  // styles
  final userNameStyles = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w600
  );
  final userDesgStyles = GoogleFonts.montserrat(
    fontSize: 15,
  );
  final drawerMenuItemStyle = GoogleFonts.montserrat(
    fontSize: 14.5,
  );
  final onlineStatusItemStyle = GoogleFonts.montserrat(
    fontSize: 12,
    fontWeight: FontWeight.w600
  );
  String userStatus = STATUS_OFFLINE;
  // change user online status
  void onUserStatusChanged() => {
    if(userStatus == STATUS_OFFLINE) {
      setState(() { userStatus = STATUS_ONLINE;}),
      showFlutterToast(STATUS_CHANGED)
    } else {
      setState(() { userStatus = STATUS_OFFLINE;}),
      showFlutterToast(STATUS_CHANGED)
    }
  };
  // log user out
  void logUserOut() async {
    // closing the dialog
    Navigator.pop(context);
    // closing the left drawer
    Navigator.of(context).pop();

    // logging user out
    appLogout();

    // hide all existing snackbar
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    // showing snack bar
    final successSnackBar = buildSnackBar(COMMON_LOGOUT_SUCCESS, 'success');
    ScaffoldMessenger.of(context).showSnackBar(successSnackBar);

    // navigate to initial screen after logout
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushNamedAndRemoveUntil(context, initialScreenRoute, (r) => false);
  }

  // drawer content
  Widget drawerContent() {
    return LeftDrawerContent(
      userNameStyles: userNameStyles,
      userDesgStyles: userDesgStyles,
      drawerMenuItemStyle: drawerMenuItemStyle,
      userStatus: userStatus,
      onUserStatusChanged: onUserStatusChanged,
      logUserOut: logoutDialog,
    );
  }

  // logout dialog
  final logoutDialogTitleStyles = GoogleFonts.montserrat(
      fontSize: 19,
      fontWeight: FontWeight.w600
  );
  final logoutDialogContentStyles = GoogleFonts.montserrat(
    fontSize: 15,
  );
  final logoutDialogBtnOk = ElevatedButton.styleFrom(
    splashFactory: NoSplash.splashFactory,
    minimumSize: const Size(80, 37),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
    elevation: 0,
    primary: appPrimaryBtnColor,
    onPrimary: appPrimaryBtnColorOnPrimary,
    textStyle: GoogleFonts.montserrat(
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600
      ),
    ),
  );
  final logoutDialogBtnCancel = ElevatedButton.styleFrom(
    splashFactory: NoSplash.splashFactory,
    minimumSize: const Size(80, 37),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
    elevation: 0,
    primary: appGrayBtnColor,
    onPrimary: appGrayBtnColorOnPrimary,
    textStyle: GoogleFonts.montserrat(
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600
      ),
    ),
  );

  // show dialog
  Future logoutDialog() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        "Logging out",
        style: logoutDialogTitleStyles,
      ),
      content: Text(
        COMMON_LOGOUT_CONFIRM,
        style: logoutDialogContentStyles,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
                style: logoutDialogBtnCancel,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () => logUserOut(),
                child: const Text('Ok'),
                style: logoutDialogBtnOk,
              ),
            ),
          ],
        ),
      ],
      titlePadding: const EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 13),
      contentPadding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
      actionsPadding: const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 10),
    ),
  );
}
