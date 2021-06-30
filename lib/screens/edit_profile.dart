import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_app/app_localizations.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            size: 35.0,
          ),
          color: Colors.white,
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
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
        title: Text(
          // 'Edit Profile',
          AppLocalizations.of(context).translate("editProfile"),
          style: TextStyle(color: Colors.white),
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
                        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      // 'Change Profile Image',
                      AppLocalizations.of(context).translate("changeImage"),
                      style:
                          TextStyle(color: Colors.blueAccent, fontSize: 20.0),
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
                  // labelText: 'First Name',
                ),
                ProfileTextField(
                  labelText: AppLocalizations.of(context).translate("lastName"),
                  // labelText: 'Last Name',
                ),
                ProfileTextField(
                  labelText: AppLocalizations.of(context).translate("username"),
                  // labelText: 'Username',
                ),
                ProfileTextField(
                  labelText: AppLocalizations.of(context).translate("bio"),
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
                ProfileTextField(
                  // labelText: 'E-mail',
                  labelText: AppLocalizations.of(context).translate("email"),
                ),
                ProfileTextField(
                  labelText: AppLocalizations.of(context).translate("phone"),
                  // labelText: 'Phone',
                ),
                ProfileTextField(
                  labelText: AppLocalizations.of(context).translate("gender"),
                  // labelText: 'Gender',
                ),
                ProfileTextField(
                  // labelText: 'Birthday',
                  labelText: AppLocalizations.of(context).translate("birthday"),
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

  ProfileTextField({this.labelText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.blueGrey)),
      ),
      child: TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 14.0,
            color: Colors.blueGrey,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
