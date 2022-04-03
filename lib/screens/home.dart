import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firebaseFirestore = FirebaseFirestore.instance;
late User singedInUer;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth = FirebaseAuth.instance;
  String? messageText;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    getCurrentUser();
    // TODO: implement initState
    super.initState();
  }

  getMessageStream() async {
    await for (var snapshot
        in _firebaseFirestore.collection("messages").snapshots()) {
      for (var message in snapshot.docs) {
        print("***************");
        print(message.data());
      }
    }
  }

  getMessages() async {
    final get_messages = await _firebaseFirestore.collection("messages").get();
    for (var message in get_messages.docs) {
      print("****************");
      print(message.data());
    }
  }

  getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        singedInUer = user;
        print(singedInUer.email);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut().then((value) =>
                    Navigator.pushReplacementNamed(context, '/login'));
              },
              icon: Icon(
                Icons.close,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {
                //   getMessages();
                getMessageStream();
              },
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              )),
          SizedBox(
            width: 8,
          )
        ],
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                height: 60, width: 60, child: Image.asset("images/me.jpg")),
            SizedBox(
              width: 6,
            ),
            RichText(
              text: TextSpan(
                text: 'Mess',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: 'a',
                      style: TextStyle(
                        color: Color.fromRGBO(252, 165, 3, 0.8),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )),
                  TextSpan(
                      text: 'geMe',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        // child: CustomScrollView(
        //   slivers: [
        //     SliverFillRemaining(
        //       hasScrollBody: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageStreamBuilder(),
            Container(
              margin: EdgeInsets.all(6),
              // decoration: const BoxDecoration(
              //   // border: Border(
              //   //   top: BorderSide(color:Color.fromRGBO(250, 185, 3, 0.9), width: 1),
              //   // ),
              // ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: TextField(
                    controller: textEditingController,
                    onChanged: (value) {
                      messageText = value;
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(80.0),
                          borderSide: BorderSide(color: Colors.grey)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(80.0),
                          borderSide: BorderSide(color: Colors.grey.shade400)),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      hintText: 'write your message here...',
                      border: InputBorder.none,
                    ),
                  )),
                  TextButton(
                      onPressed: () async {
                        textEditingController.clear();
                        _firebaseFirestore.collection("messages").add({
                          'text': messageText,
                          'sender': singedInUer.email,
                          'time': FieldValue.serverTimestamp()
                        });
                      },
                      child: Text(
                        'send',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(250, 185, 3, 0.9),
                          fontSize: 20,
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

class MessageLine extends StatelessWidget {
  MessageLine({Key? key, this.sender, this.text, this.isMe}) : super(key: key);
  final String? sender;
  final String? text;
  final bool? isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe == true ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            "$sender",
            style: TextStyle(fontSize: 10, color: Colors.black45),
          ),
          Material(
            elevation: 5,
            borderRadius: isMe == true
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            color: isMe == true ? Colors.green : Colors.blue,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "$text",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          _firebaseFirestore.collection("messages").orderBy('time').snapshots(),
      builder: (context, snapshot) {
        List<MessageLine> messagesWidget = [];
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        for (var message in messages) {
          final messageFireText = message.get("text");
          final messageSender = message.get("sender");
          final currentUser = singedInUer.email;
          if (currentUser == messageSender) {}

          final messageWidget = MessageLine(
            text: messageFireText,
            sender: messageSender,
            isMe: currentUser == messageSender,
          );
          messagesWidget.add(messageWidget);
        }
        return Expanded(
          child: ListView(
            reverse: true,
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              children: messagesWidget),
        );
      },
    );
  }
}
