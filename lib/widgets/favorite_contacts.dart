import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_app/models/message_model.dart';
import 'package:intro_app/screens/chat_screen.dart';

class FavoriteContacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Expanded(
    //   child: Container(
    //     decoration: BoxDecoration(
    //       color: Theme.of(context).accentColor,
    //       borderRadius: BorderRadius.only(
    //         topRight: Radius.circular(30),
    //         topLeft: Radius.circular(30),
    //       ),
    //     ),
    //     child: Column(
    //       children: <Widget>[
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: <Widget>[
    //             Text(
    //               'Favorite Contacts',
    //               style: TextStyle(
    //                 color: Colors.blueGrey,
    //                 fontSize: 18.0,
    //                 fontWeight: FontWeight.bold,
    //                 letterSpacing: 1.0,
    //               ),
    //             ),
    //             IconButton(
    //               icon: Icon(Icons.more_horiz),
    //               iconSize: 30.0,
    //               color: Colors.blueGrey,
    //               onPressed: () {},
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Favorite Contacts',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.more_horiz),
                  iconSize: 30.0,
                  color: Colors.blueGrey,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Container(
            height: 120.0,
            // color: Colors.blue,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 10.0),
              itemCount: favorites.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        user: favorites[index],
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 35.0,
                          backgroundImage: AssetImage(favorites[index].imageUrl),
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
