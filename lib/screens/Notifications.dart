import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_app/app_localizations.dart';
import 'package:intro_app/models/notification_model.dart';

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(
          // 'Notifications',
          AppLocalizations.of(context).translate("notifications"),
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
            color: Colors.white,
            iconSize: 30.0,
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
          padding: EdgeInsets.only(top: 10.0),
          itemCount: notifications.length,
          itemBuilder: (BuildContext context, int index) {
            final PostNotification notification = notifications[index];
            return GestureDetector(
              onTap: () {
                print('Notification');
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  // border: Border(
                  //   bottom: BorderSide(color: Colors.grey[900]),
                  // ),
                  color: notification.seen ? Colors.black : Colors.grey[900],
                ),
                height: 100.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage(notification.sender.imageUrl),
                            radius: 30.0,
                          ),
                        ),
                        Text(
                          notification.sender.name,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          notification.text,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    Text(
                      notification.time,
                      style: TextStyle(fontSize: 13.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
