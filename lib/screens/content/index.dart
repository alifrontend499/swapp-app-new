import 'package:flutter/material.dart';

// colors
import 'package:app/theme/colors.dart';

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

// routes
import 'package:app/theme/routing/routing_constants.dart';

// toast
import 'package:fluttertoast/fluttertoast.dart';

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

  int currentIndex = 0;

  final screens= [
    const MapContent(),
    const SwappSpotsContent(),
    const FavouritesContent(),
    const MessagesContent(),
  ];

  void showToast(msg) => Fluttertoast.showToast(
      msg: msg,
      fontSize: 15
  );

  String userStatus = STATUS_OFFLINE;
  void onUserStatusChanged() => {
    if(userStatus == STATUS_OFFLINE) {
      setState(() { userStatus = STATUS_ONLINE;}),
      Fluttertoast.cancel(),
      showToast(STATUS_CHANGED)
    } else {
      setState(() { userStatus = STATUS_OFFLINE;}),
      Fluttertoast.cancel(),
      showToast(STATUS_CHANGED)
    }
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );

  }

  // drawer content
  Widget drawerContent() {
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
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
