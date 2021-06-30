import 'package:flutter/material.dart';
import 'package:intro_app/app_localizations.dart';
import 'package:intro_app/models/message_model.dart';
// import 'package:intro_app/screens/chat_screen.dart';
// import 'package:intro_app/screens/profilev3.dart';

class StoriesTest extends StatelessWidget {
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Text(
                AppLocalizations.of(context).translate("stories"),
                // 'Stories',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              // height: double.infinity,
              color: Colors.black,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                // padding: EdgeInsets.only(left: 10.0),
                itemCount: favorites.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 35.0,
                          backgroundColor: Colors.blue,
                          // backgroundColor: Color(ColorTween(begin: Colors.blue,end: Colors.red)),
                          child: CircleAvatar(
                            radius: 32.5,
                            backgroundImage:
                                AssetImage(favorites[index].imageUrl),
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          favorites[index].name,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.blueGrey),
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
