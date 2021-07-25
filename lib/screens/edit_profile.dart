import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intro_app/app_localizations.dart';
import 'package:intro_app/config/controller.dart';
import 'package:http/http.dart' as http;
import 'package:intro_app/models/profile_model.dart';
import 'package:dio/dio.dart' as myDio;

class EditProfile extends StatefulWidget {
  final UserProfile profile;

  EditProfile({this.profile});

  // final TextEditingController idTextController = TextEditingController();
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Controller ctrl = Get.find();
  bool inProgress = false;

  void updateControllers() {
    firstNameTextController.text = ctrl.currentUserProfile.firstName;
    lastNameTextController.text = ctrl.currentUserProfile.lastName;
    addressTextController.text = ctrl.currentUserProfile.address;
    bioTextController.text = ctrl.currentUserProfile.bio;
    phoneTextController.text = ctrl.currentUserProfile.phone;
    genderTextController.text = ctrl.currentUserProfile.gender;
    birthDateTextController.text = ctrl.currentUserProfile.birthDate;
  }

  Future updateProfileInfo() async {
    setState(() {
      inProgress = true;
    });


    var url = Uri.parse('http://192.168.1.2:8000/api/profile/${widget.profile.profileID}');
    var request = http.MultipartRequest("POST", url);
    request.fields['first_name']=firstNameTextController.text;
    request.fields['second_name']= lastNameTextController.text;
    request.fields['address']= addressTextController.text;
    request.fields['phone']= phoneTextController.text;
    request.fields['gender']= genderTextController.text;
    request.fields['bio']= bioTextController.text;
    request.fields['date_of_birth']= birthDateTextController.text;
    request.fields['_method']='PUT';
    // request.fields['image']='null';
    // request.fields['image'];
    request.headers[HttpHeaders.authorizationHeader] = 'Bearer ${ctrl.token}';
    request.headers[HttpHeaders.acceptHeader] = 'application/json';
    request.headers[HttpHeaders.contentTypeHeader]='application/json';
    request.headers[HttpHeaders.acceptEncodingHeader]='gzip, deflate, br';
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Uploaded!');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Profile information edited Successfully!',
            // AppLocalizations.of(context).translate('upload'),
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          padding: EdgeInsets.only(bottom: 10),
        ),
      );
      Get.back();
    } else
      print(response.statusCode);
    print(response.statusCode);


    // var url = Uri.parse('http://192.168.1.2:8000/api/profile/${widget.profile.profileID}');

    // http.Response response = await http.post(url, body: {
    //   'first_name': firstNameTextController.text,
    //   'second_name': lastNameTextController.text,
    //   'address': addressTextController.text,
    //   'phone': phoneTextController.text,
    //   'gender': genderTextController.text,
    //   'bio': bioTextController.text,
    //   'date_of_birth': birthDateTextController.text,
    //   '_method':'PUT',
    //   'image':null,

    // }, headers: {
    //   HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}'
    // });

    // print(response.statusCode);
    // if (response.statusCode==200) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(
    //         'profile info updated successfully!',
    //         style: TextStyle(color: Theme.of(context).primaryColor),
    //       ),
    //       backgroundColor: Theme.of(context).backgroundColor,
    //       padding: EdgeInsets.only(bottom: 10),
    //     ),
    //   );
    // }
    // print(response.body);
    // var token = jsonDecode(response.body)['data']['token'];
    // ctrl.setTokenValue(token);
    // // print('ok');
    // if (jsonDecode(response.body)['success'] == true) {
    //   await getPosts();
    //   await getProfile();
    setState(() {
      inProgress = false;
    });
    // Get.to(() => NavScreen());
  }

  @override
  void initState() {
    // TODO: implement initState
    updateControllers();
    super.initState();
  }

  final firstNameTextController = TextEditingController();

  final lastNameTextController = TextEditingController();

  final addressTextController = TextEditingController();

  final bioTextController = TextEditingController();

  final phoneTextController = TextEditingController();

  final genderTextController = TextEditingController();

  final birthDateTextController = TextEditingController();

  changeImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile file = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if(file.isBlank){
      return;
    }

    var url = Uri.parse('http://192.168.1.2:8000/api/profile/${widget.profile.profileID}');
    print(file.path);
    Map body = {
      // 'image': file.path,
      'first_name': firstNameTextController.text,
      'second_name': lastNameTextController.text,
      'address': addressTextController.text,
      'phone': phoneTextController.text,
      'gender': genderTextController.text,
      'bio': bioTextController.text,
      'date_of_birth': birthDateTextController.text,
      '_method':'PUT',
      'image':null,
    };
    // var url = Uri.parse('http://192.168.1.2:8000/api/story')
    var request = http.MultipartRequest("POST", url);
    request.files.add(await http.MultipartFile.fromPath('image', file.path));
    // request.files.add(multipartFile);
    request.fields['first_name']=firstNameTextController.text;
    request.fields['second_name']= lastNameTextController.text;
    request.fields['address']= addressTextController.text;
    request.fields['phone']= phoneTextController.text;
    request.fields['gender']= genderTextController.text;
    request.fields['bio']= bioTextController.text;
    request.fields['date_of_birth']= birthDateTextController.text;
    request.fields['_method']='PUT';
    request.headers[HttpHeaders.authorizationHeader] = 'Bearer ${ctrl.token}';
    request.headers[HttpHeaders.acceptHeader] = 'application/json';
    request.headers[HttpHeaders.contentTypeHeader]='multipart/form-data; boundary=<calculated when request is sent>';
    request.headers[HttpHeaders.acceptEncodingHeader]='gzip, deflate, br';
    var response = await request.send();
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Profile image updated successfully!',
            // AppLocalizations.of(context).translate('upload'),
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          padding: EdgeInsets.only(bottom: 10),
        ),
      );
      Get.back();
    } else
      print(response.statusCode);
    print(response.statusCode);

    // FormData formdata = new FormData(body);
    // formdata.files.add("photos",UploadFileInfo)
    // var response = await myDio.Dio().put(
    //   url,
    //   data: body,
    //   options: myDio.Options(
    //     followRedirects: false,
    //     validateStatus: (status) {
    //       return status < 500;
    //     },
    //     headers: {
    //       HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}',
    //       'Accept': 'application/json'
    //     },
    //   ),
    // );
    // http.Response response = await http.MultipartRequest();
    // var response = GetConnect().put(url, body);
    // print(response.statusCode);
    // print(response.body);
    // print(response.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        // brightness: Brightness.dark,
        brightness: Theme.of(context).brightness,
        // backgroundColor: Colors.transparent,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            size: 35.0,
          ),
          // color: Colors.white,
          color: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(
                Icons.check,
                size: 35.0,
              ),
              // color: Colors.blueAccent,
              color: Theme.of(context).accentColor,
              onPressed: () async {
                await updateProfileInfo();
                // Navigator.pop(context);
              },
            ),
          ),
        ],
        title: Text(
          // 'Edit Profile',
          AppLocalizations.of(context).translate("editProfile"),
          style: TextStyle(
            // color: Colors.white,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 45.0,
                    // backgroundImage: AssetImage('images/greg.jpg'),
                    backgroundImage: CachedNetworkImageProvider(
                        'http://192.168.1.2:8000/${ctrl.currentUserProfile.imageUrl}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        // print(firstNameTextController.text);
                        changeImage();
                      },
                      child: Text(
                        // 'Change Profile Image',
                        AppLocalizations.of(context).translate("changeImage"),
                        style: TextStyle(
                          // color: Colors.blueAccent,
                          color: Theme.of(context).accentColor,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ]),

            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children:[Text('hello',style: TextStyle(color: Colors.white,fontSize: 50.0),),],
            // )
          ),
          Container(
            child: Expanded(
              child: ListView(children: [
                ProfileTextField(
                  labelText:
                      AppLocalizations.of(context).translate("firstName"),
                  controller: firstNameTextController,
                  // labelText: 'First Name',
                ),
                ProfileTextField(
                  labelText: AppLocalizations.of(context).translate("lastName"),
                  controller: lastNameTextController,
                  // labelText: 'Last Name',
                ),
                ProfileTextField(
                  labelText: AppLocalizations.of(context).translate("address"),
                  controller: addressTextController,
                  // controller: ,
                  // labelText: 'Username',
                ),
                ProfileTextField(
                  labelText: AppLocalizations.of(context).translate("bio"),
                  controller: bioTextController,
                  maxLines: null,
                  keyboard: TextInputType.multiline,
                  // labelText: 'Bio',
                ),
                // SizedBox(height: 5.0,),
                // Container(
                //   width: double.infinity,
                //   // padding: EdgeInsets.symmetric(vertical: 10.0),
                //   decoration: BoxDecoration(
                //     border: Border(bottom: BorderSide(color: Colors.blueGrey),top: BorderSide(color: Colors.blueGrey),),
                //   ),
                //   child: TextButton(
                //     style: ButtonStyle(
                //       alignment: Alignment.center,
                //     ),
                //     onPressed: () {},
                //     child: Text(
                //       'Change Password',
                //       style: TextStyle(color: Colors.blueAccent, fontSize: 17.0),
                //     ),
                //   ),
                // ),
                // ProfileTextField(
                //   // labelText: 'E-mail',
                //   labelText: AppLocalizations.of(context).translate("email"),
                // ),
                ProfileTextField(
                  labelText: AppLocalizations.of(context).translate("phone"),
                  controller: phoneTextController,
                  keyboard: TextInputType.phone,
                  // labelText: 'Phone',
                ),
                ProfileTextField(
                  labelText: AppLocalizations.of(context).translate("gender"),
                  controller: genderTextController,
                  // keyboard: ,
                  // labelText: 'Gender',
                ),
                ProfileTextField(
                  // labelText: 'Birthday',
                  labelText: AppLocalizations.of(context).translate("birthday"),
                  controller: birthDateTextController,
                  keyboard: TextInputType.datetime,
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final maxLines;
  final TextInputType keyboard;

  ProfileTextField({this.labelText, this.controller,this.maxLines=1,this.keyboard=TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.blueGrey)),
      ),
      child: TextField(
        // onChanged: (value){print(value);},
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 14.0,
            color: Colors.blueGrey,
          ),
          border: InputBorder.none,
        ),
        maxLines: maxLines,
        keyboardType: keyboard,
      ),
    );
  }
}
