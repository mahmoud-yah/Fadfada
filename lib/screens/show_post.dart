import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_app/app_localizations.dart';
import 'package:intro_app/config/controller.dart';
import 'package:intro_app/models/normal_post.dart';
import 'package:intro_app/models/notification_model.dart';
import 'package:intro_app/widgets/post_container.dart';

class ShowPost extends StatefulWidget {
  final PostNotification notification;

  const ShowPost({Key key,this.notification}) : super(key: key);

  @override
  _ShowPostState createState() => _ShowPostState();
}

class _ShowPostState extends State<ShowPost> {
  @override
  void initState() {
    getData = getPost();
    super.initState();
  }

  final Controller ctrl = Get.find();
  Future<String> getData;
  Post post = Post();

  void setSeen() async{
    // We need notification id
    var url = 'http://10.0.2.2:8000/api/notification/${widget.notification.postID}';
  }

  Future<String> getPost() async {
    var url = 'http://10.0.2.2:8000/api/posts/detail/${widget.notification.postID}';
    var response = await GetConnect().get(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}'});
    print(response.body);
    var data = response.body;

    var dataHolder = data['data'];
    print(dataHolder['text']);
      post = Post(
      postID: dataHolder['id'],
      userID: dataHolder['user_id'],
      caption: dataHolder['text'],
      timeAgo: dataHolder['created_at'],
      imageUrl: dataHolder['image'],
      likes: dataHolder['like_number'],
      name: dataHolder['name'],
      firstName: dataHolder['first_name'],
      lastName: dataHolder['second_name'],
      isLiked: false,
    );
    return 'ok';
  }

  refreshData() {
    getData = getPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(AppLocalizations.of(context).translate('post'),style: TextStyle(color: Theme.of(context).primaryColor),),
        centerTitle: true,
      ),
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
                child: PostContainer(
                  post: post,
                ),
              ),
            );
          else {
            print(snapshot.error);
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Some error happened',style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20),),
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
    );
  }
}
