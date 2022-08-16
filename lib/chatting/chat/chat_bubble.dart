import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_8.dart';

class ChatBubbles extends StatelessWidget {
  const ChatBubbles(this.message, this.isMe, this.userName, this.userImage, {Key? key}) : super(key: key);
  // 아래 변수들은 위에 생성자에 다 전달이 되어 있음
  final String message;
  final String userName;
  final bool isMe;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if(isMe)
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 45, 0),
                child: ChatBubble(
                  clipper: ChatBubbleClipper8(type: BubbleType.sendBubble),
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(top: 20),
                  backGroundColor: Colors.blue,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    child: Column(
                      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children : [
                        if(userName!=null)
                          Text(
                          userName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        Text(
                        message,
                        style: TextStyle(color: Colors.white),
                        ),
                      ]
                    ),
                  ),
                ),
              ),
            if(!isMe)
              Padding(
                padding: EdgeInsets.fromLTRB(45, 15, 0, 0),
                child: ChatBubble(
                  clipper: ChatBubbleClipper8(type: BubbleType.receiverBubble),
                  backGroundColor: Color(0xffE7E7ED),
                  margin: EdgeInsets.only(top: 20),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    child: Column(
                        crossAxisAlignment: isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          if (userName != null)
                            Text(
                              userName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                          Text(
                            message,
                            style: TextStyle(color: Colors.black),
                          ),
                        ]
                    ),
                  ),
                ),
              )
          ],
        ),
        Positioned( // CircleAvatar 위치를 세세하게 조절해주기 위한 위젯
          top: 0,
          right : isMe? 5 : null,
          left: isMe? null : 5,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage), // url 주소를 던저주면 됨
          ),
        ),
      ],
    );
  }
}
