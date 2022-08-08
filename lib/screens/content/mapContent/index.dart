import 'dart:async';

import 'package:flutter/material.dart';

// google fonts
import 'package:google_fonts/google_fonts.dart';

// google maps
import 'package:google_maps_flutter/google_maps_flutter.dart';

// icons
import 'package:unicons/unicons.dart';

// colors
import 'package:app/theme/colors.dart';

class MapContent extends StatefulWidget {
  const MapContent({Key? key}) : super(key: key);

  @override
  State<MapContent> createState() => _MapContentState();
}

class _MapContentState extends State<MapContent> {
  // styles
  final userNameStyles = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w600
  );
  final userDesgStyles = GoogleFonts.montserrat(
    fontSize: 15,
  );


  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          size: 45,
          color: Colors.white
        ),
        actionsIconTheme: const IconThemeData(
          size: 45,
          color: Colors.white
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              UniconsLine.user_location,
              size: 35,
            ),
          ),
        ],
      ),

      drawer: Drawer(
        child: drawerContent(),
      ),

      body: Stack(
        fit: StackFit.expand,
        children: [
          // child | map view
          Expanded(
            child: GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),

          // Positioned(
          //   top: 40,
          //   left: 15,
          //   child: IconButton(
          //     splashColor: Colors.red,
          //     onPressed: () {},
          //     iconSize: 40,
          //     color: Colors.white,
          //     icon: const Icon(
          //       UniconsLine.bars,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  // drawer content
  Widget drawerContent() {
    return Container(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 20, top: 40),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // child | user info
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
              ],
            ),

            const Divider(color: Colors.black54),

            // const Divider(color: Colors.black54),
            Column(
              children: [
                ListTile(
                  leading: const Icon(
                    UniconsLine.home_alt,
                  ),
                  title: const Text('Home'),
                  onTap: () {},
                ),

                ListTile(
                  leading: const Icon(
                    UniconsLine.user,
                  ),
                  title: const Text('Profile'),
                  onTap: () {},
                ),

                ListTile(
                  leading: const Icon(
                    UniconsLine.info_circle,
                  ),
                  title: const Text('Help'),
                  onTap: () {},
                ),

                ListTile(
                  leading: const Icon(
                    UniconsLine.sign_out_alt,
                  ),
                  title: const Text('Logout'),
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

