import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_app/app_localizations.dart';
import 'package:intro_app/config/controller.dart';
import 'package:intro_app/models/comment_model.dart';
import 'package:intro_app/widgets/profile_avatar.dart';
import 'package:http/http.dart' as http;

class Comments extends StatelessWidget {
  // const Comments({Key? key}) : super(key: key);
  final List<Comment> comments;


  Comments({this.comments});



  // final testComments=[
  //   Comment(
  //     userID: 1,
  //     name: 'Alan Hussein',
  //     imageUrl: '',
  //     caption:
  //     'Hi my name is alan i am 23 years old i study at the AIUHi my name is alan i am 23 years old i study at the AIUHi my name is alan i am 23 years old i study at the AIUHi my name is alan i am 23 years old i study at the AIUHi my name is alan i am 23 years old i study at the AIUHi my name is alan i am 23 years old i study at the AIUHi my name is alan i am 23 years old i study at the AIUHi my name is alan i am 23 years old i study at the AIUHi my name is alan i am 23 years old i study at the AIU',
  //     isLiked: true,
  //     likes: 5,
  //     timeAgo: '54m',
  //   ),
  //   Comment(
  //     userID: 2,
  //     name: 'Alan Hussein',
  //     imageUrl: '',
  //     caption:
  //     'Hi my name is alan i am 23 years old i study at the AIUHi my name is alan i am 23 years old i study at the AIU',
  //     isLiked: true,
  //     likes: 5,
  //     timeAgo: '32m',
  //   ),
  //   Comment(
  //     userID: 3,
  //     name: 'Alan Hussein',
  //     imageUrl: '',
  //     caption:
  //     'Hi my name is alan i am 23 years old i study at the AIU Hi my name is alan i am 23',
  //     isLiked: true,
  //     likes: 5,
  //     timeAgo: '24m',
  //   ),
  //   Comment(
  //     userID: 4,
  //     name: 'Alan Hussein',
  //     imageUrl: '',
  //     caption:
  //     'Hi my name is alan i am 23 years old i study at the AIUHi my name is alan i am 23 years old i study at the AIUHi my name is alan i am 23 years old i study at the AIUHi my name is alan i am 23 years old i study at the AIUHi my name is alan i am 23 years old i study at the AIUHi my name is alan i am 23 years old i study at the AIUHi my name is alan i am 23 years old i study at the AIUHi my name is alan i am 23 years old i study at the AIUHi my name is alan i am 23 years old i study at the AIU',
  //     isLiked: true,
  //     likes: 5,
  //     timeAgo: '15m',
  //   ),
  //   Comment(
  //     userID: 5,
  //     name: 'Alan Hussein',
  //     imageUrl: '',
  //     caption:
  //     'Hi my name is alan ',
  //     isLiked: true,
  //     likes: 5,
  //     timeAgo: '4m',
  //   ),
  // ];
  //
  //
  // final Comment comment = Comment(
  //   userID: 23,
  //   name: 'Alan Hussein',
  //   imageUrl: '',
  //   caption:
  //       'Hi my name is alan i am 23 years old i study at the AIU Hi my name is alan i am 23 years old i study at the AIU',
  //   isLiked: true,
  //   likes: 5,
  //   timeAgo: '8m',
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          AppLocalizations.of(context).translate("comments"),
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.1),
        child: ListView.builder(itemBuilder: (BuildContext context, int index){
          Comment comment = comments[index];
          print(comment.firstName);
          return Container(
            padding: EdgeInsets.only(top: 18,bottom: 2,),
            child: _CommentHeader(comment: comment,),
            // child: Text('hello',style: TextStyle(color: Colors.white),),
          );
        },itemCount: comments.length,),
        // child: Column(
        //   children: [
        //     _CommentHeader(comment: comment),
        //   ],
        // ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.09,
        // color: Colors.blueGrey,
        child: Row(
          children: [
            Icon(
              Icons.emoji_emotions_outlined,
              color: Theme.of(context).primaryColor.withOpacity(0.7),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: TextField(
              style: TextStyle(
                // color: Colors.white,
                color: Theme.of(context).primaryColor,
              ),
              decoration: InputDecoration.collapsed(
                // hintText: 'Send a message...',
                hintText: AppLocalizations.of(context).translate("comment"),
                hintStyle: TextStyle(
                  // color: Colors.white,
                  color: Theme.of(context).primaryColor.withOpacity(0.7),
                ),
              ),
            )),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                // color: Theme.of(context).accentColor,
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).translate("post"),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CommentHeader extends StatelessWidget {
  final Comment comment;

  final Controller ctrl = Get.find();

   _CommentHeader({
    Key key,
    @required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ProfileAvatar(imageUrl: post.imageUrl),
        ProfileAvatar(
            imageUrl:
                'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png'),
        const SizedBox(
          width: 12.0,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   comment.name,
                  //   // post.userID.toString(),
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.w600,
                  //     // color: Colors.white,
                  //     color: Theme.of(context).primaryColor,
                  //   ),
                  // ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Theme.of(context).primaryColor,
                              height: 1.35),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${comment.firstName} '+'${comment.lastName}  ',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: comment.caption,
                            )
                          ],
                        ),
                      )
                      // Text(
                      //   '${comment.name}  '+'${comment.caption}',
                      //   style: TextStyle(
                      //     color: Theme.of(context).primaryColor,
                      //     height: 1.25
                      //   ),
                      //   // overflow: TextOverflow.ellipsis,
                      //
                      // ),
                      )
                ],
              ),
              SizedBox(
                // height: 4.0,
                height: MediaQuery.of(context).size.height*0.012,
              ),
              Row(
                children: [
                  Text(
                    '${comment.timeAgo}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                  // Icon(
                  //   Icons.public,
                  //   color: Colors.grey[600],
                  //   size: 12.0,
                  // )
                ],
              ),
            ],
          ),
        ),
        PopupMenuButton(
          onSelected: (result) {
            if (result == 0) {
              if (comment.userID.toString() ==
                  ctrl.currentUserProfile.userID.toString()) {
                deleteComment(context);
              } else
                print('You can only edit your own posts!');
            } else if (result == 1) {
              // print('post.userid: ' + post.userID.toString());
              // print('ctrl.userid: ' + ctrl.currentUserProfile.userID);
              if (comment.userID.toString() ==
                  ctrl.currentUserProfile.userID.toString()) {
                // editComment();
              } else
                print('You can only edit your own posts!');
            } else
              print('call Report comment');
              // reportPost(context);
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              value: 0,
            ),
            PopupMenuItem(
              child: Text(
                'Edit',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              value: 1,
            ),
            PopupMenuItem(
              child: Text(
                'Report',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              value: 2,
            ),
          ],
        ),
      ],
    );
  }

  void deleteComment(BuildContext context) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/like/${comment.ID}');
    // print('reporting');
    http.Response response = await http.delete(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}'});

    var data = jsonDecode(response.body);
    // if(data['success']==true){
    print(response.statusCode);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Comment deleted successfully',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          padding: EdgeInsets.only(bottom: 10),
        ),
      );
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

}
