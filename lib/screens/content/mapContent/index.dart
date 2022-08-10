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

// search
import 'package:app/screens/content/mapContent/search/index.dart';


class MapContent extends StatefulWidget {
  const MapContent({Key? key}) : super(key: key);

  @override
  State<MapContent> createState() => _MapContentState();
}

class _MapContentState extends State<MapContent> {
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
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Find Spots'),
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
            UniconsLine.subject,
            size: 31,
          ),
          color: Colors.black,
          splashColor: Colors.transparent,
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              UniconsLine.search_alt,
              size: 27,
              color: Colors.black,
            ),
            splashColor: Colors.transparent,
            onPressed: () {
              showSearch(
                context: context,
                delegate: MapSearch()
              );
            },
          ), // user icon
        ],
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
}

