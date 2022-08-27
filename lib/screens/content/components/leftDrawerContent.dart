import 'package:flutter/material.dart';

// consts
import 'package:app/screens/content/const/textConsts.dart';

// common components
import 'package:app/theme/commonComponents/toast.dart';

// colors
import 'package:app/theme/colors.dart';

// google fonts
import 'package:google_fonts/google_fonts.dart';

// icons
import 'package:unicons/unicons.dart';

// routes
import 'package:app/theme/routing/routing_constants.dart';

class LeftDrawerContent extends StatelessWidget {
  final TextStyle userNameStyles;
  final TextStyle userDesgStyles;
  final TextStyle drawerMenuItemStyle;
  final String userStatus;
  final Function onUserStatusChanged;
  final Function logUserOut;

  const LeftDrawerContent({
    Key? key,
    required this.userNameStyles,
    required this.userDesgStyles,
    required this.drawerMenuItemStyle,
    required this.userStatus,
    required this.onUserStatusChanged,
    required this.logUserOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 20, top: 0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // child | user info
            Container(
              padding: const EdgeInsets.only(top: 50),
              color: appPrimaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  // child | user Image
                  ClipRRect(
                    child: Image.network(
                      'https://i.pinimg.com/736x/89/90/48/899048ab0cc455154006fdb9676964b3.jpg',
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(65.0),
                  ),
                  const SizedBox(height: 13),

                  // child | user name
                  Text(
                      'Chris MitchellChris',
                      style: userNameStyles,
                      textAlign: TextAlign.center
                  ),
                  const SizedBox(height: 3),

                  // child | user desg
                  Text(
                      'Engineer',
                      style: userDesgStyles,
                      textAlign: TextAlign.center
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            const SizedBox(height: 15),

            Column(
              children: [
                Stack(
                  children: [
                    ListTile(
                      leading: const Icon(
                        UniconsLine.check_circle,
                        color: Colors.black54,
                        size: 25,
                      ),
                      minLeadingWidth: 17,
                      title: Text(
                        LEFT_MENU_ITEM_STATUS,
                        style: drawerMenuItemStyle,
                      ),
                    ),
                    Positioned(
                        top: 19,
                        right: 20,
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: appGreyHighlightBGColor,
                          onTap: () => onUserStatusChanged(),
                          child: Text(
                            userStatus,
                            style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                background: Paint()
                                  ..strokeWidth = 18
                                  ..color = (userStatus == STATUS_ONLINE) ? Colors.green : Colors.grey
                                  ..style = PaintingStyle.stroke
                                  ..strokeJoin = StrokeJoin.round
                            ),
                          ),
                        )
                    ),
                  ],
                ),

                ListTile(
                  leading: const Icon(
                    UniconsLine.user,
                    color: Colors.black54,
                    size: 25,
                  ),
                  minLeadingWidth: 17,
                  title: Text(
                    LEFT_MENU_ITEM_PROFILE,
                    style: drawerMenuItemStyle,
                  ),
                  onTap: () => Navigator.popAndPushNamed(context, userProfileScreenRoute),
                ),

                ListTile(
                  leading: const Icon(
                    UniconsLine.map,
                    color: Colors.black54,
                    size: 25,
                  ),
                  minLeadingWidth: 17,
                  title: Text(
                    LEFT_MENU_ITEM_SPOT,
                    style: drawerMenuItemStyle,
                  ),
                  onTap: () {},
                ),

                ListTile(
                  leading: const Icon(
                    UniconsLine.setting,
                    color: Colors.black54,
                    size: 25,
                  ),
                  minLeadingWidth: 17,
                  title: Text(
                    LEFT_MENU_ITEM_SETTINGS,
                    style: drawerMenuItemStyle,
                  ),
                  onTap: () {},
                ),

                ListTile(
                  leading: const Icon(
                    UniconsLine.info_circle,
                    color: Colors.black54,
                    size: 25,
                  ),
                  minLeadingWidth: 17,
                  title: Text(
                    LEFT_MENU_ITEM_HELP,
                    style: drawerMenuItemStyle,
                  ),
                  onTap: () {},
                ),

                ListTile(
                  leading: const Icon(
                    UniconsLine.sign_out_alt,
                    color: Colors.black54,
                    size: 25,
                  ),
                  minLeadingWidth: 17,
                  title: Text(
                    LEFT_MENU_ITEM_LOGOUT,
                    style: drawerMenuItemStyle,
                  ),
                  onTap: () => logUserOut(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}