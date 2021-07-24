import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_app/app_localizations.dart';
import 'package:intro_app/config/controller.dart';
import 'package:intro_app/data/data.dart';
import 'package:intro_app/models/normal_post.dart';
import 'package:intro_app/models/post_model.dart';
import 'package:intro_app/widgets/post_container.dart';
import 'package:http/http.dart' as http;

class ProfilePosts extends StatefulWidget {

  final String userID;
  ProfilePosts({@required this.userID});

  @override
  _ProfilePostsState createState() => _ProfilePostsState();
}

class _ProfilePostsState extends State<ProfilePosts> {
  List<Post> posts = [];
  @override
  void initState() {
    // TODO: implement initState
    print('hello posts');
    getData = getPosts();
    super.initState();
  }

  Future<String> getData;
  final Controller ctrl = Get.find();

  refreshData() {
      getData = getPosts();
  }

  Future<String> getPosts() async {
    posts.clear();
    // var url = Uri.parse('http://10.0.2.2:8000/api/posts/' + widget.userID);
    var url = Uri.parse('http://192.168.1.2:8000/api/posts/' + widget.userID);
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
        commentsNumber: dataHolder[i]['like_number'].toString(),
        imageProfile: dataHolder[i]['image_profile'],
        firstName: dataHolder[i]['first_name'],
        lastName: dataHolder[i]['second_name'],
        isLiked: false,
      );
      // ctrl.addToVisitPost(post);
      posts.add(post);
      // print(data['data'][i]['text']);
    }
    posts = List.from(posts.reversed);
    return 'ok';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        brightness: Theme.of(context).brightness,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          AppLocalizations.of(context).translate("posts"),
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
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
                  bottom: MediaQuery.of(context).size.height * 0.1),
              child: RefreshIndicator(
                onRefresh: () async{
                  // print('refreshed');
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

      // ListView.builder(
      //   itemBuilder: (BuildContext context, int index) {
      //     Post post = posts[index];
      //     return PostContainer(post: post);
      //   },
      //   itemCount: posts.length,
      // ),
      // CustomScrollView(
      //   slivers: [
      //     SliverList(
      //       delegate: SliverChildBuilderDelegate((context, index) {
      //         final Post post = profilePosts[index];
      //         return PostContainer(post: post);
      //       }, childCount: posts.length),
      //     ),
      //   ],
      // ),
    );
  }
}
