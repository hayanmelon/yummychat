import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _userEnterMessage = "";
  final user = FirebaseAuth.instance.currentUser; // currentrUser 정보를 변수에 저장

  void _sendMessage()async{
    FocusScope.of(context).unfocus();
    final userData = await FirebaseFirestore.instance.collection('user').doc(user!.uid).get();
    FirebaseFirestore.instance.collection('chat').add({
      'text' : _userEnterMessage,
      'time' : Timestamp.now(),
      'userID' : user!.uid,
      'userName' : userData.data()!['userName'], // userData.data()! 는 Map 형식을 리턴해준다,  userData.data()!['userName'] 값은 map의 키에 해당하는 밸류값
      'userImage' :  userData['picked_image'],
    });
    _controller.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: null,
              // 많은 내용을 텍스트필드에 입력할 때 줄을 바꾸어 주는 기능?
              // null 인 경우, 장문의 메세지를 보내도 줄을 계속 바꾸어 준다!

              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Send a message...',
              ),
              onChanged: (value) {
                setState(() {
                  _userEnterMessage = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _userEnterMessage.trim().isEmpty ? null : (){
              _sendMessage();

              // _sendMessage 와 _sendMessage() : 괄호유무의 차이?
              // 괄호가 있으면 이 메서드가 실행되어 값이 리턴된다는 의미
              // 괄호가 없으면 onPressed 메서드가 _sendMessage의 위치를 참조할 수 있다는 의미
            },
            icon: Icon(Icons.send),
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
