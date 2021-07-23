import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intro_app/config/controller.dart';
import 'package:intro_app/models/normal_post.dart';
import 'package:intro_app/screens/profile_posts.dart';

class PostsData extends StatefulWidget {
  // const PostsData({Key? key}) : super(key: key);

  @override
  _PostsDataState createState() => _PostsDataState();
}

class _PostsDataState extends State<PostsData> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosts();
  }

  final Controller ctrl = Get.find();
  List<Post> posts = [];

  Future getPosts() async {
    // var url = Uri.parse('http://10.0.2.2:8000/api/posts/'+ctrl.currentUserProfile.userID);
    var url = Uri.parse('http://192.168.1.2:8000/api/posts/'+ctrl.currentUserProfile.userID);
    http.Response response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}'});
    var data = jsonDecode(response.body);

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
        isLiked:false,
      );
      // ctrl.addToVisitPost(post);
      posts.add(post);
      // print(data['data'][i]['text']);
    }
    print(ctrl.posts.length);
    // Get.off(ProfilePosts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
