import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_gemini/google_gemini.dart';
import 'Widgets/MessageList.dart';
import 'message_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  List<MessageModel> messageList = [];
  final gemini = GoogleGemini(apiKey: "AIzaSyBIMfAQ3pt5KiHIdw-decvkgiEb16r6pFE");
  bool isLoading = false;

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Gemini", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                if (messageList.isEmpty)
                  const Center(
                    child: Text(
                      'Welcome To Gemini',
                      style: TextStyle(fontSize: 28,color: Colors.black38),
                    ),
                  )
                else
                  messageListWidget(messageList),
                if (isLoading)
                  const Center(
                    child: CircularProgressIndicator(color: Colors.blue,),
                  ),
              ],
            ),
          ),
          sendWidget()
        ],
      ),
    );
  }

  Widget sendWidget() {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.080,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: const InputDecoration(
                  hintText: "Type Something", border: InputBorder.none),
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.2),
          FloatingActionButton(
            onPressed: () {
              String question = messageController.text.toString();
              if (question.isEmpty) return;
              messageController.clear();
              addMessageToMessagesList(question, true);
              sendMessageToAPI(question);
            },
            elevation: 0,
            backgroundColor: Colors.blue,
            shape: const CircleBorder(),
            child: const Icon(Icons.send, color: Colors.white),
          )
        ],
      ),
    );
  }

  void addMessageToMessagesList(String message, bool sentByMe) {
    setState(() {
      messageList.insert(0, MessageModel(message: message, sentByMe: sentByMe));
    });
  }

  void sendMessageToAPI(String question) async {
    setState(() {
      isLoading = true; // Start loading
    });

    try {
      final response = await gemini.generateFromText(question);
      final responseText = response.text.toString();
      addMessageToMessagesList(responseText, false);
    } catch (e) {
      if (kDebugMode) {
        print('Exception: $e');
      }
    } finally {
      setState(() {
        isLoading = false; // End loading
      });
    }
  }
}
