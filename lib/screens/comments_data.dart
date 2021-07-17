import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_app/app_localizations.dart';
import 'package:intro_app/config/controller.dart';
import 'package:http/http.dart' as http;
import 'package:intro_app/models/comment_model.dart';
import 'package:intro_app/models/normal_post.dart';
import 'package:intro_app/screens/comments.dart';
import 'package:intro_app/widgets/profile_avatar.dart';

class GetComments extends StatefulWidget {
  // const GetComments({Key? key}) : super(key: key);

  final Post post;

  GetComments({@required this.post});

  @override
  _GetCommentsState createState() => _GetCommentsState();
}

class _GetCommentsState extends State<GetComments> {
  @override
  void initState() {
    super.initState();
    getData = getComments();
  }

  Future<String> getData;

  refreshData() {
    getData = getComments();
  }

  final Controller ctrl = Get.find();

  List<Comment> comments = [];

  Future<String> getComments() async {
    comments.clear();
    var url = Uri.parse(
        'http://10.0.2.2:8000/api/comment/' + widget.post.postID.toString());
    http.Response response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}'});

    var data = jsonDecode(response.body);
    if (data['success'] == true) {
      var dataHolder = data['data'];
      print(dataHolder[0]['description']);
      for (var i = 0; i < dataHolder.length; i++) {
        // print(i);
        Comment comment = Comment(
          ID: dataHolder[i]['id'],
          postID: dataHolder[i]['post_id'],
          userID: dataHolder[i]['user_id'],
          caption: dataHolder[i]['description'],
          timeAgo: dataHolder[i]['created_at'],
          imageUrl: dataHolder[i]['image'],
          firstName: dataHolder[i]['first_name'],
          lastName: dataHolder[i]['second_name'],
          // ID: 1,
          // postID: 1,
          // userID: 6,
          // caption:'hello from comments',
        );
        // print(comment.caption);
        comments.add(comment);
        // ctrl.addToVisitPost(post);
        // print(data['data'][i]['text']);
      }
      return 'success';
      // print(ctrl.posts.length);
      // Get.off(() => Comments(comments: comments));
    } else {
      // print(response.statusCode);
      return 'no comments';
      // Get.off(() => Comments(comments: []));
    }
    // return comments;
  }

  Future postComment() async {
    var url = Uri.parse('http://10.0.2.2:8000/api/comment');
    http.Response response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}'
    }, body: {
      'description': '${commentController.text}',
      'post_id': '${widget.post.postID}',
      'parent_id': '3',
    });

    var data = jsonDecode(response.body);
    if(data['success']==true){
      setState(() {
        refreshData();
        commentController.clear();
        FocusScope.of(context).unfocus();
      });
    }
  }

  final TextEditingController commentController = TextEditingController();

  // static int counter = 0;

  // Future<String> apiCallLogic() async {
  //   print("Api Called ${++counter} time(s)");
  //   await Future.delayed(Duration(seconds: 2));
  //   return Future.value("Hello World");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          AppLocalizations.of(context).translate("comments"),
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 25),
        ),
        centerTitle: true,
      ),

      backgroundColor: Theme.of(context).backgroundColor,

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
              controller: commentController,
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
              onTap: () {
                postComment();
              },
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
                onRefresh: () {
                  // print('refreshed');
                  setState(() {
                    refreshData();
                  });
                  return null;
                },
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    Comment comment = comments[index];
                    print(comment.firstName);
                    return Container(
                      padding: EdgeInsets.only(
                        top: 18,
                        bottom: 2,
                      ),
                      child: _CommentHeader(
                        comment: comment,
                      ),
                      // child: Text('hello',style: TextStyle(color: Colors.white),),
                    );
                  },
                  itemCount: comments.length,
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
      // Center(
      //   child: CircularProgressIndicator(),
      // ),
      // floatingActionButton: FloatingActionButton(child: Text('Refresh'),onPressed: (){setState(() {
      //
      // });},),
    );
  }
}

class _CommentHeader extends StatelessWidget {
  final Comment comment;

  const _CommentHeader({
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
                              text: '${comment.firstName} ' +
                                  '${comment.lastName}  ',
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
                height: MediaQuery.of(context).size.height * 0.012,
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
        IconButton(
          icon: Icon(
            Icons.more_vert,
            // color: Colors.white,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () => print('more'),
        ),
      ],
    );
  }
}
