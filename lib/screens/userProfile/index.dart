import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// routing consts
import 'package:app/theme/routing/routing_constants.dart';

// icons
import 'package:unicons/unicons.dart';

// google fonts
import 'package:google_fonts/google_fonts.dart';

// colors
import 'package:app/theme/colors.dart';

// page consts
import 'package:app/screens/userProfile/const/textConsts.dart';

// image picker
import 'package:image_picker/image_picker.dart';

// screens
import 'package:app/screens/userProfile/screens/editProfile.dart';


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
  final userNameStyles = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w600
  );
  final userDesgStyles = GoogleFonts.montserrat(
    fontSize: 15,
  );
  final userDetailsHead = GoogleFonts.montserrat(
    fontSize: 15,
    fontWeight: FontWeight.w600
  );
  final userDetailsDesc = GoogleFonts.montserrat(
    fontSize: 15,
  );
  final viewProfileBtnStyles = ElevatedButton.styleFrom(
    elevation: 0,
    splashFactory: NoSplash.splashFactory,
    minimumSize: const Size(double.infinity, 32),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(34)
    ),
    primary: appPrimaryBtnColor,
    onPrimary: appPrimaryBtnColorOnPrimary,
    textStyle: GoogleFonts.montserrat(
      textStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
  final userImageBtnStyle = ElevatedButton.styleFrom(
    elevation: 0,
    primary: appGreyDarkBGColor,
    onPrimary: Colors.black87,
    minimumSize: const Size(105, 105),
    splashFactory: NoSplash.splashFactory,
    shadowColor: Colors.transparent,
    padding: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50)
    ),
  );

  // IMAGE PICKER
  File? image;
  Future imgPickerFromGallery() async {
    try {
      // closing bottom sheet
      Navigator.pop(context);

      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } catch(e) {
      print('Failed to pick image: $e');
    }
  }

  Future imgPickerFromCamera() async {
    try {
      // closing bottom sheet
      Navigator.pop(context);

      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if(image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(PROFILE_PAGE_TITLE),
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

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // child | user info
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // child | user Image
                  Stack(
                    children: [
                      // child | Image
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: () => {},
                          child: image != null ? ClipRRect(
                            child: Image.file(
                              image!,
                              height: 105,
                              width: 105,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ) : const Icon(
                            UniconsLine.camera,
                            size: 35,
                          ),
                          style: userImageBtnStyle,
                        ),
                      ),

                      // child | Edit icon
                      Positioned(
                        right: 5,
                        bottom: 5,
                        child: InkWell(
                          onTap: () => showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => showImageOptions(),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(15)
                              ),
                            ),
                          ),
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              color: appPrimaryColor,
                              borderRadius: BorderRadius.circular(35)
                            ),
                            child: const Icon(
                              UniconsLine.pen,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

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
                  const SizedBox(height: 5),

                  // child | button
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).push(_createRoute()),
                    child: const Text(BTN_EDIT_PROFILE),
                    style: viewProfileBtnStyles
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // child | user info
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: appGreyLightestBGColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: userDetailsHead,
                        ),
                        const SizedBox(height: 5),

                        Text(
                          'Ted Mayborn',
                          style: userDetailsDesc,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: appGreyLightestBGColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Title',
                          style: userDetailsHead,
                        ),
                        const SizedBox(height: 5),

                        Text(
                          'Project Manager',
                          style: userDetailsDesc,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: appGreyLightestBGColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Industry',
                          style: userDetailsHead,
                        ),
                        const SizedBox(height: 5),

                        Text(
                          'Healthcare',
                          style: userDetailsDesc,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: appGreyLightestBGColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Status',
                          style: userDetailsHead,
                        ),
                        const SizedBox(height: 5),

                        Text(
                          'BUSY',
                          style: userDetailsDesc,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: appGreyLightestBGColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Subscription',
                          style: userDetailsHead,
                        ),
                        const SizedBox(height: 5),

                        Text(
                          '£4,99 / month',
                          style: userDetailsDesc,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '**** **** **** 4345',
                          style: userDetailsDesc,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),

              // child | profile page
            ],
          ),
        )
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

  // bottom sheet | image options
  Widget showImageOptions() => Container(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell( // option item
          splashColor: Colors.transparent,
          highlightColor: appGreyHighlightBGColor,
          onTap: () => imgPickerFromCamera(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
            child: Row(
              children: [
                const Icon(
                  UniconsLine.camera,
                  size: 21,
                ),
                const SizedBox(width: 13),

                Text(
                  USE_CAMERA,
                  style: optionTextStyles,
                ),
              ],
            ),
          ),
        ),

        InkWell( // option item
          splashColor: Colors.transparent,
          highlightColor: appGreyHighlightBGColor,
          onTap: () => imgPickerFromGallery(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
            child: Row(
              children: [
                const Icon(
                  UniconsLine.image,
                  size: 21,
                ),
                const SizedBox(width: 13),

                Text(
                  USE_GALLERY,
                  style: optionTextStyles,
                ),
              ],
            ),
          ),
        ),

        if(image != null) ...[
          InkWell( // option item
            splashColor: Colors.transparent,
            highlightColor: appGreyHighlightBGColor,
            onTap: () => {
              // closing bottom sheet
              Navigator.pop(context),

              // emptying image value
              setState(() {
                image = null;
              })
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
              child: Row(
                children: [
                  const Icon(
                    UniconsLine.trash_alt,
                    size: 21,
                  ),
                  const SizedBox(width: 13),

                  Text(
                    REMOVE_IMAGE,
                    style: optionTextStyles,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    ),
  );
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const EditProfileScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}