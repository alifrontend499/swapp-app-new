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
  String defaultMapStyle = '';
  late BitmapDescriptor mapIcon;
  Set<Marker> mapMarkers = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // loading map styles
    DefaultAssetBundle.of(context).loadString('assets/mapStyles/default_style.json').then((value) => defaultMapStyle = value);

    // loading map Icon
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(
        size: Size(50, 50)
      ),
      'assets/icons/map-icon.png'
    ).then((value) => mapIcon = value);
  }

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _posIndia = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(31.3260, 75.5762),
    // tilt: 50,
    zoom: 13,
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
              initialCameraPosition: _posIndia,
              markers: mapMarkers,
              mapToolbarEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                controller.setMapStyle(defaultMapStyle);

                setState(() {
                  mapMarkers = {
                    Marker(
                        markerId: const MarkerId('devi_talab'),
                        position: const LatLng(31.338613462594523, 75.56284504008605),
                        infoWindow: const InfoWindow(
                          title: 'Devi Talab Mandir',
                          snippet: 'Lorem Ipsum'
                        ),
                        icon: mapIcon
                    ),
                    Marker(
                        markerId: const MarkerId('wonderland'),
                        position: const LatLng(31.26307300041686, 75.53283375542392),
                        infoWindow: const InfoWindow(
                          title: 'Wonderland theme park',
                          snippet: 'Lorem Ipsum'
                        ),
                        icon: mapIcon
                    ),
                    Marker(
                        markerId: const MarkerId('science_city'),
                        position: const LatLng(31.35732045517554, 75.44032864192994),
                        infoWindow: const InfoWindow(
                          title: 'Science City',
                          snippet: 'Lorem Ipsum'
                        ),
                        icon: mapIcon
                    ),
                    Marker(
                        markerId: const MarkerId('talhan_sahib'),
                        position: const LatLng(31.310952110609655, 75.67027735358117),
                        infoWindow: const InfoWindow(
                          title: 'Talhan Sahib',
                          snippet: 'Lorem Ipsum'
                        ),
                        icon: mapIcon
                    ),
                    Marker(
                        markerId: const MarkerId('nikku_mark'),
                        position: const LatLng(31.308661243957665, 75.58222942843355),
                        infoWindow: const InfoWindow(
                          title: 'Jalandhar Nikku Park',
                          snippet: 'Lorem Ipsum'
                        ),
                        icon: mapIcon
                    ),
                    Marker(
                        markerId: const MarkerId('stadium'),
                        position: const LatLng(31.313377207469827, 75.58130889656114),
                        infoWindow: const InfoWindow(
                          title: 'Jalandhar Stadium',
                          snippet: 'Lorem Ipsum'
                        ),
                        icon: mapIcon
                    ),
                  };
                });
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

