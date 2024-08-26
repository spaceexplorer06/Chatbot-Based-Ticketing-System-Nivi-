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
    _sessionId = Uuid().v4();  // Generate a unique session ID
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
    final String privateKey = """-----BEGIN PRIVATE KEY-----
MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCwmSbSX+lRWn29
I2e3sctm+aceG0aWfUApME1q6+/BYqGynjZuj1FaLzxuZFSt2NGbvaZR+ebbB8ff
D3ZR416NDkRWasR+Wc+kvf7yVeUKjjFqQDXaJDrsdcZRUNMaIaVV0SPHPnuHLZGn
FpykKw93Ti6YKe155yX591lAFcCKRHHGezI9HtIAht7Z7WvGVf9WeduttwjsgFKF
swJn1IMXP0GNteHszC+SeAjg681iacau7LbAHzReXhkJX2RUysDyrv8SUEwDfR6l
VBXcknD1quidZhAo48mlFkDG9TLzUaXB75A4Dv3lhrD3pFhCLIemHw6Y9rAIRMUS
VTT1A+P3AgMBAAECggEABTCbCXe0HaXxKAvQUn+xIJeZp7LZgjawGgXHYKsKYr6J
TfyEUP95PpNAzWW5b1p93nvWVXZoqGs0HoQP0BxEfRS8QWXl3Gi7R3Yl9e08S/Ed
1qeIbZ6+9JAJgf5EFfKDL2B0ErjtXG2kaCqr888oJzNu/x3MUtbOMOhqAQ4imG2Z
58/nBBUHh1JbVFjX0n+y1N1xmKOInzlKv1DX4AegJVMy63ZYAKzrhSHXdsCCpHjL
l98OpHfVCCCL9IxvA0Sd3FY6MLNAyZZhMt5anfkSa5+TrYR7sssRqx9YyULLZWuy
9y6OaDP0Im+URAq1DjKE51PBqw2oYztPuKlIzXD+QQKBgQDyPKTKinqNapDAt39G
vaqRxpZl1SRjeZKIHfn85EMqJwTqIef6fxgNmNOBCOMhEfVnpI3VQbM9Fogmm1/n
5bKjop/RoEg3pWFRHgAQ3VNbau0iNceF15m9S3pvcRpR4v6PGupZvTYPoXYvSVe+
8dsHeoCpi9mAIZJ06GUlfbiXEQKBgQC6ocnM+72S9fGDDwBU+Mh+PB0V3kVi46ed
IdzAR9IwI58PjroJlfzyHiWlze9/ygQuCcCj4gwQzmedN3Mu2XpS4oXvpfGNNhP9
NpLTPgZop/vOxBvabinSG0Siu7nUAlsDIRpEu+3jDIr2svR2GmkDg4XONvCZ2fn2
UJ24+QyahwKBgQCYfHJkCY4iDW430ostVeHUyEUOr4CrmfES/IPMnUhmdY+Tb2qf
dngGvyiNNrH7tFleN+kM0MHq948XdoGF8kNk3M9sX1B2rwW20YLLGvgJOSMzgNUr
vM/LqILXOkSOPa1vGkth2Ej6x/IkzC+PRKJTb9skX6O4E+ok69IYKq8TcQKBgGD7
gepLRw//TilUuk9tmIJAqryabGQe+RLmbdhdehQZ7qYe/P3OO0t17wpiIXq+d72U
w85lwO9a0u0Xy3sk+DPqEr+d9A/1ch27JkEvkhUAdhHURsUTShgso1YNR1usfa76
nLPrFItQEUZxaCeXQcrZpcarNgw9AW/GJK/ie3IxAoGBAJXJhwuJahEKjGqh/vwk
JSBd+gXV9V1SM7mwFWzLCcKxoqFIHN7DmaJR1xc2nen0n5U7H5HQkmCiR/ISzXxF
IV366vdCXK+YOyM+lkBI4WWsUa5IDznnVRBzDoiN4bmvU6w+PJqwOQr44yzkXXVS
WEYVoCR2eAlpbl0vblLKOiUh
-----END PRIVATE KEY-----""";

    final String clientEmail = "nivi-96@gen-lang-client-0571624677.iam.gserviceaccount.com";
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
        Uri.parse('https://dialogflow.googleapis.com/v2/projects/$projectId/agent/sessions/$_sessionId:detectIntent'),
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
        final String fulfillmentText = jsonResponse['queryResult']['fulfillmentText'];
        return fulfillmentText;
      } else {
        print('Dialogflow API request failed with status: ${response.statusCode}');
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
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: Text('NiviBot'),
        )
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _buildChatMessage(_messages[index]),
              itemCount: _messages.length,
            ),
          ),
          Divider(height: 1.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration.collapsed(hintText: "Send a message", border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: const BorderSide(color : Colors.black,))),
                    onSubmitted: _handleSubmitted,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text),
                ),
              ],
            ),
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
            child: Text(message.isUserMessage ? 'U' : 'N'),
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
                  overflow: TextOverflow.visible, // Prevents text overflow
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

