import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'login.dart';
// import 'package:intro_app/screens/login.dart';
import '../textField.dart';
import 'screens.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColor,
      backgroundColor: Color(0xFF312F54),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('images/3.jpg'),
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
              padding: EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
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
                  MyTextField(
                    hintText: 'Name',
                    isPassword: false,
                  ),
                  MyTextField(
                    hintText: 'E-mail',
                    isPassword: false,
                  ),
                  MyTextField(
                    hintText: 'Password',
                    isPassword: true,
                  ),
                  MyTextField(
                    hintText: 'Confirm Password',
                    isPassword: true,
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
                      onPressed: () {
                        Navigator.push(
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
                          'Sign Up',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF833AC7),
                        elevation: 4.0,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
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
