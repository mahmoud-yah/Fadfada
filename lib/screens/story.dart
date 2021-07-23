import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_app/config/controller.dart';
// import 'package:intro_app/config/controller.dart';
import 'package:intro_app/models/story_model.dart';
import 'package:http/http.dart' as http;
import 'package:story_view/story_view.dart';

class ShowStory extends StatefulWidget {
  final Story story;
  const ShowStory({Key key,@required this.story}) : super(key: key);

  @override
  _ShowStoryState createState() => _ShowStoryState();
}

class _ShowStoryState extends State<ShowStory> {
  final Controller ctrl = Get.find();
  List<Story> stories = [];
  Future<String> getData;
  refreshData() {
    setState(() {
      getData = getStories();
    });
  }
  getStories() async{
    stories.clear();

    // var url = Uri.parse('http://10.0.2.2:8000/api/notification/${ctrl.currentUserProfile.userID.toString()}');
    var url = Uri.parse('http://192.168.1.2:8000/api/notification/${ctrl.currentUserProfile.userID.toString()}');
    http.Response response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}'});
    var data = jsonDecode(response.body);

    var dataHolder = data['data'];
  }
  final controller = StoryController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: StoryView(
        storyItems: [
          // StoryItem.text(title: 'Hello ${widget.story.firstName} ${widget.story.lastName}', backgroundColor: Theme.of(context).backgroundColor),
          StoryItem.pageVideo('http://192.168.1.2:8000/${widget.story.videoUrl}', controller: controller,imageFit: BoxFit.fitHeight),
        ],
        controller: controller,
        inline: false,
        repeat: false,
        onComplete: (){Get.back();},
      )
    );
  }
}
