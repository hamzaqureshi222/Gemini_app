import 'package:flutter/material.dart';
import '../message_model.dart';

Widget buildSingleMessageRow(MessageModel messageModel) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    alignment: messageModel.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: messageModel.sentByMe ? Colors.blue : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        messageModel.message,
        style: TextStyle(
          color: messageModel.sentByMe ? Colors.white : Colors.black87,
        ),
      ),
    ),
  );
}