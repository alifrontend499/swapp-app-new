import 'package:flutter/material.dart';

// common consts
import 'package:app/theme/commonConst/textConsts.dart';

// routes
import 'package:app/theme/routing/routing_constants.dart';

// google fonts
import 'package:google_fonts/google_fonts.dart';

// page consts
import 'package:app/screens/content/const/textConsts.dart';

// modal classes
import 'package:app/screens/content/messagesContent/modal/messages_data.dart';

// colors
import 'package:app/theme/colors.dart';

// toast
import 'package:fluttertoast/fluttertoast.dart';

// http
import 'package:http/http.dart' as http;

// api cachec manager
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';

class MessagesContent extends StatefulWidget {
  const MessagesContent({Key? key}) : super(key: key);

  @override
  State<MessagesContent> createState() => _MessagesContentState();
}

class _MessagesContentState extends State<MessagesContent> {
  // styles
  final userHeadingStyles = GoogleFonts.montserrat(
      fontSize: 16,
      fontWeight: FontWeight.w600
  );
  final messageTimeStyles = GoogleFonts.montserrat(
      fontSize: 14,
      color: Colors.black45,
      fontWeight: FontWeight.w500
  );
  final userShortMessageStyles = GoogleFonts.montserrat(
    fontSize: 15,
  );

  @override
  void initState() {
    getMessagesData();
  }

  Future getMessagesData() async {
    var isCacheDataExists = await APICacheManager().isAPICacheKeyExist(GET_SPOTS_KEY);

    if(!isCacheDataExists) {
      // -- getting data from the api if cache doesn't exist
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      // -- adding data to cache
      APICacheDBModel cacheDBModal = APICacheDBModel(
          key: GET_SPOTS_KEY,
          syncData: response.body
      );
      await APICacheManager().addCacheData(cacheDBModal);

    } else {
      // -- getting data from cached
      var cachedData = await APICacheManager().getCacheData(GET_SPOTS_KEY);
    }
  }

  // data
  List<MessagesDataItem> messages = [
    MessagesDataItem(
      imgUrl: 'https://i.pinimg.com/originals/8b/16/7a/8b167af653c2399dd93b952a48740620.jpg',
      userName: 'Chris Mitchell',
      time: '10:24',
      smallMessage: 'I’ll be there in half an hour.'
    ),
    MessagesDataItem(
      imgUrl: 'https://i.pinimg.com/736x/89/90/48/899048ab0cc455154006fdb9676964b3.jpg',
      userName: 'Nick Jonas',
      time: '10:24',
      smallMessage: 'here there you there!! I’ll be there in half an hour.'
    ),
    MessagesDataItem(
      imgUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbBMwRJfFeRL23d-4MB-yq_6NyJFUw7zprYQ&usqp=CAU',
      userName: 'Charles Raze',
      time: '10:24',
      smallMessage: 'I’ll be there in half an hour.'
    ),
    MessagesDataItem(
      imgUrl: 'https://i.pinimg.com/originals/8b/16/7a/8b167af653c2399dd93b952a48740620.jpg',
      userName: 'Pym View',
      time: '10:24',
      smallMessage: 'here there you there!! I’ll be there in half an hour.'
    ),
    MessagesDataItem(
      imgUrl: 'https://i.pinimg.com/originals/8b/16/7a/8b167af653c2399dd93b952a48740620.jpg',
      userName: 'Chris Mitchell',
      time: '10:24',
      smallMessage: 'I’ll be there in half an hour. here there you there!!'
    ),
    MessagesDataItem(
      imgUrl: 'https://i.pinimg.com/736x/89/90/48/899048ab0cc455154006fdb9676964b3.jpg',
      userName: 'Nick Jonas',
      time: '10:24',
      smallMessage: 'I’ll be there in half an hour. here there you there!!'
    ),
    MessagesDataItem(
      imgUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbBMwRJfFeRL23d-4MB-yq_6NyJFUw7zprYQ&usqp=CAU',
      userName: 'Charles Raze',
      time: '10:24',
      smallMessage: 'here there you there!! I’ll be there in half an hour.'
    ),
    MessagesDataItem(
      imgUrl: 'https://i.pinimg.com/originals/8b/16/7a/8b167af653c2399dd93b952a48740620.jpg',
      userName: 'Pym View',
      time: '10:24',
      smallMessage: 'I’ll be there in half an hour.'
    ),
    MessagesDataItem(
      imgUrl: 'https://i.pinimg.com/originals/8b/16/7a/8b167af653c2399dd93b952a48740620.jpg',
      userName: 'Chris Mitchell',
      time: '10:24',
      smallMessage: 'here there you there!! I’ll be there in half an hour.'
    ),
    MessagesDataItem(
      imgUrl: 'https://i.pinimg.com/736x/89/90/48/899048ab0cc455154006fdb9676964b3.jpg',
      userName: 'Nick Jonas',
      time: '10:24',
      smallMessage: 'I’ll be there in half an hour. here there you there!!'
    ),
    MessagesDataItem(
      imgUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbBMwRJfFeRL23d-4MB-yq_6NyJFUw7zprYQ&usqp=CAU',
      userName: 'Charles Raze',
      time: '10:24',
      smallMessage: 'I’ll be there in half an hour.'
    ),
    MessagesDataItem(
      imgUrl: 'https://i.pinimg.com/originals/8b/16/7a/8b167af653c2399dd93b952a48740620.jpg',
      userName: 'Pym View',
      time: '10:24',
      smallMessage: 'I’ll be there in half an hour.'
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
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(MSGS_PAGE_TITLE),
        titleTextStyle: GoogleFonts.montserrat(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Colors.black
        ),
        centerTitle: true,
        leading: null,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black26,
      ),

      body: RefreshIndicator(
        onRefresh: () => onRefresh(),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 5),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final item = messages[index];
            return InkWell( // item start
              onTap: () => Navigator.pushNamed(context, messagesViewScreenRoute),
              splashColor: Colors.transparent,
              highlightColor: appGreyHighlightBGColor,
              child: Container(
                padding: const EdgeInsets.only(top: 12, left: 15, right: 15),
                child: Container(
                    padding: const EdgeInsets.only(bottom: 12),
                    decoration: const BoxDecoration(
                      // border: Border(
                      //   bottom: BorderSide(
                      //       width: 1,
                      //       color: Colors.black38
                      //   ),
                      // ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          child: Image.network(
                            item.imgUrl,
                            height: 45,
                            width: 45,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(65.0),
                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.userName,
                                        style: userHeadingStyles,
                                      ),
                                    ),

                                    Text(
                                      item.time,
                                      style: messageTimeStyles,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),

                                Text(
                                  item.smallMessage,
                                  style: userShortMessageStyles,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ),
            );
          },
        ),
      )
    );
  }
}
