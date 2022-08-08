import 'package:flutter/material.dart';

// google fonts
import 'package:google_fonts/google_fonts.dart';

// colors
import 'package:app/theme/colors.dart';

// qr code
import 'package:qr_flutter/qr_flutter.dart';

// toast
import 'package:fluttertoast/fluttertoast.dart';

// route
import 'package:app/theme/routing/routing_constants.dart';

// page consts
import 'package:app/screens/content/const/textConsts.dart';

// icons
import 'package:unicons/unicons.dart';

class FavouritesContent extends StatefulWidget {
  const FavouritesContent({Key? key}) : super(key: key);

  @override
  State<FavouritesContent> createState() => _FavouritesContentState();
}

class _FavouritesContentState extends State<FavouritesContent> {
  // styles
  final itemHeadingStyles = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: appTextColorPrimary,
  );
  final descTextBoldStyles = GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  final descTextStyles = GoogleFonts.montserrat(
    fontSize: 15,
  );
  final qrCodeStyles = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  final codeStyles = GoogleFonts.montserrat(
    fontSize: 25,
    fontWeight: FontWeight.w600,
    letterSpacing: 7
  );
  final codeBtnStyles = ElevatedButton.styleFrom(
    elevation: 0,
    splashFactory: NoSplash.splashFactory,
    minimumSize: const Size(115, 34),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10)
    ),
    primary: appPrimaryBtnColor,
    onPrimary: Colors.black87,
    textStyle: GoogleFonts.montserrat(
      textStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  void showToast(msg) => Fluttertoast.showToast(
      msg: msg,
      fontSize: 15
  );

  // data
  List<Map<String, dynamic>> favourites = [
    {
      'title': 'The White Hart - 0.1 mile',
      'timeFrom': '10am',
      'timeTo': '5pm',
      'offer': 'Bottomless coffee when ordering lunch',
      'offerType': 'qr',
      'offerCode': 'testqrcode',
      'isFav': true,
    },
    {
      'title': 'The new lagoon - 0.2 mile',
      'timeFrom': '9am',
      'timeTo': '4pm',
      'offer': 'Free food one time',
      'offerType': 'code',
      'offerCode': 'GETITNOW',
      'isFav': true,
    },
    {
      'title': 'The White Hart - 0.1 mile',
      'timeFrom': '10am',
      'timeTo': '5pm',
      'offer': 'Bottomless coffee when ordering lunch',
      'offerType': 'qr',
      'offerCode': 'testqrcode',
      'isFav': true,
    },
    {
      'title': 'The new lagoon - 0.2 mile',
      'timeFrom': '9am',
      'timeTo': '4pm',
      'offer': 'Free food one time',
      'offerType': 'code',
      'offerCode': 'GETITNOW',
      'isFav': true,
    },
    {
      'title': 'The White Hart - 0.1 mile',
      'timeFrom': '10am',
      'timeTo': '5pm',
      'offer': 'Bottomless coffee when ordering lunch',
      'offerType': 'qr',
      'offerCode': 'testqrcode',
      'isFav': true,
    },
  ];

  // functions
  Future<void> onRefresh() {
    return Future.delayed(
      const Duration(seconds: 1), () {
        showToast('List Updated');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(FAV_PAGE_TITLE),
        titleTextStyle: GoogleFonts.montserrat(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        centerTitle: true,
        leading: null,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () => onRefresh(),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemCount: favourites.length,
          itemBuilder: (context, index) {
            final item = favourites[index];
            return InkWell( // item start
              splashColor: Colors.transparent,
              highlightColor: appGreyHighlightBGColor,
              onTap: () => Navigator.pushNamed(context, vendorViewScreenRoute),
              child: Container(
                padding: const EdgeInsets.only(top: 7, left: 15, right: 15),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'],
                              style: itemHeadingStyles,
                            ),
                            const SizedBox(height: 7),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hours: ',
                                  style: descTextBoldStyles,
                                ),
                                Expanded(
                                  child: Text(
                                    item['timeFrom'] + ' - ' + item['timeTo'],
                                    style: descTextStyles,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Offer: ',
                                  style: descTextBoldStyles,
                                ),
                                Expanded(
                                  child: Text(
                                    item['offer'],
                                    style: descTextStyles,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 7),
                            if (item['offerType'] == 'qr') ...[
                              ElevatedButton.icon(
                                  onPressed: () => showModalBottomSheet(
                                    // enableDrag: false,
                                    // isDismissible: false,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) => qrCodeBottomSheet(item['offerCode']),
                                  ),
                                  icon: const Icon(
                                    UniconsLine.qrcode_scan,
                                    size: 17,
                                  ),
                                  label: const Text(FAV_PAGE_BTN_QR_CODE),
                                  style: codeBtnStyles
                              ),
                            ] else ...[
                              ElevatedButton.icon(
                                  onPressed: () => showModalBottomSheet(
                                    // enableDrag: false,
                                    // isDismissible: false,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) => codeBottomSheet(item['offerCode']),
                                  ),
                                  icon: const Icon(
                                    UniconsLine.ticket,
                                    size: 17,
                                  ),
                                  label: const Text(FAV_PAGE_BTN_CODE),
                                  style: codeBtnStyles
                              ),
                            ],
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: IconButton(
                          splashColor: Colors.transparent,
                          onPressed: () {
                            showToast(
                                (item['isFav'] == true) ? FAV_PAGE_NOTI_REMOVED_TO_FAV : FAV_PAGE_NOTI_ADDED_TO_FAV
                            );

                            setState(() {
                              item['isFav'] = !item['isFav'];
                            });
                          },
                          icon: Icon(
                            (item['isFav'] == true) ? UniconsSolid.bookmark : UniconsLine.bookmark,
                            size: 33,
                            color: appPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      )
    );
  }

  // qr modal
  Widget qrCodeBottomSheet(qrCode) => Container(
    padding: const EdgeInsets.only(top: 50),
    child: Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close, size: 30),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: QrImage(
                    data: qrCode,
                    size: 270,
                  ),
                ),
                const SizedBox(height: 15),

                Text(
                  FAV_PAGE_BOTTOM_SHEET_QR_CODE,
                  textAlign: TextAlign.center,
                  style: qrCodeStyles,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  // code modal
  Widget codeBottomSheet(code) => Container(
    padding: const EdgeInsets.only(top: 50),
    child: Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close, size: 30),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: appPrimaryColor,
                  ),
                  width: 300,
                  child: Text(
                    code,
                    textAlign: TextAlign.center,
                    style: codeStyles,
                  ),
                ),
                const SizedBox(height: 15),

                Text(
                  FAV_PAGE_BOTTOM_SHEET_CODE,
                  textAlign: TextAlign.center,
                  style: qrCodeStyles,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
