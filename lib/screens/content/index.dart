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
    const MessagesContent(),
    const FavouritesContent(),
    const SwappSpotsContent(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            label: BNB_MESSAGES,
            icon: Padding(
              padding: EdgeInsets.only(bottom: 5, top: 3),
              child: Icon(
                UniconsLine.comment_alt,
                size: 22,
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
            label: BNB_SWAPP_SPOTS,
            icon: Padding(
              padding: EdgeInsets.only(bottom: 5, top: 3),
              child: Icon(
                UniconsLine.map_marker,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );

  }
}
