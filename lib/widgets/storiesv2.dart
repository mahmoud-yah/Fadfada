import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intro_app/app_localizations.dart';
import 'package:intro_app/config/controller.dart';
import 'package:intro_app/models/message_model.dart';
import 'package:intro_app/models/story_model.dart';
import 'package:intro_app/screens/story.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as myDio;
import 'package:intro_app/screens/test_video.dart';
import 'package:http_parser/http_parser.dart';

// import 'package:intro_app/screens/chat_screen.dart';
// import 'package:intro_app/screens/profilev3.dart';

class StoriesTest extends StatelessWidget {
  final List<Story> stories;

  // final Function refreshCallback;
  final Controller ctrl = Get.find();

  StoriesTest({this.stories});

  postVideo(BuildContext context, String path) async {
    Map body = {"video": path};
    // var url = 'http://10.0.2.2:8000/api/story';
    var url = Uri.parse('http://192.168.1.2:8000/api/story');
    var request = http.MultipartRequest("POST", url);
    request.files.add(await http.MultipartFile.fromPath('video', path));
    // request.files.add(multipartFile);
    request.headers[HttpHeaders.authorizationHeader] = 'Bearer ${ctrl.token}';
    request.headers[HttpHeaders.acceptHeader] = 'application/json';
    request.headers[HttpHeaders.contentTypeHeader] =
        'multipart/form-data; boundary=<calculated when request is sent>';
    request.headers[HttpHeaders.acceptEncodingHeader] = 'gzip, deflate, br';

    var response = await request.send();
    if (response.statusCode == 200) {
      print('Uploaded!');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Story Uploaded!',
            // AppLocalizations.of(context).translate('somethingWrong'),
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          padding: EdgeInsets.only(bottom: 10),
        ),
      );
    } else
      print(response.statusCode);
    print(response.statusCode);

    // http.Response response = await http.post(url,body: {
    //   'video':path,
    // },headers: {HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}'},);
    // print(response.body);
    // print(response.statusCode);
    // if (response.statusCode == 302) {
    //   var responseUrl = response.headers['location'];
    //   http.get(Uri.parse(responseUrl));
    // }

    // String url = 'http://10.0.2.2:8000/api/story';
    //

    // http.Client client = new http.Client();
    //
    // var response = await GetConnect().post(url, body,headers: {HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}',"Accept" : "application/json"});
    // // http.Response response = await client.post(Uri.parse(url), body: body,headers: {HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}',"Accept" : "application/json"});
    // print(response.body);
    //
    // print(response.statusCode);
    // // print(response.isRedirect);
    // print(response.statusCode);
    // if (response.statusCode == 302) {
    // //   // url = response.headers['location'];
    // //   // client.get(Uri.parse(url));
    // //   // response = await client.post(Uri.parse(url), body: body,headers: {HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}'});
    // //   // print(response.body);
    //   print(response.headers);
    //   if(response.headers.containsKey("location")){
    //     print('hello');
    //     var url = 'http://192.168.1.2:8000/api/story';
    // final getResponse = await GetConnect().post(url, body, headers: {
    //   HttpHeaders.authorizationHeader: "Bearer ${ctrl.token}",
    //   "Accept": "application/json",
    //   HttpHeaders.contentTypeHeader: "multipart/form-data",
    //   HttpHeaders.acceptEncodingHeader: "gzip, deflate, br",
    //   HttpHeaders.connectionHeader: "keep-alive",
    // });
    // print(getResponse.body);
    // print(path);
    // print(getResponse.statusCode);
    //     // print(getResponse.statusCode);
    //     final getResponse = await GetConnect().get(response.headers["location"]);
    //     // print(getResponse.statusCode);
    //     print(getResponse.body);
    //     print('getResponse.statusCode:' + getResponse.statusCode.toString());
    //   }
    // }
    // print(response);
  }

  pickVideo() async {
    final ImagePicker _picker = ImagePicker();
    final XFile file = await _picker.pickVideo(
      source: ImageSource.camera,
      maxDuration: const Duration(seconds: 40),
      preferredCameraDevice: CameraDevice.front,
    );
    print(file.path);
    if (file.isBlank) {
      print('file is empty');
    } else {
      postVideo(Get.context, file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: <Widget>[
            //       Text(
            //         'Stories',
            //         style: TextStyle(
            //           color: Colors.blueGrey,
            //           fontSize: 18.0,
            //           fontWeight: FontWeight.bold,
            //           letterSpacing: 1.0,
            //         ),
            //       ),
            //       // IconButton(
            //       //   icon: Icon(Icons.more_horiz),
            //       //   iconSize: 30.0,
            //       //   color: Colors.blueGrey,
            //       //   onPressed: () {},
            //       // ),
            //     ],
            //   ),
            // ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  AppLocalizations.of(context).translate("stories"),
                  // 'Stories',
                  style: TextStyle(
                    // color: Colors.blueGrey,
                    color: Theme.of(context).accentColor,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              // height: double.infinity,
              // color: Colors.black,
              color: Theme.of(context).backgroundColor,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                // padding: EdgeInsets.only(left: 10.0),
                itemCount: stories.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        index == 0
                            ? GestureDetector(
                                onTap: () {
                                  pickVideo();
                                },
                                child: CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                      'http://192.168.1.2:8000/${ctrl.currentUserProfile.imageUrl}'),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: CircleAvatar(
                                      // backgroundColor: Colors.transparent,
                                      child: Icon(Icons.add,size: 18,),
                                      radius: 12,
                                    ),
                                  ),
                                  radius: 35.0,
                                ))
                            : GestureDetector(
                                onTap: () {
                                  Get.to(() => ShowStory(
                                        story: stories[index - 1],
                                      ));
                                },
                                child: CircleAvatar(
                                  radius: 35.0,
                                  backgroundColor: Theme.of(context).accentColor,
                                  // backgroundColor: Color(ColorTween(begin: Colors.blue,end: Colors.red)),
                                  child: CircleAvatar(
                                    radius: 32.5,
                                    backgroundImage: CachedNetworkImageProvider(
                                        'http://192.168.1.2:8000/${stories[index-1].imageUrl}'),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 6.0,
                        ),
                        index == 0
                            ? Text('Add a story')
                            : Padding(
                                padding: index == stories.length
                                    ? EdgeInsets.only(bottom: 160.0)
                                    : EdgeInsets.zero,
                                child: Text(
                                  stories[index - 1].firstName,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blueGrey),
                                ),
                              ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
