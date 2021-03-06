import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_app/app_localizations.dart';
import 'package:intro_app/config/controller.dart';
import 'package:intro_app/models/normal_post.dart';
import 'package:http/http.dart'as http;

class EditPost extends StatefulWidget {


  final Post post;

   EditPost({Key key, this.post}) : super(key: key);

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  @override
  void initState() {
    postController.text=widget.post.caption;
    super.initState();
  }
  final TextEditingController postController = TextEditingController();

  final TextEditingController imageController = TextEditingController();

  final Controller ctrl = Get.find();

  void editPost(postText) async{
    // var url = Uri.parse('http://10.0.2.2:8000/api/posts/'+widget.post.postID.toString());
    var url = Uri.parse('http://192.168.1.2:8000/api/posts/'+widget.post.postID.toString());
    http.Response response = await http.put(url,headers: {HttpHeaders.authorizationHeader:'Bearer ${ctrl.token}'},body: {'text':postText,'status':'happy'});
    print(response.body);
    if(response.statusCode==200){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Post edited successfully',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 6.0,
        backgroundColor: Theme.of(context).backgroundColor,
        padding: EdgeInsets.only(bottom: 10),
      ));
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        // brightness: Brightness.dark,
        brightness: Theme.of(context).brightness,
        // backgroundColor: Colors.black,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          AppLocalizations.of(context).translate("editPost"),
          // 'Create Post',
          style: TextStyle(
            // color: Colors.white,
            color: Theme.of(context).primaryColor,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.close_rounded,
            size: 30.0,
            // color: Colors.blueAccent,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            child: ElevatedButton(
              onPressed: () {
                editPost(postController.text);
              },
              child: Text(
                AppLocalizations.of(context).translate("update"),
                // 'POST',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                // primary: Colors.blueAccent,
                primary: Theme.of(context).accentColor,
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        // color: Colors.black87,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                            'http://192.168.1.2:8000/${widget.post.imageProfile}'),
                        radius: 30.0,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // 'David Brooks',
                          '${widget.post.firstName} '+'${widget.post.lastName}',
                          style: TextStyle(
                            // color: Colors.white,
                              color: Theme.of(context).primaryColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate("postMotive"),
                            // 'Express your feelings, you are not alone\nWe are all here with you',
                            style: TextStyle(
                              height: 1.15,
                              color: Colors.grey,
                              fontSize: 13.0,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: postController,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)
                            .translate("whatsHappening"),
                        // hintText: 'What\'s happening?',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 20.0,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                      maxLines: 19,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // width: double.infinity,
      ),
    );
  }
}
