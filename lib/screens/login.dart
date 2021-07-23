import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_app/config/controller.dart';
import 'package:intro_app/models/normal_post.dart';

// import 'package:intro_app/screens/nav_screen.dart';
// import 'file:///C:/Users/m-y-6/StudioProjects/intro_app/lib/screens/register.dart';
// import '../textField.dart';
import 'package:intro_app/textField.dart';

// import 'register.dart';
import 'package:intro_app/screens/screens.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }
  final ctrl = Get.put(Controller());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool inProgress = false;

  // Controller ctrl = Get.find();

  // var url = Uri.parse('http://10.0.2.2:8000/api/login');
  var url = Uri.parse('http://192.168.1.2:8000/api/login');
  Future getData(email, password) async {
    setState(() {
      inProgress = true;
    });
    print('hello');
    http.Response response = await http
        .post(url, body: {'email': '$email', 'password': '$password'});
    // print(response.body);
    var token = jsonDecode(response.body)['data']['token'];
    ctrl.setTokenValue(token);
    // print('ok');
    if (jsonDecode(response.body)['success'] == true) {
      // await getPosts();
      await getProfile();
      setState(() {
        inProgress = false;
      });
      Get.to(() => NavScreen());
    }
  }

  // Future getPosts() async {
  //   var url = Uri.parse('http://10.0.2.2:8000/api/posts');
  //   http.Response response = await http.get(url,
  //       headers: {HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}'});
  //   var data = jsonDecode(response.body);
  //
  //   var dataHolder = data['data'];
  //   // print(dataHolder[0]['text']);
  //   for (var i = 0; i < dataHolder.length; i++) {
  //     Post post = Post(
  //       postID: dataHolder[i]['id'],
  //       userID: dataHolder[i]['user_id'],
  //       caption: dataHolder[i]['text'],
  //       timeAgo: dataHolder[i]['created_at'],
  //       imageUrl: dataHolder[i]['image'],
  //       likes: dataHolder[i]['like_number'],
  //       commentsNumber: dataHolder[i]['comment_number'].toString(),
  //       name: dataHolder[i]['name'],
  //       firstName: dataHolder[i]['first_name'],
  //       lastName: dataHolder[i]['second_name'],
  //       isLiked:false,
  //     );
  //     ctrl.addPost(post);
  //     // print(data['data'][i]['text']);
  //   }
  //   print(ctrl.posts.length);
  // }

  Future getProfile() async {
    // var url = Uri.parse('http://10.0.2.2:8000/api/profile');
    var url = Uri.parse('http://192.168.1.2:8000/api/profile');
    http.Response response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}'});
    var data = jsonDecode(response.body);
    var dataHolder = data['data'];
    ctrl.addProfileInfo(
        dataHolder['user_id'].toString(),
        dataHolder['first_name'],
        dataHolder['second_name'],
        dataHolder['image'],
        dataHolder['address'],
        dataHolder['gender'],
        dataHolder['phone'],
        dataHolder['bio'],
        dataHolder['date_of_birth']);
    print(ctrl.currentUserProfile.userID);
  }

  @override
  Widget build(BuildContext context) {
    return inProgress
        ? Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            // appBar: AppBar(backgroundColor: Theme.of(context).primaryColor,),
            // backgroundColor: Theme.of(context).primaryColor,
            // backgroundColor: Color(0xFF312F54),
            backgroundColor: Theme.of(context).backgroundColor,
            // appBar: AppBar(),
            body: SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 60.0),
                    height: MediaQuery.of(context).size.height * 0.33,
                    child: Stack(
                      children: [
                        Positioned(
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('images/3.png'),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0, left: 20.0),
                          child: Text(
                            'Hello there,',
                            style:
                                TextStyle(fontSize: 30.0, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'welcome back',
                            style:
                                TextStyle(fontSize: 30.0, color: Colors.white),
                          ),
                        ),
                        //       SizedBox(
                        //         height: 20.0,
                        //       ),
                        Container(
                          padding: EdgeInsets.only(
                              bottom: 20.0, left: 20.0, right: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Container(
                              //   // padding: EdgeInsets.all(8.0),
                              //   decoration: BoxDecoration(
                              //     border:
                              //         Border(bottom: BorderSide(color: Colors.grey)),
                              //   ),
                              //   child: TextField(
                              //     style: TextStyle(color: Colors.white),
                              //     decoration: InputDecoration(
                              //       hintText: 'E-mail',
                              //       hintStyle: TextStyle(color: Colors.blueGrey),
                              //       border: InputBorder.none,
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 10.0,
                              // ),
                              // Container(
                              //   decoration: BoxDecoration(
                              //     border: Border(
                              //         bottom: BorderSide(color: Colors.blueGrey)),
                              //   ),
                              //   child: TextField(
                              //     style: TextStyle(color: Colors.white),
                              //     decoration: InputDecoration(
                              //       hintText: 'Password',
                              //       hintStyle: TextStyle(color: Colors.grey),
                              //       border: InputBorder.none,
                              //     ),
                              //   ),
                              // ),
                              // MyTextField(
                              //   hintText: 'E-mail',
                              //   isPassword: false,
                              // ),
                              // MyTextField(
                              //   hintText: 'Password',
                              //   isPassword: true,
                              // ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.blueGrey)),
                                ),
                                child: TextField(
                                  controller: emailController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                      color: Colors.blueGrey,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.blueGrey)),
                                ),
                                child: TextField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                      color: Colors.blueGrey,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //   obscureText: true,
                        // ),
                      ],
                    ),
                  ),

                  // SizedBox(height: 25.0),
                  GestureDetector(
                    child: Text(
                      'Forgot your password?',
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white30,
                          decoration: TextDecoration.underline),
                    ),
                    onTap: () {
                      print('Hello');
                    },
                  ),
                  SizedBox(height: 25.0),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => NavScreen(),
                            //   ),
                            // );
                            getData(
                                emailController.text, passwordController.text);
                            // Get.to(()=>NavScreen());
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Text(
                              'Sign In',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                          style: TextButton.styleFrom(
                              primary: Colors.white,
                              // backgroundColor: Color(0xFF833AC7),
                              backgroundColor: Theme.of(context).accentColor,
                              elevation: 4.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'New here?',
                        style: TextStyle(fontSize: 15.0, color: Colors.white30),
                      ),
                      SizedBox(width: 5.0),
                      GestureDetector(
                        child: Text(
                          'Sign Up instead',
                          style: TextStyle(
                              fontSize: 15.0,
                              decoration: TextDecoration.underline,
                              color: Colors.white30),
                        ),
                        onTap: () {
                          // Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
