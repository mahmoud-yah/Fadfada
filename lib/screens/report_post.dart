import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_app/app_localizations.dart';
import 'package:intro_app/config/controller.dart';
import 'package:intro_app/models/normal_post.dart';
import 'package:http/http.dart' as http;


class ReportPost extends StatelessWidget {
  final Post post;
  ReportPost({Key key,@required this.post}) : super(key: key);

  final TextEditingController reportController = TextEditingController();


  void reportPost(BuildContext context) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/report');
    print('reporting');
    http.Response response = await http.post(url,
        body: {'post_id': post.postID.toString(), 'description': reportController.text},
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}'});

    var data = jsonDecode(response.body);
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


  final Controller ctrl = Get.find();

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
          AppLocalizations.of(context).translate("report"),
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
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: 20.0),
                      // margin: EdgeInsets.symmetric(horizontal: 15.0),
                      // height: MediaQuery.of(context).size.height * 0.09,
                      width: MediaQuery.of(context).size.width * 0.94,
                      // width: double.infinity,
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(400),
                      //   // color: Colors.blueGrey,
                      // ),
                      child: TextField(
                        controller: reportController,
                        maxLength: 1000,
                        maxLines: 20,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                          // color: Colors.white,
                          color: Theme.of(context).primaryColor,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Specify your reasons ...',
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
                    ElevatedButton(onPressed: (){reportPost(context);}, child: Text('Report'),style: ElevatedButton.styleFrom(primary: Theme.of(context).accentColor),),
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


