import 'package:flutter/material.dart';
import 'package:wechat_demo/const.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('微信'),
        backgroundColor: WeChatThemeColor,
        actions: [
          GestureDetector(
            child: Container(
              color: Colors.red,
              margin: EdgeInsets.only(right: 10),
              child: Image(
                image: AssetImage('images/wc_circle_add.png'),
                width: 25,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Text('聊天'),
      ),
    );
  }
}
