import 'dart:convert';
import 'package:flutter/material.dart';

// toast
import 'package:fluttertoast/fluttertoast.dart';

// image
import 'package:qr_flutter/qr_flutter.dart';

// icons
import 'package:unicons/unicons.dart';

// routing consts
import 'package:app/theme/routing/routing_constants.dart';

// global colors
import 'package:app/theme/colors.dart';

// google fonts
import 'package:google_fonts/google_fonts.dart';

// common consts
import 'package:app/theme/commonConst/textConsts.dart';

// page consts
import 'package:app/screens/content/const/textConsts.dart';

// modals
import 'package:app/screens/content/spotsContent/modals/spot_list_modal.dart';

// http
import 'package:http/http.dart' as http;

// apis urls
import 'package:app/theme/apis/api_urls.dart';

// shared preferences
import 'package:shared_preferences/shared_preferences.dart';

// content loading
import 'package:app/screens/content/favouritesContent/content_loading.dart';

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


class SwappSpotsContent extends StatefulWidget {
  const SwappSpotsContent({Key? key}) : super(key: key);

  @override
  State<SwappSpotsContent> createState() => _SwappSpotsContentState();
}

class _SwappSpotsContentState extends State<SwappSpotsContent> {
  final _listViewController = ScrollController();
  static int apiDataLimit = 10;
  int apiCurrentPage = 1;
  late List<SpotListModal> contentData = [];
  bool contentLoading = false;
  bool hasMoreContentToLoad = true;
  bool hasApiError = false;

  @override
  void initState() {
    super.initState();

    if(contentData.isEmpty) {
      fetchContentData();
    }

    // when page is at the end
    _listViewController.addListener(() {
      if(_listViewController.position.maxScrollExtent == _listViewController.offset) {
        fetchContentData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _listViewController.dispose();
  }

  Future fetchContentData() async {
    // if loading is in progress then do not execute this function
    if(contentLoading) return;

    // showing loading only if the user is loading the data for the first time
    if(apiCurrentPage == 1) {
      setState(() => contentLoading = true);
    }

    // getting user token
    final sharedPrefs = await SharedPreferences.getInstance();
    final String userToken = sharedPrefs.getString(SHARED_PREF_KEY_USER_TOKEN) ?? "";

    final response = await http.get(
        Uri.parse('$favListApi?_limit=$apiDataLimit&page=$apiCurrentPage'),
        headers: {
          'Authorization': userToken
        }
    );
    final statusCode = response.statusCode;
    final responseBody = response.body;
    final responseBodyJson = jsonDecode(responseBody);


    if(statusCode == 200) {
      // hiding loading
      setState(() => contentLoading = false);

      List<SpotListModal> dataList = [];
      for(var singleItem in responseBodyJson['items']['favourites']) {
        SpotListModal dataItem = SpotListModal(
            vendorId: singleItem['vendorId'],
            vendorName: singleItem['vendorName'],
            vendorOpeningTimeFrom: singleItem['vendorOpeningTimeFrom'],
            vendorOpeningTimeTo: singleItem['vendorOpeningTimeTo'],
            vendorOffer: singleItem['vendorOffer'],
            vendorOfferType: singleItem['vendorOfferType'],
            vendorOfferCode: singleItem['vendorOfferCode']
        );
        dataList.add(dataItem);
      }

      setState(() {
        // no api error
        hasApiError = false;

        // increment the page
        apiCurrentPage++;

        // setting content
        contentData.addAll(dataList);

        // checking if there's more data to load
        if(dataList.length < apiDataLimit) {
          hasMoreContentToLoad = false;
        }
      });
    } else {
      // hiding loading
      setState(() {
        hasApiError = true;
        contentLoading = false;
        hasMoreContentToLoad = false;
      });

      throw Exception(FAILED_TO_LOAD_FROM_API);
    }

  }

  Future refreshContent() async {
    setState(() {
      apiCurrentPage = 1;
      contentLoading = false;
      contentData.clear();
    });

    fetchContentData();
  }

  void showToast(msg) => Fluttertoast.showToast(
    msg: msg,
    fontSize: 15
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(SWAPP_PAGE_TITLE),
          titleTextStyle: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
          centerTitle: true,
          leading: null,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 2,
          shadowColor: Colors.black26,
        ),

        body: RefreshIndicator(
          onRefresh: refreshContent,
          child: ListView.separated(
              controller: _listViewController,
              physics: const BouncingScrollPhysics(),
              itemCount: contentLoading ? 5 : contentData.length + 1,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                if(contentLoading) {
                  return const FavouritesContentLoading();
                } else {
                  if(index < contentData.length) {
                    final item = contentData[index];
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
                                      item.vendorName,
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
                                            item.vendorOpeningTimeFrom + ' - ' + item.vendorOpeningTimeTo,
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
                                            item.vendorOffer,
                                            style: descTextStyles,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 7),
                                    if (item.vendorOfferType == 'qr') ...[
                                      ElevatedButton.icon(
                                          onPressed: () => showModalBottomSheet(
                                            // enableDrag: false,
                                            // isDismissible: false,
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (context) => qrCodeBottomSheet(item.vendorOfferCode),
                                          ),
                                          icon: const Icon(
                                            UniconsLine.qrcode_scan,
                                            size: 17,
                                          ),
                                          label: const Text(SWAPP_PAGE_BTN_QR_CODE),
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
                                            builder: (context) => codeBottomSheet(item.vendorOfferCode),
                                          ),
                                          icon: const Icon(
                                            UniconsLine.ticket,
                                            size: 17,
                                          ),
                                          label: const Text(SWAPP_PAGE_BTN_CODE),
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
                                  onPressed: () {},
                                  icon: const Icon(
                                    UniconsSolid.bookmark,
                                    size: 30,
                                    color: appPrimaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        children: [
                          if(hasApiError) ...[ // if there's some api error
                            const Text('some error occured')
                          ] else ...[
                            if(hasMoreContentToLoad) ...[
                              const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ] else ...[
                              const Text('End of List')
                            ],
                          ],
                        ],
                      ),
                    );
                  }
                }
              }
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
                  SWAPP_PAGE_BOTTOM_SHEET_QR_CODE,
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
                  SWAPP_PAGE_BOTTOM_SHEET_CODE,
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
