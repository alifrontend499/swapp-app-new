import 'package:flutter/material.dart';

// icons
import 'package:unicons/unicons.dart';

// google fonts
import 'package:google_fonts/google_fonts.dart';

// colors
import 'package:app/theme/colors.dart';

// page consts
import 'package:app/screens/userProfile/const/textConsts.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

  // styles
  final optionTextStyles = GoogleFonts.montserrat(
    fontSize: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            UniconsLine.angle_left,
            size: 30,
          ),
          color: Colors.white,
          splashColor: Colors.transparent,
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => showOptions(),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(15)
                    )
                )
            ),
            icon: const Icon(
              UniconsLine.ellipsis_v,
              size: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // bottom sheet | options
  Widget showOptions() => Container(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell( // option item
          splashColor: Colors.transparent,
          highlightColor: appGreyHighlightBGColor,
          onTap: () => {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
            child: Row(
              children: [
                const Icon(
                  UniconsLine.exclamation_circle,
                  size: 21,
                ),
                const SizedBox(width: 13),

                Text(
                  NEED_HELP,
                  style: optionTextStyles,
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

