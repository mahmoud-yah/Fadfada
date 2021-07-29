import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_app/app_localizations.dart';
import 'package:intro_app/config/controller.dart';
import 'package:intro_app/models/notification_model.dart';
import 'package:intro_app/screens/show_post.dart';
import 'package:intro_app/widgets/profile_avatar.dart';
import 'package:http/http.dart' as http;

final Controller ctrl = Get.find();

class Notifications extends StatefulWidget {
  // var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    getData = getNotifications();
    super.initState();
  }

  Future<String> getData;
  List<PostNotification> notifications = [];

  refreshData() {
    setState(() {
      getData = getNotifications();
    });
  }

  Future<String> getNotifications() async {
    notifications.clear();

    // ctrl.posts
    print(ctrl.currentUserProfile.userID);
    // var url = Uri.parse('http://10.0.2.2:8000/api/notification/${ctrl.currentUserProfile.userID.toString()}');
    var url = Uri.parse(
        'http://192.168.1.2:8000/api/notification/${ctrl.currentUserProfile.userID}');
    http.Response response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}'});
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      var dataHolder = data['data'];
      // print(dataHolder[0]['text']);
      print(response.statusCode);
      for (var i = 0; i < dataHolder.length; i++) {
        PostNotification notification = PostNotification(
          notificationID: dataHolder[i]['id'].toString(),
          postID: dataHolder[i]['post_id'].toString(),
          userID: dataHolder[i]['user_id'].toString(),
          likeID: dataHolder[i]['like_id'].toString(),
          commentID: dataHolder[i]['comment_id'].toString(),
          imageUrl: dataHolder[i]['image'],
          firstName: dataHolder[i]['first_name'],
          lastName: dataHolder[i]['second_name'],
          type: dataHolder[i]['description'],
          fromUserID: dataHolder[i]['from_user_id'].toString(),
          time: dataHolder[i]['created_at'],
          seen: dataHolder[i]['seen'] == 'false' ? false : true,
        );
        // ctrl.addPost(post);

        notifications.add(notification);
        // print(data['data'][i]['text']);
      }
      notifications = List.from(notifications.reversed);
    } else {
      print('no notifications');
    }
    // ctrl.posts = List.from(ctrl.posts.reversed);
    // print(ctrl.posts.length);
    return 'ok';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // endDrawerEnableOpenDragGesture: true,
      // key: scaffoldKey,
      // endDrawer: Drawer(child: Container(),),
      appBar: AppBar(
        // brightness: Brightness.dark,
        brightness: Theme.of(context).brightness,
        title: Text(
          // 'Notifications',
          AppLocalizations.of(context).translate("notifications"),
          style: TextStyle(
            fontSize: 24.0,
            color: Theme.of(context).accentColor,
          ),
        ),
        // backgroundColor: Colors.black,
        backgroundColor: Theme.of(context).backgroundColor,
        leading: Container(),
        leadingWidth: 0,
        // centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     onPressed: () {scaffoldKey.currentState.openEndDrawer();},
        //     // color: Colors.white,
        //     color: Theme.of(context).primaryColor,
        //     iconSize: 30.0,
        //   )
        // ],
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: getData,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: const CircularProgressIndicator());

          if (snapshot.hasData)
            // return Text('${snapshot.data}');
            // if(snapshot.data=='success'){
            return Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.01),
              child: RefreshIndicator(
                onRefresh: () async {
                  // print('refreshed');
                  setState(() {
                    refreshData();
                  });
                  return null;
                },
                child: ListView.builder(
                  // shrinkWrap: true,

                  itemBuilder: (BuildContext context, int index) {
                    final PostNotification notification = notifications[index];
                    return GestureDetector(
                      onTap: () async {
                        await Get.to(() => ShowPost(
                              notification: notification,
                            ));
                        refreshData();
                      },
                      child: NotificationContainer(notification: notification),
                    );
                  },
                  itemCount: notifications.length,
                ),
              ),
            );
          else {
            print(snapshot.error);
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Some error happened'),
                ElevatedButton(
                  onPressed: () {
                    refreshData();
                  },
                  child: Text('Reload'),
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).accentColor),
                ),
              ],
            ));
          }
        },
      ),

      // ListView.builder(
      //     padding: EdgeInsets.only(top: 10.0),
      //     itemCount: notifications.length,
      //     itemBuilder: (BuildContext context, int index) {
      //       final PostNotification notification = notifications[index];
      //       return GestureDetector(
      //         onTap: () {
      //           print('Notification');
      //         },
      //         child: NotificationContainer(notification: notification),
      //       );
      //     }),
    );
  }
}

class NotificationContainer extends StatelessWidget {
  const NotificationContainer({
    Key key,
    @required this.notification,
  }) : super(key: key);

  final PostNotification notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        // border: Border(
        //   bottom: BorderSide(color: Colors.grey[900]),
        // ),
        color: notification.seen ? Colors.black : Colors.grey[900],
      ),
      height: 100.0,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                radius: 28,
                backgroundImage: CachedNetworkImageProvider(
                    'http://192.168.1.2:8000/${notification.imageUrl}'),
              )
              // ProfileAvatar(
              //   // imageUrl: notification.imageUrl,
              //   imageUrl:
              //       'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png',
              //   // radius: 35,
              // ),
              ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    // width: MediaQuery.of(context).size.width*0.3,
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.3,
                    ),
                    child: Text(
                      getNotificationName(context),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Container(
                    child: Text(
                      getNotificationText(context),
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                notification.time,
                style: TextStyle(fontSize: 13.0, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getNotificationText(BuildContext context) {
    if (notification.type == 'like') {
      if (notification.fromUserID == ctrl.currentUserProfile.userID) {
        return AppLocalizations.of(context).translate('youLiked');
      } else
        return AppLocalizations.of(context).translate('liked');
    } else {
      if (notification.fromUserID == ctrl.currentUserProfile.userID) {
        return AppLocalizations.of(context).translate('youCommented');
      } else
        return AppLocalizations.of(context).translate('commented');
    }
  }

  String getNotificationName(BuildContext context) {
    if (notification.fromUserID == ctrl.currentUserProfile.userID)
      return AppLocalizations.of(context).translate('you');
    else
      return '${notification.firstName} ' + '${notification.lastName}';
  }
}
