import 'dart:async';
import 'dart:convert';

import 'package:app/screens/content/favouritesContent/content_loading.dart';
import 'package:flutter/material.dart';

// common styles
import 'package:app/theme/styles/appStyles.dart';

// common consts
import 'package:app/theme/commonConst/textConsts.dart';

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
// global consts
import 'package:shared_preferences/shared_preferences.dart';

// icons
import 'package:unicons/unicons.dart';

// http
import 'package:http/http.dart' as http;

// api cachec manager
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';

// api end points
import 'package:app/theme/apis/api_urls.dart';

// modal
import 'package:app/screens/content/favouritesContent/modals/fav_list_modal.dart';
import 'package:app/screens/content/favouritesContent/modals/temp_modal.dart';

// shared preferences
import 'package:shared_preferences/shared_preferences.dart';

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

class FavouritesContent extends StatefulWidget {
  const FavouritesContent({Key? key}) : super(key: key);

  @override
  State<FavouritesContent> createState() => _FavouritesContentState();
}

class _FavouritesContentState extends State<FavouritesContent> {
  final _listViewController = ScrollController();
  final StreamController<List<TempModal>> _streamController = StreamController<List<TempModal>>.broadcast();
  bool contentLoading = false;
  bool hasMoreData = false;

  int apiDataLimit = 10;
  int apiCurrentPage = 1;
  String apiErrorMsg = '';

  late Stream<List<TempModal>> favouritesData;

  @override
  void initState() {
    super.initState();

    print('app state - initState');

    // getting network data
    getNetworkData();

    // when page is at the end
    _listViewController.addListener(() {
      if(_listViewController.position.maxScrollExtent == _listViewController.offset) {
        // getting network data
        getNetworkData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _listViewController.dispose();
    _streamController.close();
  }

  // getting data from network
  Future<void> getNetworkData() async {
    print('app state - called');

    print('app state - apiCurrentPage $apiCurrentPage');

    // -- getting data from the api if cache doesn't exist
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/comments?_limit=$apiDataLimit&page=$apiCurrentPage'),
    );
    final statusCode = response.statusCode;
    final responseBody = response.body;
    final responseBodyJson = jsonDecode(responseBody);

    print('app state - responseBodyJson');

    // -- if data found
    if(statusCode == 200) {
      List<TempModal> dataList = [];
      for(var singleItem in responseBodyJson) {
        TempModal dataItem = TempModal(
          postId: singleItem['postId'],
          id: singleItem['id'],
          name: singleItem['name'],
          email: singleItem['email'],
          body: singleItem['body']
        );
        dataList.add(dataItem);
      }

      setState(() => apiCurrentPage++);

      if(apiCurrentPage > 2) {
        showToast("List Updated");
      }

      _streamController.sink.add(dataList);
    } else {
      throw Exception(FAILED_TO_LOAD_FROM_API);
    }
  }

  // functions
  Future<void> onRefresh() async {
    // -- resetting current page
    setState(() => apiCurrentPage = 1);

    // emptying data
    final List<TempModal> emptyData = [];
    _streamController.sink.add(emptyData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(FAV_PAGE_TITLE),
        titleTextStyle: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        centerTitle: true,
        leading: null,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black26,
      ),

      body: StreamBuilder<List<TempModal>>(
        stream: _streamController.stream,
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:

            case ConnectionState.done:

            default:
              if(snapshot.hasData) {
                final data = snapshot.data!;
                return RefreshIndicator(
                  onRefresh: onRefresh,
                  child: ListView.separated(
                    controller: _listViewController,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: data.length + 1,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      if(index < data.length) {
                        final item = data[index];
                        print('item here $item');
                        return Column(
                          children: [
                            ListTile(
                              title: Text("${item.id} ${item.name}"),
                              subtitle: Text(item.body),
                            ),
                            const SizedBox(height: 20),
                          ],
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Column(
                            children: const [
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    },
                  ),
                );
              } else if(snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Text(
                    UNABLE_TO_LOAD_FROM_INTERNET,
                    style: globalStylesInfoMessage,
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                // return Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                //   child: Text(
                //     NO_DATA_FOUND,
                //     style: globalStylesInfoMessage,
                //   ),
                // );
                return ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, i) {
                      return const FavouritesContentLoading();
                    }
                );
              }
          }
        },
      ),
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
