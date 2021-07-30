import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_app/screens/chat_screen.dart';

import '../models/message_model.dart';
// import '../models/message_model.dart';

class RecentChats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.white,
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          child: ListView.builder(
            itemCount: chats.length,
            itemBuilder: (BuildContext context, int index) {
              final Message chat = chats[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(
                      user: chat.sender,
                    ),
                  ),
                ),
                child: Padding(
                  padding: index == 0
                      ? const EdgeInsets.only(top: 10.0)
                      : EdgeInsets.zero,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
                    decoration: BoxDecoration(
                      // color: chat.unread ? Color(0xFFFFEFEE) : Colors.white,
                      color:
                          chat.unread ? Color(0xFF3E4042) : Color(0x00000000),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      // color: Colors.black54,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 35.0,
                              backgroundImage: CachedNetworkImageProvider('https://scontent-frt3-1.xx.fbcdn.net/v/t1.6435-9/122464299_114797577087656_2560421644886291278_n.jpg?_nc_cat=102&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=I3wh-R1OFE0AX-xeg9X&_nc_ht=scontent-frt3-1.xx&oh=8e51be0efb21c00f1ebec924a97e8185&oe=6122AD39'),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  chat.sender.name,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.50),
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: Text(
                                    chat.text,
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 15.0,
                                        fontWeight: chat.unread
                                            ? FontWeight.bold
                                            : FontWeight.w600),
                                  ),
                                ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              chat.time,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            chat.unread
                                ? Container(
                                    child: Text(
                                      'NEW',
                                      style: TextStyle(
                                          fontSize: 11.0,
                                          // color: Colors.white,
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    decoration: BoxDecoration(
                                      // color: Colors.deepOrange,
                                      color: Theme.of(context).accentColor,
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    width: 40.0,
                                    height: 20.0,
                                    alignment: Alignment.center,
                                  )
                                : Text(''),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
