import 'package:flutter/material.dart';

// google fonts
import 'package:google_fonts/google_fonts.dart';

// icons
import 'package:unicons/unicons.dart';

// colors
import 'package:app/theme/colors.dart';

// page consts
import 'package:app/screens/content/const/textConsts.dart';

class MessagesViewScreen extends StatefulWidget {
  const MessagesViewScreen({Key? key}) : super(key: key);

  @override
  State<MessagesViewScreen> createState() => _MessagesViewScreenState();
}

class _MessagesViewScreenState extends State<MessagesViewScreen> {
  // styles
  final userNameStyles = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w600
  );
  final userDesgStyles = GoogleFonts.montserrat(
    fontSize: 15,
  );
  final viewProfileBtnStyles = ElevatedButton.styleFrom(
    elevation: 0,
    splashFactory: NoSplash.splashFactory,
    minimumSize: const Size(115, 32),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(34)
    ),
    primary: appGreyDarkBGColor,
    onPrimary: Colors.black87,
    textStyle: GoogleFonts.montserrat(
      textStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  final chatMessageStyles = GoogleFonts.montserrat(
    fontSize: 15,
  );
  final optionTextStyles = GoogleFonts.montserrat(
    fontSize: 15,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // _listViewScrollDown();
  }

  final ScrollController _listViewController = ScrollController();
  void _listViewScrollDown() {
    final double end = _listViewController.position.maxScrollExtent;
    _listViewController.jumpTo(end);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chris MitchellChris'),
        titleTextStyle: GoogleFonts.montserrat(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Colors.black
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            UniconsLine.angle_left,
            size: 30,
          ),
          color: Colors.black,
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
              color: Colors.black,
            )
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Column(
            children: [
              // child | messages content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // child | chat
                    Expanded(
                      child: ListView(
                        controller: _listViewController,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        children: [
                          // child | user info
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // child | user Image
                              ClipRRect(
                                child: Image.network(
                                  'https://i.pinimg.com/736x/89/90/48/899048ab0cc455154006fdb9676964b3.jpg',
                                  height: 70,
                                  width: 70,
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
                              const SizedBox(height: 5),

                              // child | button
                              ElevatedButton(
                                  onPressed: () => {},
                                  child: const Text('VIEW PROFILE'),
                                  style: viewProfileBtnStyles
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // child | user message (getter)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // child | user message
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Card(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                      ),
                                      color: appPrimaryColor,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                                        child: Text(
                                          'Hey Chris, my name is Ted, Im heading to the Tell Tale now. Are you available for a cofee??',
                                          style: chatMessageStyles,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // const SizedBox(width: 6),

                              // child | user image
                              // ClipRRect(
                              //   child: Image.network(
                              //     'https://i.pinimg.com/736x/89/90/48/899048ab0cc455154006fdb9676964b3.jpg',
                              //     height: 28,
                              //     width: 28,
                              //     fit: BoxFit.cover,
                              //   ),
                              //   borderRadius: BorderRadius.circular(65.0),
                              // ),
                            ],
                          ),
                          const SizedBox(height: 7),

                          // child | user message (sender)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // child | user no image
                              const SizedBox(width: 28),
                              const SizedBox(width: 6),

                              // child | user message
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Card(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          // topLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                          // bottomLeft: Radius.circular(20),
                                        ),
                                      ),
                                      color: appGreyDarkBGColor,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                                        child: Text(
                                          'Hey Chris! whats up man',
                                          style: chatMessageStyles,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 1),
                          // child | user message (sender)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // child | user no image
                              const SizedBox(width: 28),
                              const SizedBox(width: 6),

                              // child | user message
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Card(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          // topLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                          // bottomLeft: Radius.circular(20),
                                        ),
                                      ),
                                      color: appGreyDarkBGColor,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                                        child: Text(
                                          'Hey Chris',
                                          style: chatMessageStyles,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 1),
                          // child | user message (sender)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // child | user image
                              ClipRRect(
                                child: Image.network(
                                  'https://i.pinimg.com/736x/89/90/48/899048ab0cc455154006fdb9676964b3.jpg',
                                  height: 28,
                                  width: 28,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(65.0),
                              ),
                              const SizedBox(width: 6),

                              // child | user message
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Card(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                      ),
                                      color: appGreyDarkBGColor,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                                        child: Text(
                                          'Hey Chris',
                                          style: chatMessageStyles,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 7),

                          // child | user message (getter)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // child | user message
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Card(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          // bottomRight: Radius.circular(20),
                                        ),
                                      ),
                                      color: appPrimaryColor,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                                        child: Text(
                                          'good work there! just keep up the good things!! best of luck',
                                          style: chatMessageStyles,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // const SizedBox(width: 6),

                              // child | user no image
                              // const SizedBox(width: 28),
                            ],
                          ),
                          const SizedBox(height: 1),
                          // child | user message (getter)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // child | user message
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Card(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          // bottomRight: Radius.circular(20),
                                        ),
                                      ),
                                      color: appPrimaryColor,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                                        child: Text(
                                          'nice to meet you',
                                          style: chatMessageStyles,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // const SizedBox(width: 6),

                              // child | user no image
                              // const SizedBox(width: 28),
                            ],
                          ),
                          const SizedBox(height: 1),
                          // child | user message (getter)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // child | user message
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Card(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                      ),
                                      color: appPrimaryColor,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                                        child: Text(
                                          'Hey Chris, my name is Ted,',
                                          style: chatMessageStyles,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // const SizedBox(width: 6),

                              // child | user image
                              // ClipRRect(
                              //   child: Image.network(
                              //     'https://i.pinimg.com/736x/89/90/48/899048ab0cc455154006fdb9676964b3.jpg',
                              //     height: 28,
                              //     width: 28,
                              //     fit: BoxFit.cover,
                              //   ),
                              //   borderRadius: BorderRadius.circular(65.0),
                              // ),
                            ],
                          ),
                          const SizedBox(height: 7),

                          // child | user message (sender)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // child | user no image
                              const SizedBox(width: 28),
                              const SizedBox(width: 6),

                              // child | user message
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Card(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          // topLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                          // bottomLeft: Radius.circular(20),
                                        ),
                                      ),
                                      color: appGreyDarkBGColor,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                                        child: Text(
                                          'Hey Chris! whats up man',
                                          style: chatMessageStyles,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 1),
                          // child | user message (sender)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // child | user no image
                              const SizedBox(width: 28),
                              const SizedBox(width: 6),

                              // child | user message
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Card(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          // topLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                          // bottomLeft: Radius.circular(20),
                                        ),
                                      ),
                                      color: appGreyDarkBGColor,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                                        child: Text(
                                          'Hey Chris',
                                          style: chatMessageStyles,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 1),
                          // child | user message (sender)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // child | user image
                              ClipRRect(
                                child: Image.network(
                                  'https://i.pinimg.com/736x/89/90/48/899048ab0cc455154006fdb9676964b3.jpg',
                                  height: 28,
                                  width: 28,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(65.0),
                              ),
                              const SizedBox(width: 6),

                              // child | user message
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Card(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                      ),
                                      color: appGreyDarkBGColor,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                                        child: Text(
                                          'Hey Chris',
                                          style: chatMessageStyles,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 7),

                          // child | user message (getter)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // child | user message
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Card(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          // bottomRight: Radius.circular(20),
                                        ),
                                      ),
                                      color: appPrimaryColor,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                                        child: Text(
                                          'good work there! just keep up the good things!! best of luck',
                                          style: chatMessageStyles,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // const SizedBox(width: 6),

                              // child | user no image
                              // const SizedBox(width: 28),
                            ],
                          ),
                          const SizedBox(height: 1),
                          // child | user message (getter)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // child | user message
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Card(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          // bottomRight: Radius.circular(20),
                                        ),
                                      ),
                                      color: appPrimaryColor,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                                        child: Text(
                                          'nice to meet you',
                                          style: chatMessageStyles,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // const SizedBox(width: 6),

                              // child | user no image
                              // const SizedBox(width: 28),
                            ],
                          ),
                          const SizedBox(height: 1),
                          // child | user message (getter)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // child | user message
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Card(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                      ),
                                      color: appPrimaryColor,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                                        child: Text(
                                          'Hey Chris, my name is Ted,',
                                          style: chatMessageStyles,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // const SizedBox(width: 6),

                              // child | user image
                              // ClipRRect(
                              //   child: Image.network(
                              //     'https://i.pinimg.com/736x/89/90/48/899048ab0cc455154006fdb9676964b3.jpg',
                              //     height: 28,
                              //     width: 28,
                              //     fit: BoxFit.cover,
                              //   ),
                              //   borderRadius: BorderRadius.circular(65.0),
                              // ),
                            ],
                          ),
                          const SizedBox(height: 7),
                        ],
                      )
                    ),
                  ],
                ),
              ),

              // child | messages content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Row(
                  children: [
                    // child | field
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(color: Colors.red, width: 2.0)
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // child | select image
                    SizedBox(
                      height: 42,
                      width: 42,
                      child: IconButton(
                        onPressed: () {},
                        splashRadius: 24,
                        iconSize: 25,
                        icon: const Icon(
                            UniconsLine.image
                        ),
                        highlightColor: appGreyHighlightBGColor,
                      ),
                    ),

                    // child | record audio
                    SizedBox(
                      height: 42,
                      width: 42,
                      child: IconButton(
                        onPressed: () {},
                        splashRadius: 24,
                        iconSize: 24,
                        icon: const Icon(
                            UniconsLine.microphone
                        ),
                        highlightColor: appGreyHighlightBGColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
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
                  UniconsLine.user,
                  size: 21,
                ),
                const SizedBox(width: 13),

                Text(
                  VIEW_PROFILE,
                  style: optionTextStyles,
                )
              ],
            ),
          ),
        ),

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
                  REPORT_USER,
                  style: optionTextStyles,
                )
              ],
            ),
          ),
        ),

        InkWell( // option item
          splashColor: Colors.transparent,
          highlightColor: appGreyHighlightBGColor,
          onTap: () => {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
            child: Row(
              children: [
                const Icon(
                  UniconsLine.ban,
                  size: 21,
                ),
                const SizedBox(width: 13),

                Text(
                  BLOCK_USER,
                  style: optionTextStyles,
                )
              ],
            ),
          ),
        ),

        InkWell( // option item
          splashColor: Colors.transparent,
          highlightColor: appGreyHighlightBGColor,
          onTap: () => {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
            child: Row(
              children: [
                const Icon(
                  UniconsLine.times_circle,
                  size: 21,
                ),
                const SizedBox(width: 13),

                Text(
                  CLEAR_CHAT,
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
