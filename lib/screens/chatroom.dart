import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatelessWidget {
   ChatRoom({super.key, required this.userCredentialMap, required this.chatRoomId});
  final Map<String, dynamic> userCredentialMap;
  final String chatRoomId;

  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "semdby": auth.currentUser?.displayName,
        "message": _message.text,
        "text": FieldValue.serverTimestamp(),
      };
      _message.clear();
      await firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .add(messages);
    } else {
      print("Enter Some Text");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text(userCredentialMap['Name'])),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 1.25,
              width: size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection('chatroom')
                    .doc(chatRoomId)
                    .collection('chats')
                    .snapshots(),
                builder:
                    (
                      BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot
                    ){
                      if(snapshot.hasData && snapshot.data != null){
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, Index){
                          Map<String, dynamic> map = snapshot.data!.docs[Index].data() as Map<String, dynamic>;
                          return messages(size, map);
                        
                        });
                      }
                    else {
                      return Container();
                      }  },
              ),
            ),
            Container(
              color: Colors.white,
              height: size.height / 10,
              width: size.width,
              alignment: Alignment.center,
              child: Container(
                color: Colors.white,
                height: size.height / 12,
                width: size.width / 1.1 ,
                child: Row(
                  children: [
                    SizedBox(
                     
                      height: size.height / 8,
                      width: size.width /3,
                      child: TextField(
                        controller: _message,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                    
                      ),
                    ),IconButton(
                          icon: Icon(Icons.send),
                          onPressed: onSendMessage,
                        ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget messages(Size size, Map<String, dynamic> map) {
  return Container(
    width: size.width,
    alignment: map['sendby'] == FirebaseAuth.instance.currentUser?.displayName
        ? Alignment.centerRight
        : Alignment.centerLeft,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.blue,
      ),
      child: Text(
        map['message'],
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    ),
  );
}
