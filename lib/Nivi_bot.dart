import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jose/jose.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class NiviBot extends StatefulWidget {
  @override
  _NiviBotState createState() => _NiviBotState();
}

class _NiviBotState extends State<NiviBot> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();
  late String _sessionId;

  @override
  void initState() {
    super.initState();
    _sessionId = Uuid().v4(); // Generate a unique session ID
  }

  Future<void> _handleSubmitted(String text) async {
    if (text.isEmpty) return;

    _textController.clear();

    ChatMessage message = ChatMessage(
      text: text,
      isUserMessage: true,
    );

    setState(() {
      _messages.insert(0, message);
    });

    final String responseText = await _sendMessageToDialogflow(text);

    if (responseText.isNotEmpty) {
      ChatMessage botMessage = ChatMessage(
        text: responseText,
        isUserMessage: false,
      );

      setState(() {
        _messages.insert(0, botMessage);
      });
    }
  }

  Future<String> _sendMessageToDialogflow(String query) async {
    final String privateKey = "";

    final String clientEmail =
        "nivi-96@gen-lang-client-0571624677.iam.gserviceaccount.com";
    final String projectId = "gen-lang-client-0571624677";

    final jwtClaimSet = JsonWebTokenClaims.fromJson({
      'iss': clientEmail,
      'sub': clientEmail,
      'aud': 'https://dialogflow.googleapis.com/',
      'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'exp': (DateTime.now().millisecondsSinceEpoch ~/ 1000) + 3600,
    });

    final jwk = JsonWebKey.fromPem(privateKey);
    final builder = JsonWebSignatureBuilder()
      ..jsonContent = jwtClaimSet.toJson()
      ..addRecipient(jwk, algorithm: 'RS256');

    final jws = builder.build();
    final token = jws.toCompactSerialization();

    try {
      final response = await http.post(
        Uri.parse(
            'https://dialogflow.googleapis.com/v2/projects/$projectId/agent/sessions/$_sessionId:detectIntent'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'queryInput': {
            'text': {
              'text': query,
              'languageCode': 'en',
            },
          },
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final String fulfillmentText =
            jsonResponse['queryResult']['fulfillmentText'];
        return fulfillmentText;
      } else {
        print(
            'Dialogflow API request failed with status: ${response.statusCode}');
        return 'Something went wrong. Please try again later.';
      }
    } catch (e) {
      print('Error occurred: $e');
      return 'Error occurred: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 75),
          child: Text('Ask Nivi'),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Images/NiViBG.png'), // Replace with your image
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  reverse: true,
                  itemBuilder: (_, int index) => _buildChatMessage(_messages[index]),
                  itemCount: _messages.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 8.0),
                        child: TextField(
                          controller: _textController,
                          maxLines: null, // Allows TextField to grow vertically
                          decoration: InputDecoration(
                            hintText: "Send a message",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 5,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
                          ),
                          onSubmitted: _handleSubmitted,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.blue[500],
                      ),
                      onPressed: () => _handleSubmitted(_textController.text),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChatMessage(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(
                message.isUserMessage
                    ? 'assets/Images/Paris.jpg'
                    : 'assets/Images/NiVi.png',
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  message.isUserMessage ? 'User' : 'Nivi',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    message.text,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUserMessage;

  ChatMessage({required this.text, required this.isUserMessage});
}