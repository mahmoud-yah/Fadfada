import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:intro_app/screens/nav_screen.dart';
// import 'file:///C:/Users/m-y-6/StudioProjects/intro_app/lib/screens/register.dart';
// import '../textField.dart';
import 'package:intro_app/textField.dart';
// import 'register.dart';
import 'package:intro_app/screens/screens.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(backgroundColor: Theme.of(context).primaryColor,),
      // backgroundColor: Theme.of(context).primaryColor,
      backgroundColor: Color(0xFF312F54),
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.0,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('images/3.jpg'),
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
                      style: TextStyle(fontSize: 30.0, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'welcome back',
                      style: TextStyle(fontSize: 30.0, color: Colors.white),
                    ),
                  ),
                  //       SizedBox(
                  //         height: 20.0,
                  //       ),
                  Container(
                    padding:
                        EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
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
                        MyTextField(
                          hintText: 'E-mail',
                          isPassword: false,
                        ),
                        MyTextField(
                          hintText: 'Password',
                          isPassword: true,
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavScreen(),
                        ),
                      );
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
                        backgroundColor: Color(0xFF833AC7),
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Register()),
                    // );
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
