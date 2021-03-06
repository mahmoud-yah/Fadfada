import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_app/config/controller.dart';
import 'package:intro_app/models/models.dart';
import 'package:intro_app/models/normal_post.dart';
import 'package:intro_app/screens/comments.dart';
import 'package:intro_app/screens/comments_data.dart';
import 'package:intro_app/screens/edit_post.dart';
import 'package:intro_app/screens/report_post.dart';
import 'package:intro_app/screens/visit_profile.dart';
import 'package:intro_app/widgets/profile_avatar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

class PostContainer extends StatefulWidget {
  final Post post;
  final bool isMe;

  const PostContainer({Key key, @required this.post, this.isMe = false})
      : super(key: key);

  @override
  _PostContainerState createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {
  Controller ctrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100.0,
      // color: Colors.black,
      color: Theme.of(context).backgroundColor,
      // decoration: BoxConstraints,
      margin: const EdgeInsets.symmetric(vertical: 0.5),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PostHeader(
                  post: widget.post,
                  isMe: widget.isMe,
                ),
                const SizedBox(height: 6.0),
                Text(
                  widget.post.caption,
                  // '0',
                  style: TextStyle(
                    // color: Colors.white,
                    color: Theme.of(context).primaryColor,
                    height: 1.25,
                    letterSpacing: 0.5,
                  ),
                ),
                widget.post.imageUrl != null
                    ? const SizedBox.shrink()
                    : const SizedBox(
                        height: 6.0,
                      ),
              ],
            ),
          ),
          widget.post.imageUrl != null
              ?
              // Padding(
              //         padding: const EdgeInsets.symmetric(vertical: 8.0),
              //         child: CachedNetworkImage(imageUrl: post.imageUrl),
              //       )
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    child: CachedNetworkImage(
                        imageUrl:
                            'http://192.168.1.2:8000/${widget.post.imageUrl}'),
                    // child: CachedNetworkImage(imageUrl: 'https://www.apkmod.co/wp-content/uploads/2020/03/Fadfada-Chat-Rooms.png'),
                  ),
                )
              // Container(
              //   decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(post.imageUrl),fit: BoxFit.cover)),
              //   constraints: BoxConstraints(maxHeight: 400.0),
              //     padding: EdgeInsets.symmetric(vertical: 8.0),
              //     // child: CachedNetworkImage(
              //     //   imageUrl: post.imageUrl,
              //     // ),
              //   )

              // : const SizedBox.shrink(),
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    // child: CachedNetworkImage(imageUrl: post.imageUrl),
                    child: CachedNetworkImage(
                      imageUrl:
                          // 'https://www.apkmod.co/wp-content/uploads/2020/03/Fadfada-Chat-Rooms.png',
                          'https://scontent-frt3-1.xx.fbcdn.net/v/t1.6435-9/122464299_114797577087656_2560421644886291278_n.jpg?_nc_cat=102&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=I3wh-R1OFE0AX-xeg9X&_nc_ht=scontent-frt3-1.xx&oh=8e51be0efb21c00f1ebec924a97e8185&oe=6122AD39',
                    ),
                  ),
                ),

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
          //   child: _PostButton(
          //     icon: Icon(
          //       MdiIcons.heart,
          //       color: Colors.white,
          //       size: 20.0,
          //     ),
          //     label: 'Like',
          //     onTap: () {
          //       print('Like');
          //     },
          //   ),
          // ),
          // Row(
          //   children: [
          //     Icon(Icons.favorite_border,color: Colors.white,)
          //   ],
          // ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        likePost();
                      },
                      child: Icon(
                        //   Icons.favorite_border,
                        // color: Theme.of(context).primaryColor,
                        widget.post.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: widget.post.isLiked
                            ? Colors.red.shade800
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      // '0',
                      widget.post.likes.toString(),
                      style: TextStyle(
                        // color: Colors.white,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    // Text(
                    //   'Likes',
                    //   style: TextStyle(color: Colors.white),
                    // ),
                  ],
                ),
                // OutlinedButton(
                //     onPressed: () {},
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Icon(
                //           Icons.add_comment,
                //           color: Colors.white,
                //         ),
                //         SizedBox(
                //           width: 5.0,
                //         ),
                //         Text(
                //           'Add a comment',
                //           style: TextStyle(color: Colors.white),
                //         ),
                //       ],
                //     )),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(GetComments(post: widget.post));
                      },
                      child: Icon(
                        Icons.mode_comment,
                        // color: Colors.white,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      widget.post.commentsNumber.toString(),
                      // '0',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    // Text(
                    //   'Comments',
                    //   style: TextStyle(color: Colors.white),
                    // ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void likePost() async {
    // var url = 'http://10.0.2.2:8000/api/like';
    var url = 'http://192.168.1.2:8000/api/like';
    // print('reporting');

    var response = await GetConnect().post(
        url, {'post_id': widget.post.postID.toString(), 'like': true},
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}'});
    // dio.Response response = await dio.Dio().post(
    //   url,
    //   data: {'post_id': widget.post.postID.toString(), 'like':true},
    //   options: dio.Options(
    //     headers: {
    //       // HttpHeaders.contentTypeHeader: "application/json",
    //       // "Content-Type": "application/x-www-form-urlencoded",
    //       HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}'
    //     },
    //   ),
    // );
    print(response.body);
    // var data = jsonDecode(response.body);
    // if(data['success']==true){
    print(response.statusCode);
    if (response.statusCode == 200) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(
      //       'Post liked successfully',
      //       style: TextStyle(color: Theme.of(context).primaryColor),
      //     ),
      //     backgroundColor: Theme.of(context).backgroundColor,
      //     padding: EdgeInsets.only(bottom: 10),
      //   ),
      // );

    }
    else unlikePost();
    setState(() {
      if (widget.post.isLiked == false) {
        widget.post.likes = widget.post.likes + 1;
      } else
        widget.post.likes = widget.post.likes - 1;
      widget.post.isLiked = !widget.post.isLiked;
    });
  }

  unlikePost() async {
    var url = Uri.parse('http://192.168.1.2:8000/api/like/${ctrl.currentUserProfile.userID}');
    var request = http.Request("DELETE", url);
    request.body = jsonEncode({'post_id':widget.post.postID,'like':false});
    request.headers[HttpHeaders.authorizationHeader] = 'Bearer ${ctrl.token}';
    request.headers[HttpHeaders.acceptHeader] = 'application/json';
    request.headers[HttpHeaders.contentTypeHeader]='application/json';
    request.headers[HttpHeaders.acceptEncodingHeader]='gzip, deflate, br';
    var response = await request.send();
    if(response.statusCode==200){
      print('Disliked');
    }
    else print(response.statusCode);
  }
}

class _PostHeader extends StatelessWidget {
  final Controller ctrl = Get.find();

  final bool isMe;
  final Post post;

  _PostHeader({
    Key key,
    @required this.post,
    this.isMe = false,
  }) : super(key: key);

  void savePost() async {
    // var url = Uri.parse('http://10.0.2.2:8000/api/savedPost');
    var url = Uri.parse('http://192.168.1.2:8000/api/savedPost');
    http.Response response = await http.post(url,
        body: {'post_id': post.postID.toString()},
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}'});
    var data = jsonDecode(response.body);
    if (data['success'] == true) {
      ScaffoldMessenger.of(Get.context).showSnackBar(
        SnackBar(
          content: Text(
            'Post saved successfully',
            style: TextStyle(color: Theme.of(Get.context).primaryColor),
          ),
          backgroundColor: Theme.of(Get.context).backgroundColor,
          padding: EdgeInsets.only(bottom: 10),
        ),
      );
    }
  }

  void deletePost() async {
    var url = Uri.parse('http://192.168.1.2:8000/api/posts/${post.postID}');
    http.Response response = await http.delete(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}'});

    // var data = jsonDecode(response.body);
    // if(data['success']==true){
    print(response.statusCode);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(Get.context).showSnackBar(
        SnackBar(
          content: Text(
            'Post deleted successfully',
            style: TextStyle(color: Theme.of(Get.context).primaryColor),
          ),
          backgroundColor: Theme.of(Get.context).backgroundColor,
          padding: EdgeInsets.only(bottom: 10),
        ),
      );
    } else {
      ScaffoldMessenger.of(Get.context).showSnackBar(
        SnackBar(
          content: Text(
            'Something went wrong.',
            style: TextStyle(color: Theme.of(Get.context).primaryColor),
          ),
          backgroundColor: Theme.of(Get.context).backgroundColor,
          padding: EdgeInsets.only(bottom: 10),
        ),
      );
    }
  }

  void reportPost(BuildContext context) async {
    var url = Uri.parse('http://192.168.1.2:8000/api/report');
    http.Response response = await http.post(url,
        body: {'post_id': post.postID.toString(), 'description': ' '},
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}'});

    var data = jsonDecode(response.body);
    // if(data['success']==true){
    print(response.statusCode);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Post reported successfully',
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
            'Something went wrong.',
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
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // ProfileAvatar(imageUrl: post.imageUrl),
        GestureDetector(
          onTap: () {
            Get.to(() => VisitProfile(userID: post.userID.toString()));
          },
          child: ProfileAvatar(
              imageUrl:
                  // 'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png'),
                  'http://192.168.1.2:8000/${post.imageProfile}'),
        ),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${post.firstName} ' + '${post.lastName}',
                // post.userID.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  // color: Colors.white,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                height: 2.0,
              ),
              Row(
                children: [
                  Text(
                    '${post.timeAgo}',
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
        isMe
            ? PopupMenuButton(
                onSelected: (result) {
                  if (result == 0) {
                    Get.to(() => EditPost(post: post));
                  } else
                    deletePost();
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    value: 0,
                  ),
                  PopupMenuItem(
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    value: 1,
                  ),
                ],
              )
            : PopupMenuButton(
                onSelected: (result) {
                  if (result == 0) {
                    savePost();
                  } else
                    Get.to(() => (ReportPost(post: post)));
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    value: 0,
                  ),
                  PopupMenuItem(
                    child: Text(
                      'Report',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    value: 1,
                  ),
                ],
              ),
      ],
    );
  }
}

class _PostStats extends StatelessWidget {
  final TestPost post;

  const _PostStats({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _PostButton(
              icon: Icon(
                MdiIcons.thumbUpOutline,
                color: Colors.blue,
                size: 20.0,
              ),
              label: 'Like',
              onTap: () => print('Like'),
            )
          ],
        ),
      ],
    );
  }
}

class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function onTap;

  const _PostButton({
    Key key,
    @required this.icon,
    @required this.label,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              children: [
                icon,
                const SizedBox(
                  width: 4.0,
                ),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
