import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/components/chat_bubble.dart';
import 'package:flutter_chat_app/components/custom_text_field.dart';
import 'package:flutter_chat_app/services/chat/chat_service.dart';

class ChatRoomPage extends StatefulWidget {
  final String receiverUserId;
  final String receiverUserEmail;
  const ChatRoomPage({
    super.key,
    required this.receiverUserId,
    required this.receiverUserEmail,
  });
  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          _messageController.text, widget.receiverUserId);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverUserEmail)),
      body: Column(children: [
        Expanded(
          child: _buildMessageList(),
        ),
        _buildMessageInput(),
        const SizedBox(height: 25),
      ]),
    );
  }

  // Message List
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.receiverUserId, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  // Message Item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // Messages Alignment
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment:
                (data['senderId'] == _firebaseAuth.currentUser!.uid)
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
            mainAxisAlignment:
                (data['senderId'] == _firebaseAuth.currentUser!.uid)
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
            children: [
              Text(data['senderEmail']),
              const SizedBox(height: 8),
              ChatBubble(message: data['message']),
            ]),
      ),
    );
  }

  // Message Input
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(children: [
        Expanded(
          child: CustomTextField(
            controller: _messageController,
            hintText: 'Type a message',
            obscureText: false,
          ),
        ),
        // Send Button
        IconButton(
          onPressed: _sendMessage,
          icon: const Icon(Icons.arrow_upward, size: 35),
        ),
      ]),
    );
  }
}
