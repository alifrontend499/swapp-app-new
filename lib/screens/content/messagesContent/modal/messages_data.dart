import 'package:flutter/material.dart';

class MessagesDataItem {
  String imgUrl;
  String userName;
  String time;
  String smallMessage;

  MessagesDataItem({
    required this.imgUrl,
    required this.userName,
    required this.time,
    required this.smallMessage,
  });
}