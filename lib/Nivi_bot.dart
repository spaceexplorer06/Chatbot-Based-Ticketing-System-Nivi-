import 'dart:io';
import 'dart:typed_data';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';

class NiviBot extends StatefulWidget {
  const NiviBot({super.key});

  @override
  State<NiviBot> createState() => _NiviBotState();
}

class _NiviBotState extends State<NiviBot> {
  final Gemini gemini = Gemini.instance;

  List<ChatMessage> messages = [];

  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  
  // Update the AI's name here
  ChatUser niviUser = ChatUser(
    id: "1",
    firstName: "Nivi",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Ask Nivi",  // The app title reflects the AI's name
        ),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return DashChat(
      inputOptions: InputOptions(trailing: [
        IconButton(
          onPressed: _sendMediaMessage,
          icon: const Icon(
            Icons.image,
          ),
        )
      ]),
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
    );
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      String question = chatMessage.text;
      List<Uint8List>? images;
      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [
          File(chatMessage.medias!.first.url).readAsBytesSync(),
        ];
      }
      gemini
          .streamGenerateContent(
        question,
        images: images,
      )
          .listen((event) {
        String response = event.content?.parts?.fold(
                "", (previous, current) => "$previous ${current.text}") ??
            "";

        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == niviUser) {
          lastMessage = messages.removeAt(0);
          lastMessage.text += response;
          setState(
            () {
              messages = [lastMessage!, ...messages];
            },
          );
        } else {
          ChatMessage message = ChatMessage(
            user: niviUser,
            createdAt: DateTime.now(),
            text: response,
          );
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void _sendMediaMessage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
        user: currentUser,
        createdAt: DateTime.now(),
        text: "Describe this picture?",
        medias: [
          ChatMedia(
            url: file.path,
            fileName: "",
            type: MediaType.image,
          )
        ],
      );
      _sendMessage(chatMessage);
    }
  }
}
