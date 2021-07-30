// import 'dart:html';

import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intro_app/app_localizations.dart';
import 'package:intro_app/models/message_model.dart';
import 'package:intro_app/models/user_model.dart' as userModel;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intro_app/screens/Notifications.dart';
import 'package:http/http.dart' as http;

final _firestore = FirebaseFirestore.instance;
User loggedIn;

class ChatScreen extends StatefulWidget {
  final userModel.User user;

  ChatScreen({this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  final _auth = FirebaseAuth.instance;


  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedIn = user;
        print(loggedIn.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async{
  //
  //
  //   final messages = await _firestore.collection('messages').get();
  //    for(var message in  messages.docs){
  //      print(message.data());
  //    }
  // }

  void messagesStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  _buildMessage(Message message, bool isMe) {
    // Color selectedColor = Colors.black;
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          // width: MediaQuery.of(context).size.width * 0.45,
          // color: Color(0xFFFFEFEE),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.55,
          ),
          decoration: BoxDecoration(
            // color: isMe ? Theme.of(context).accentColor : Color(0xFFFFEFEE),
            color: isMe ? Color(0xFF9008A6) : Color(0xFF3E4042),
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0))
                : BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
          ),
          margin: EdgeInsets.only(
            // left: isMe ? 0.0 : 20.0,
            // right: isMe ? 20.0 : 0.0,
            top: 5.0,
            bottom: 5.0,
          ),
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   message.time,
              //   style: TextStyle(
              //       // color: Colors.white,
              //       color: Theme.of(context).primaryColor,
              //       fontSize: 11.0,
              //       fontWeight: FontWeight.w600),
              // ),
              // SizedBox(
              //   height: 8.0,
              // ),
              Text(
                message.text,
                style: TextStyle(
                    // color: Colors.blueGrey,
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        // isMe
        //     ? Text('')
        //     : IconButton(
        //         icon: message.isLiked
        //             ? Icon(
        //                 Icons.favorite,
        //                 color: Colors.red,
        //               )
        //             : Icon(
        //                 Icons.favorite_border,
        //                 color: Colors.blueGrey,
        //               ),
        //         onPressed: () {
        //           setState(() {
        //             // message.isLiked=!message.isLiked;
        //           });
        //         }),
      ],
    );
  }

  _buildMessageComposer() {
    XFile _image;
    final _picker = ImagePicker();
    Future getImage() async {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      _image = image;
    }

    TextEditingController messageTextController = TextEditingController();
    var message;

    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 50.0,vertical: 25.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      // width: MediaQuery.of(context).size.width * 0.75,
      // height: MediaQuery.of(context).size.height * 0.07,
      height: 70.0,
      // color: Colors.white,
      decoration: BoxDecoration(
        // color: Colors.white,
        color: Colors.black,
        // border: Border.all(width: 0, color: Colors.white),
      ),
      // decoration: BoxDecoration(
      //   color: Theme.of(context).accentColor,
      //   borderRadius: BorderRadius.all(Radius.circular(30.0)),
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              Icons.photo,
              color: Theme.of(context).primaryColor,
              // color: Colors.white,
            ),
            iconSize: 25.0,
            onPressed: () {
              // getImage();
              messagesStream();
            },
          ),
          Expanded(
              child: TextField(
            onChanged: (value) {
              message = value;
            },
            controller: messageTextController,
            style: TextStyle(
              color: Colors.white,
              // color: Theme.of(context).primaryColor,
            ),
            decoration: InputDecoration.collapsed(
              // hintText: 'Send a message...',
              hintText: AppLocalizations.of(context).translate("sendMessage"),
              hintStyle: TextStyle(
                // color: Colors.white,
                color: Theme.of(context).primaryColor,
              ),
            ),
          )),
          IconButton(
            icon: Icon(
              Icons.send,
              color: Theme.of(context).primaryColor,
              // color: Colors.white,
            ),
            iconSize: 25.0,
            onPressed: () {
              // print(message);
              messageTextController.clear();
              _firestore.collection('messages').add({
                'text': message,
                'id': ctrl.currentUserProfile.userID,
                'image':ctrl.currentUserProfile.imageUrl,
                'date':DateTime.now(),

              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // brightness: Brightness.dark,
        brightness: Theme.of(context).brightness,
        elevation: 0,
        // backgroundColor: Theme.of(context).primaryColor,
        // backgroundColor: Colors.black,
        backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace_rounded,
            color: Theme.of(context).primaryColor,
            size: 35.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.user.name,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz),
            iconSize: 30.0,
            // color: Colors.white,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      // backgroundColor: Colors.black,

      body: Column(
        children: [
          Expanded(
            child: Container(
              // padding: EdgeInsets.only(top: 10.0,),
              // margin: EdgeInsets.only(left: 30.0),
              decoration: BoxDecoration(
                color: Colors.black,
                // image: DecorationImage(
                //   image: AssetImage('images/grey.jpg'),
                //   fit: BoxFit.cover,
                // ),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  topLeft: Radius.circular(30.0),
                ),
                child: MessagesStream(),
                // ListView.builder(
                //   reverse: true,
                //   padding: EdgeInsets.only(top: 15.0),
                //   itemCount: messages.length,
                //   itemBuilder: (BuildContext context, int index) {
                //     final message = messages[index];
                //     final bool isMe = message.sender.id == currentUser.id;
                //     return _buildMessage(message, isMe);
                //   },
                // ),
              ),
            ),
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key key}) : super(key: key);

   Future<String> getImageUrl(id) async{
     var url = Uri.parse('http://192.168.1.2:8000/api/profile/$id');
     http.Response response = await http.get(url,
         headers: {HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}'});
     var data = jsonDecode(response.body);
     var dataHolder = data['data'];
     if(response.statusCode==200)
       return dataHolder['image'];
     else return "profile\\image\\160Hf.png";
   }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('date').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final messages = snapshot.data.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final dataHolder = Map.from(message.data());
          final messageText = dataHolder['text'];
          final messageSender = dataHolder['id'];
          final img = dataHolder['image'];
          final messageBubble = MessageBubble(
            text: messageText,
            sender: messageSender,
            isMe: messageSender==ctrl.currentUserProfile.userID,
            imageUrl: img,
          );
          messageBubbles.add(messageBubble);
        }
        return ListView(
          reverse: true,
          children: messageBubbles,
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({Key key, this.sender, this.text,this.isMe,this.imageUrl}) : super(key: key);

  final String imageUrl;
  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: isMe?MainAxisAlignment.end:MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              isMe?SizedBox.shrink():CircleAvatar(radius: 10,backgroundImage: CachedNetworkImageProvider('http://192.168.1.2:8000/$imageUrl'),),
              SizedBox(width: 10.0),
              Material(
                color: isMe?Color(0xFF9008A6): Color(0xFF3E40450),
                borderRadius: isMe? BorderRadius.only(topLeft: Radius.circular(30.0),bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0)) : BorderRadius.only(topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0) ,bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0)),
                elevation: 5.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    text,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
