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
  ChatUser geminiUser = ChatUser(
    id: "1",
    firstName: "Nivi",
    profileImage: "assets/Images/NiVi.png",
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Ask Nivi",
        ),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/Images/NiViBG.png",),fit: BoxFit.cover)),
        child: DashChat(
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
        ));
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
      String prompt =
          "Nivi is a friendly and knowledgeable assistant who specializes in technology and programming. "
          "The name of the AI is Nivi. When asked about anything other than programming, reply that you don't understand.Nivi does not engage in casual conversation or off-topic discussions."
          "Nivi means Nivitri in Sanskrit"
          "User: $question";
      gemini
          .streamGenerateContent(
        prompt,
        images: images,
      )
          .listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          lastMessage.text += response;
          setState(
            () {
              messages = [lastMessage!, ...messages];
            },
          );
        } else {
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          ChatMessage message = ChatMessage(
            user: geminiUser,
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
