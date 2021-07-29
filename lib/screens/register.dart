import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_app/config/controller.dart';
import 'package:intro_app/models/normal_post.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'login.dart';
// import 'package:intro_app/screens/login.dart';
// import '../textField.dart';
import 'screens.dart';

// import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _auth = FirebaseAuth.instance;
  Controller ctrl = Get.find();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  bool inProgress = false;

  // var url = Uri.parse('http://10.0.2.2:8000/api/register');
  var url = Uri.parse('http://192.168.1.2:8000/api/register');

  Future getData(name, email, password, cPassword) async {
    setState(() {
      inProgress = true;
    });
    print('hello');
    http.Response response = await http.post(url, body: {
      'name': '$name',
      'email': '$email',
      'password': '$password',
      'c_password': '$cPassword'
    });
    // print(response.body);
    var token = jsonDecode(response.body)['data']['token'];
    ctrl.setTokenValue(token);
    print(token);
    if (jsonDecode(response.body)['success'] == true) {
      await getPosts();
      getProfile();
      // setState(() {
      //   inProgress = false;
      // });
      Get.off(() => NavScreen());
    }
  }

  Future getProfile() async {
    // var url = Uri.parse('http://10.0.2.2:8000/api/profile');
    var url = Uri.parse('http://192.168.1.2:8000/api/profile');
    http.Response response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}'});
    var data = jsonDecode(response.body);
    var dataHolder = data['data'];
    ctrl.addProfileInfo(
        dataHolder['id'].toString(),
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

  Future getPosts() async {
    // var url = Uri.parse('http://10.0.2.2:8000/api/posts');
    var url = Uri.parse('http://192.168.1.2:8000/api/posts');
    http.Response response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}'});
    var data = jsonDecode(response.body);

    var dataHolder = data['data'];
    // print(dataHolder[0]['text']);
    for (var i = 0; i < dataHolder.length; i++) {
      Post post = Post(
        userID: dataHolder[i]['user_id'],
        postID: dataHolder[i]['id'],
        caption: dataHolder[i]['text'],
        timeAgo: dataHolder[i]['created_at'],
        imageUrl: dataHolder[i]['image'],
        likes: dataHolder[i]['like_number'],
        firstName: dataHolder[i]['first_name'],
        lastName: dataHolder[i]['second_name'],
        commentsNumber: dataHolder[i]['comment_number'].toString(),
        imageProfile: dataHolder[i]['image_profile'],
        isLiked: false,
      );

      ctrl.addPost(post);
      // print(data['data'][i]['text']);
    }
    print(ctrl.posts.length);
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
            // backgroundColor: Theme.of(context).primaryColor,
            // backgroundColor: Color(0xFF312F54),
            backgroundColor: Theme.of(context).backgroundColor,
            // backgroundColor: Colors.yellowAccent,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.33,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage('images/3.png'),
                      ),
                    ),
                    // child: Container(
                    //   decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //       fit: BoxFit.fill,
                    //       image: AssetImage('images/3.jpg'),
                    //     ),
                    //   ),
                    // ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 20.0),
                    child: Text(
                      'Get on board!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: [
                        // Container(
                        //   padding: EdgeInsets.all(10.0),
                        //   decoration: BoxDecoration(
                        //     border: Border(bottom: BorderSide(color: Colors.blueGrey)),
                        //   ),
                        //   child: TextField(
                        //     decoration: InputDecoration(
                        //       hintText: 'Name',
                        //       hintStyle: TextStyle(color: Colors.blueGrey),
                        //       border: InputBorder.none,
                        //       // icon: Icon(Icons.email_outlined,color: Colors.blueGrey,),
                        //     ),
                        //   ),
                        // ),
                        // Container(
                        //   padding: EdgeInsets.all(10.0),
                        //   decoration: BoxDecoration(
                        //     border: Border(bottom: BorderSide(color: Colors.blueGrey)),
                        //   ),
                        //   child: TextField(
                        //     decoration: InputDecoration(
                        //       hintText: 'E-mail',
                        //       hintStyle: TextStyle(
                        //         color: Colors.blueGrey,
                        //       ),
                        //       border: InputBorder.none,
                        //     ),
                        //   ),
                        // ),
                        // MyTextField(
                        //   hintText: 'Name',
                        //   isPassword: false,
                        // ),
                        // MyTextField(
                        //   hintText: 'E-mail',
                        //   isPassword: false,
                        // ),
                        // MyTextField(
                        //   hintText: 'Password',
                        //   isPassword: true,
                        // ),
                        // MyTextField(
                        //   hintText: 'Confirm Password',
                        //   isPassword: true,
                        // ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.blueGrey)),
                          ),
                          child: TextField(
                            controller: nameController,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Name',
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
                                bottom: BorderSide(color: Colors.blueGrey)),
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
                                bottom: BorderSide(color: Colors.blueGrey)),
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
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.blueGrey)),
                          ),
                          child: TextField(
                            controller: cPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(
                                color: Colors.blueGrey,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Text(
                        //     'By creating an account, you agree \n  to our terms, and privacy policy',
                        //     style: TextStyle(color: Colors.white60),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: TextButton(
                            onPressed: () async{
                              print(nameController.text);
                              print(emailController.text);
                              print(passwordController.text);
                              print(cPasswordController.text);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => NavScreen(),
                              //   ),
                              // );

                              getData(
                                  nameController.text,
                                  emailController.text,
                                  passwordController.text,
                                  cPasswordController.text);

                              try{
                                final newUser = await _auth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                              }catch(e){
                                print(e);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                            ),
                            style: TextButton.styleFrom(
                              // backgroundColor: Color(0xFF833AC7),
                              backgroundColor: Theme.of(context).accentColor,
                              elevation: 4.0,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          child: Text(
                            'I am already a member',
                            style: TextStyle(
                              color: Colors.white30,
                              decoration: TextDecoration.underline,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
