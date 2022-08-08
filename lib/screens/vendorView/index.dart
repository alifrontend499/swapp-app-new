import 'package:flutter/material.dart';

// carousel
import 'package:carousel_slider/carousel_slider.dart';

// colors
import 'package:app/theme/colors.dart';

// google fonts
import 'package:google_fonts/google_fonts.dart';

// toast
import 'package:fluttertoast/fluttertoast.dart';

// modal classes
import 'package:app/screens/vendorView/modal/offers_data.dart';
import 'package:app/screens/vendorView/modal/checked_in_users_data.dart';

// routes
import 'package:app/theme/routing/routing_constants.dart';

// icons
import 'package:unicons/unicons.dart';

// page consts
import 'package:app/screens/vendorView/const/textConsts.dart';

class VendorViewScreen extends StatefulWidget {
  const VendorViewScreen({Key? key}) : super(key: key);

  @override
  State<VendorViewScreen> createState() => _VendorViewScreenState();
}

class _VendorViewScreenState extends State<VendorViewScreen> {

  // STYLES
  final vendorNameStyles = GoogleFonts.montserrat(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: appTextColorPrimary,
  );
  final vendorTimeStyles = GoogleFonts.montserrat(
    fontSize: 15,
  );
  final vendorDetailsStyles = GoogleFonts.montserrat(
    fontSize: 16,
    color: appTextColorPrimary,
  );
  final pageHeadingStyles = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  final offerTextStyles = GoogleFonts.montserrat(
    fontSize: 16,
  );
  final userHeadingStyles = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w600
  );
  final userMessageStyles = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: appTextColorPrimary
  );
  final userDesgStyles = GoogleFonts.montserrat(
      fontSize: 15,
  );
  final optionTextStyles = GoogleFonts.montserrat(
    fontSize: 15,
  );

  // DATA
  // slider images
  List<String> sliderImages = [
    'https://jssors8.azureedge.net/demos/image-slider/img/faded-monaco-scenery-evening-dark-picjumbo-com-image.jpg',
    'https://wowslider.com/sliders/demo-51/data1/images/car.jpg',
    'https://jssors8.azureedge.net/demos/image-slider/img/px-fun-man-person-2361598-image.jpg',
    'https://jssors8.azureedge.net/demos/image-slider/img/px-beach-daylight-fun-1430675-image.jpg'
  ];

  // vendors details
  Map<String, dynamic> vendorData = {
    'vendorImg': 'https://images-platform.99static.com//ajhhZUw6asghzm5CqY0pzc_Yuxw=/654x0:1299x645/fit-in/500x500/99designs-contests-attachments/115/115901/attachment_115901077',
    'vendorName': '69 Westow Hill, Norwood, London SE19 1TX',
    'timeFrom': '10am',
    'timeTo': '06pm',
    'vendorContactNumber': '020 876 11330',
    'vendorEmailAddress': 'info@telltale.co.uk',
    'isFav': false,
  };

  // offers data
  final List<OffersDataItem> offers = [
    OffersDataItem(
      type: 'wifi',
      text: 'Free WiFi',
    ),
    OffersDataItem(
      type: 'alcohol',
      text: 'Serve Alcohol',
    ),
    OffersDataItem(
      type: 'pets',
      text: 'Pet Friendly',
    ),
    OffersDataItem(
      type: 'food',
      text: 'Serve Food',
    ),
    OffersDataItem(
      type: 'outdoor',
      text: 'Outdoor Seating',
    ),
  ];

  // checked in users data
  final List<CheckedInUsersDataItem> checkedInUsers = [
    CheckedInUsersDataItem(
      imgUrl: 'https://i.pinimg.com/originals/8b/16/7a/8b167af653c2399dd93b952a48740620.jpg',
      userName: 'Chris Mitchell',
      desg: 'Solicitor, Medical Industry'
    ),
    CheckedInUsersDataItem(
      imgUrl: 'https://i.pinimg.com/736x/89/90/48/899048ab0cc455154006fdb9676964b3.jpg',
      userName: 'Olivia',
      desg: 'Designer'
    ),
    CheckedInUsersDataItem(
      imgUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbBMwRJfFeRL23d-4MB-yq_6NyJFUw7zprYQ&usqp=CAU',
      userName: 'Dave',
      desg: 'Media'
    ),
  ];

  // functions
  void showToast(msg) => Fluttertoast.showToast(
      msg: msg,
      fontSize: 15
  );

  Future<void> onRefresh() {
    return Future.delayed(
      const Duration(seconds: 1), () {
      showToast('List Updated');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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

      body: RefreshIndicator(
          onRefresh: () => onRefresh(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // child | carousel
                CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 320,
                    autoPlay: true,
                    disableCenter: true,
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                  ),
                  itemCount: sliderImages.length,
                  itemBuilder: (context, index, realIndex) {
                    final urlImg = sliderImages[index];
                    return buildImg(urlImg, index);
                  },
                ),

                // child | other content
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // child | vendor details
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // child | vendor details | top part
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  child: Image.network(
                                    vendorData['vendorImg'],
                                    height: 55,
                                    width: 55,
                                    fit: BoxFit.cover,
                                  ),
                                  // borderRadius: BorderRadius.circular(65.0),
                                ),
                                const SizedBox(width: 20),

                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        vendorData['vendorName'],
                                        style: vendorNameStyles,
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Hours: ',
                                            style: vendorTimeStyles,
                                          ),
                                          Expanded(
                                            child: Text(
                                              vendorData['timeFrom'] + ' - ' + vendorData['timeTo'],
                                              style: vendorTimeStyles,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: IconButton(
                                    splashColor: Colors.transparent,
                                    onPressed: () {
                                      showToast(
                                          (vendorData['isFav'] == true) ? 'Removed from favourites' : 'Added to favourites'
                                      );

                                      setState(() {
                                        vendorData['isFav'] = !vendorData['isFav'];
                                      });
                                    },
                                    icon: Icon(
                                      (vendorData['isFav'] == true) ? UniconsSolid.bookmark : UniconsLine.bookmark,
                                      size: 30,
                                      color: appPrimaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),

                            // child | vendor details | bottom part
                            Wrap(
                              spacing: 15.0,
                              runSpacing: 15.0,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      UniconsLine.phone,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 7),
                                    Text(
                                      vendorData['vendorContactNumber'],
                                      style: vendorDetailsStyles,
                                    ),
                                  ],
                                ),

                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      UniconsLine.envelope,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 7),
                                    Text(
                                      vendorData['vendorEmailAddress'],
                                      style: vendorDetailsStyles,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      // divider
                      // const Padding(
                      //   padding: EdgeInsets.only(left: 30, right: 30),
                      //   child: Divider(
                      //     thickness: 1,
                      //     color: Colors.black45,
                      //   ),
                      // ),
                      // const SizedBox(height: 10),

                      // child | vendor info
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column( // page heading
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Vendor Info',
                                  style: pageHeadingStyles,
                                ),
                                const SizedBox(height: 5),
                                const SizedBox(
                                  width: 40.0,
                                  height: 3,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: appPrimaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),

                            SizedBox(
                              width: double.infinity,
                              child: Wrap(
                                spacing: 17.0,
                                runSpacing: 12.0,
                                children: offers.asMap().entries.map((item) => (
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if(item.value.type == 'wifi') ...[
                                          const Icon(
                                            UniconsLine.wifi,
                                            size: 20,
                                          ),
                                        ],
                                        if(item.value.type == 'alcohol') ...[
                                          const Icon(
                                            UniconsLine.glass_martini,
                                            size: 20,
                                          ),
                                        ],
                                        if(item.value.type == 'pets') ...[
                                          const Icon(
                                            UniconsLine.heart,
                                            size: 20,
                                          ),
                                        ],
                                        if(item.value.type == 'food') ...[
                                          const Icon(
                                            UniconsLine.utensils,
                                            size: 20,
                                          ),
                                        ],
                                        if(item.value.type == 'outdoor') ...[
                                          const Icon(
                                            UniconsLine.sun,
                                            size: 20,
                                          ),
                                        ],
                                        const SizedBox(width: 7),

                                        Text(
                                          item.value.text,
                                          style: offerTextStyles,
                                        ),
                                      ],
                                    )
                                )).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      // divider
                      // const Padding(
                      //   padding: EdgeInsets.only(left: 30, right: 30),
                      //   child: Divider(
                      //     thickness: 1,
                      //     color: Colors.black45,
                      //   ),
                      // ),
                      // const SizedBox(height: 10),

                      // child | checked-in users
                      Padding(
                        padding: const EdgeInsets.only(left: 0, right: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15, right: 15),
                              child: Column( // page heading
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Checked-in Users',
                                    style: pageHeadingStyles,
                                  ),
                                  const SizedBox(height: 5),
                                  const SizedBox(
                                    width: 40.0,
                                    height: 3,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: appPrimaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: checkedInUsers.asMap().entries.map((item) => (
                                InkWell(
                                  onTap: () => Navigator.pushNamed(context, messagesViewScreenRoute),
                                  // borderRadius: BorderRadius.circular(5),
                                  splashColor: Colors.transparent,
                                  highlightColor: appGreyHighlightBGColor,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // child | image
                                        ClipRRect(
                                          child: Image.network(
                                            item.value.imgUrl,
                                            height: 45,
                                            width: 45,
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: BorderRadius.circular(65.0),
                                        ),

                                        // child | other elements
                                        Expanded(
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // child | left elements
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 15, left: 15),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      // child | heading
                                                      Text(
                                                        item.value.userName,
                                                        style: userHeadingStyles,
                                                      ),
                                                      const SizedBox(height: 5),

                                                      // child | heading
                                                      Text(
                                                        item.value.desg,
                                                        style: userDesgStyles,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              // child | right elements
                                              // Text(
                                              //   'Message',
                                              //   style: userMessageStyles,
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              )).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

  // image carousel data
  Widget buildImg(String urlImg, int index) => Container(
    color: Colors.black12,
    child: Image.network(
      urlImg,
      fit: BoxFit.cover,
    ),
  );

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
                  REPORT_VENDOR,
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
