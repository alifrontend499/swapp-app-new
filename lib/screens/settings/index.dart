import 'package:flutter/material.dart';

// page consts
import 'package:app/screens/settings/consts/textConsts.dart';

// google fonts
import 'package:google_fonts/google_fonts.dart';

// icons
import 'package:unicons/unicons.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(SETTINGS_PAGE_TITLE),
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


    );
  }
}
