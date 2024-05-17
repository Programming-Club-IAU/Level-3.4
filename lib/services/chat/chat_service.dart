import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/model/messages.dart';

class ChatService extends ChangeNotifier {
  // instance of FirebaseAuth
  final FirebaseAuth _firebaseauth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Send message
  Future<void> sendMessage(String message, String receiverUserId) async {
    final String currentUserId = _firebaseauth.currentUser!.uid;
    final String currentUserEmail = _firebaseauth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message messageData = Message(
      senderId: currentUserId,
      message: message,
      senderEmail: currentUserEmail,
      receiverId: receiverUserId,
      timestamp: timestamp.toString(),
    );

    List<String> users = [currentUserId, receiverUserId];
    users.sort();
    String chatRoomId = users.join("_");

    await _firestore
        .collection('chatrooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(messageData.toMap());
  }

  // Get messages
  Stream<QuerySnapshot> getMessages(
      String receiverUserId, String currentUserId) {
    List<String> users = [currentUserId, receiverUserId];
    users.sort();
    String chatRoomId = users.join("_");

    return _firestore
        .collection('chatrooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
