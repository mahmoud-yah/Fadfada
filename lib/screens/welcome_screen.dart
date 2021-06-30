import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_app/screens/login.dart';
import 'package:intro_app/screens/register.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        // height: 550,
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('images/5.jpg'),
        )),
        child: Column(
          children: [
            Container(
              // color: Colors.blueAccent,
              decoration: BoxDecoration(
                // color: Color(0xFF833AC7).withOpacity(0.8),
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                ),
              ),
              padding: EdgeInsets.all(15.0),
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.15),
              child: Text(
                '',
                style: TextStyle(fontSize: 35.0, color: Colors.white),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.56),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Log in',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFF833AC7),
                      elevation: 4.0,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Register(),));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF833AC7).withOpacity(0.85),
                        elevation: 4.0),
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
