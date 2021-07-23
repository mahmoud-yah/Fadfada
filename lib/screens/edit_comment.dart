import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_app/app_localizations.dart';
import 'package:intro_app/config/controller.dart';
import 'package:intro_app/models/comment_model.dart';
import 'package:intro_app/models/normal_post.dart';
import 'package:http/http.dart' as http;
import 'package:intro_app/widgets/profile_avatar.dart';

class EditComment extends StatefulWidget {
  final Comment comment;

  EditComment({Key key, this.comment}) : super(key: key);

  @override
  _EditCommentState createState() => _EditCommentState();
}

class _EditCommentState extends State<EditComment> {
  @override
  void initState() {
    commentController.text = widget.comment.caption;
    super.initState();
  }

  final TextEditingController commentController = TextEditingController();

  // final TextEditingController imageController = TextEditingController();

  final Controller ctrl = Get.find();

  void editComment(BuildContext context) async {
    // var url = Uri.parse('http://10.0.2.2:8000/api/comment/${widget.comment.ID}');
    var url = Uri.parse('http://192.168.1.2:8000/api/comment/${widget.comment.ID}');
    // print('reporting');
    http.Response response = await http.put(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}'},
        body: {'description': commentController.text, 'post_id': widget.comment.postID.toString()});

    var data = jsonDecode(response.body);
    // if(data['success']==true){
    print(response.body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Comment edited successfully',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          padding: EdgeInsets.only(bottom: 10),
        ),
      );
      Get.back();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context).translate('somethingWrong'),
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          padding: EdgeInsets.only(bottom: 10),
        ),
      );
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
          AppLocalizations.of(context).translate("edit"),
          // 'Create Post',
          style: TextStyle(
            // color: Colors.white,
            color: Theme.of(context).primaryColor,
          ),
        ),
        centerTitle: true,
        leading: Container(),
        leadingWidth: 0,
      ),
      body: Container(
        // color: Colors.black87,
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileAvatar(
                        imageUrl:
                            'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png'),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      // margin: EdgeInsets.symmetric(horizontal: 15.0),
                      // height: MediaQuery.of(context).size.height * 0.09,
                      width: MediaQuery.of(context).size.width * 0.8,
                      // width: double.infinity,
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(400),
                      //   // color: Colors.blueGrey,
                      // ),
                      child: TextField(
                        controller: commentController,
                        // maxLength: 20,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                          // color: Colors.white,
                          color: Theme.of(context).primaryColor,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),

                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey),
                          ),
                        ),
                        // decoration: InputDecoration.collapsed(
                        //   // hintText: 'Send a message...',
                        //   hintText: AppLocalizations.of(context).translate("comment"),
                        //   hintStyle: TextStyle(
                        //     // color: Colors.white,
                        //     color: Theme.of(context).primaryColor.withOpacity(0.7),
                        //   ),
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    ElevatedButton(onPressed: (){Get.back();}, child: Text('Cancel'),style: ElevatedButton.styleFrom(primary: Theme.of(context).accentColor),),
                    SizedBox(width: 10),
                    ElevatedButton(onPressed: (){editComment(context);}, child: Text('update'),style: ElevatedButton.styleFrom(primary: Theme.of(context).accentColor),),
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
