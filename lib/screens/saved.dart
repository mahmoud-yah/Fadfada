import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_app/config/controller.dart';
import 'package:intro_app/models/normal_post.dart';
import 'package:http/http.dart' as http;
import 'package:intro_app/widgets/post_container.dart';

class Saved extends StatefulWidget {
  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override
  void initState() {
    // TODO: implement initState
    getData = getPosts();
    super.initState();
  }

  List<Post> posts = [];

  Future<String> getData;
  final Controller ctrl = Get.find();

  refreshData() {
    getData = getPosts();
  }

  Future<String> getPosts() async {
    posts.clear();
    // var url = Uri.parse('http://10.0.2.2:8000/api/savedPost/${ctrl.currentUserProfile.userID}',);
    var url = Uri.parse('http://192.168.1.2:8000/api/savedPost/${ctrl.currentUserProfile.userID}',);
    // print(ctrl.currentUserProfile.userID);
    try {
      http.Response response = await http.get(url,
          headers: {HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}'});
      // print(response.body);
      // print(response.statusCode);
      var data = jsonDecode(response.body);

      print(response.body);

      var dataHolder = data['data'];
      // print(dataHolder[0]['text']);
      for (var i = 0; i < dataHolder.length; i++) {
        Post post = Post(
          postID: dataHolder[i]['id'],
          userID: dataHolder[i]['user_id'],
          caption: dataHolder[i]['text'],
          timeAgo: dataHolder[i]['created_at'],
          imageUrl: dataHolder[i]['image'],
          likes: dataHolder[i]['like_number'],
          name: dataHolder[i]['name'],
          firstName: dataHolder[i]['first_name'],
          lastName: dataHolder[i]['second_name'],
          isLiked: false,
        );
        posts.add(post);
        print(post);
      }
    } catch (e) {
      print(e);
    }

    return 'ok';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).backgroundColor,
        brightness: Theme.of(context).brightness,
        title: Text(
          'Saved Posts',
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getData,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: const CircularProgressIndicator());

          if (snapshot.hasData)
            return Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.1),
              child: RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    refreshData();
                  });
                  return null;
                },
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    Post post = posts[index];
                    return PostContainer(post: post);
                  },
                  itemCount: posts.length,
                ),
              ),
              // child: Column(
              //   children: [
              //     _CommentHeader(comment: comment),
              //   ],
              // ),
            );
          // }
          // else return Center();
          else
            return const Text('Some error happened');
        },
      ),
    );
  }
}
