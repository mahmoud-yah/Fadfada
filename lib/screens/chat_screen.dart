// import 'dart:html';

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intro_app/app_localizations.dart';
import 'package:intro_app/models/message_model.dart';
import 'package:intro_app/models/user_model.dart';

class ChatScreen extends StatefulWidget {
  final User user;

  ChatScreen({this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
              Text(
                message.time,
                style: TextStyle(
                    // color: Colors.white,
                    color: Theme.of(context).primaryColor,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 8.0,
              ),
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
        isMe
            ? Text('')
            : IconButton(
                icon: message.isLiked
                    ? Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.favorite_border,
                        color: Colors.blueGrey,
                      ),
                onPressed: () {
                  setState(() {
                    // message.isLiked=!message.isLiked;
                  });
                }),
      ],
    );
  }

  _buildMessageComposer() {
    File _image;
    final _picker = ImagePicker();
    Future getImage() async{
      final image = await _picker.getImage(source: ImageSource.gallery);
      // _image=image;
    }
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
              color: Theme.of(context).accentColor,
              // color: Colors.white,
            ),
            iconSize: 25.0,
            onPressed: () {
              getImage();
            },
          ),
          Expanded(
              child: TextField(
            style: TextStyle(
              color: Colors.white,
              // color: Theme.of(context).primaryColor,
            ),
            decoration: InputDecoration.collapsed(
              // hintText: 'Send a message...',
              hintText: AppLocalizations.of(context).translate("sendMessage"),
              hintStyle: TextStyle(
                // color: Colors.white,
                color: Theme.of(context).accentColor,
              ),
            ),
          )),
          IconButton(
            icon: Icon(
              Icons.send,
              color: Theme.of(context).accentColor,
              // color: Colors.white,
            ),
            iconSize: 25.0,
            onPressed: () {
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
            color: Theme.of(context).accentColor,
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
                child: ListView.builder(
                  reverse: true,
                  padding: EdgeInsets.only(top: 15.0),
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final message = messages[index];
                    final bool isMe = message.sender.id == currentUser.id;
                    return _buildMessage(message, isMe);
                  },
                ),
              ),
            ),
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }
}
