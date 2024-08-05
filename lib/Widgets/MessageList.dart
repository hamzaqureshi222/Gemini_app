import 'package:flutter/cupertino.dart';

import 'MessageRow.dart';

Widget messageListWidget(messageList) {
  return ListView.builder(
    itemBuilder: (context, index) {
      return buildSingleMessageRow(messageList[index]);
    },
    itemCount: messageList.length,
    reverse: true,
  );
}