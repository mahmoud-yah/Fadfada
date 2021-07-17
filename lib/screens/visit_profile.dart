// import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_app/app_localizations.dart';
import 'package:intro_app/config/controller.dart';
import 'package:intro_app/models/profile_model.dart';
import 'package:intro_app/screens/Privacy.dart';
import 'package:intro_app/screens/about.dart';
import 'package:intro_app/screens/help.dart';
import 'package:intro_app/screens/login.dart';
import 'package:intro_app/screens/saved.dart';
import 'package:intro_app/screens/settings.dart';
import 'package:intro_app/screens/tovisit_posts_data.dart';
import 'package:http/http.dart' as http;

// import 'package:intro_app/data/data.dart';
// import 'package:intro_app/models/models.dart';
// import 'package:intro_app/widgets/post_container.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:intro_app/screens/profile_posts.dart';
import 'edit_profile.dart';

class VisitProfile extends StatefulWidget {
  final String userID;

  VisitProfile({@required this.userID});

  @override
  _VisitProfileState createState() => _VisitProfileState();
}

class _VisitProfileState extends State<VisitProfile> {
  @override
  void initState() {
    getData = getProfile();
    super.initState();
  }

  Future<String> getData;
  final panelController = PanelController();

  final Controller ctrl = Get.find();

  final UserProfile profile = UserProfile();

  refreshData() {
    setState(() {
      getData = getProfile();
    });
  }

  Future<String> getProfile() async {
    var url = Uri.parse('http://10.0.2.2:8000/api/profile/' + widget.userID);
    http.Response response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}'});
    var data = jsonDecode(response.body);
    var dataHolder = data['data'];
    profile.setInfo(
      userID: dataHolder['user_id'].toString(),
      firstName: dataHolder['first_name'],
      lastName: dataHolder['second_name'],
      imageUrl: dataHolder['image'],
      address: dataHolder['address'],
      gender: dataHolder['gender'],
      phone: dataHolder['phone'],
      bio: dataHolder['bio'],
      birthDate: dataHolder['date_of_birth'],
    );
    print(dataHolder);
    return 'ok';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0,
        backgroundColor: Colors.transparent,
        // actions: [
        //   IconButton(
        //     // Icons.menu,
        //     icon: Icon(
        //       Icons.menu,
        //       size: 25,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      endDrawer: Drawer(
        // elevation: 10.0,
        child: Container(
          // color: Colors.black,
          color: Theme.of(context).backgroundColor,
          // margin: EdgeInsets.only(top: 25.0),
          // padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.066),
          child: SafeArea(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.edit_outlined,
                    // color: Colors.white,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    // 'Edit Profile',
                    AppLocalizations.of(context).translate("editProfile"),
                    style: TextStyle(
                      // color: Colors.white,
                      color: Theme.of(context).primaryColor,
                      fontSize: 18.0,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfile(
                                profile: profile,
                              )),
                    );
                  },
                  hoverColor: Colors.grey,
                  focusColor: Colors.grey,
                  selectedTileColor: Colors.grey,
                  enabled: true,

                  // tileColor: Colors.grey,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Saved()));
                  },
                  child: ListTile(
                    leading: Icon(Icons.bookmarks,
                        // color: Colors.white,
                        color: Theme.of(context).primaryColor),
                    title: Text(
                      // 'Saved',
                      AppLocalizations.of(context).translate("saved"),
                      style: TextStyle(
                        // color: Colors.white,
                        color: Theme.of(context).primaryColor,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings()));
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.settings,
                      // color: Colors.white,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      // 'Settings',
                      AppLocalizations.of(context).translate("settings"),
                      style: TextStyle(
                        // color: Colors.white,
                        color: Theme.of(context).primaryColor,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Privacy()));
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.privacy_tip_outlined,
                      // color: Colors.white,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      // 'Privacy',
                      AppLocalizations.of(context).translate("privacy"),
                      style: TextStyle(
                        // color: Colors.white,
                        color: Theme.of(context).primaryColor,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Help()));
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.help_outline,
                      // color: Colors.white,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      // 'Help',
                      AppLocalizations.of(context).translate("help"),
                      style: TextStyle(
                        // color: Colors.white,
                        color: Theme.of(context).primaryColor,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => About()));
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.contact_page_outlined,
                        // color: Colors.white,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        // 'About',
                        AppLocalizations.of(context).translate("about"),
                        style: TextStyle(
                          // color: Colors.white,
                          color: Theme.of(context).primaryColor,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ctrl.logout();
                    Get.off(() => Login());
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.logout,
                      // color: Colors.white,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      // 'Logout',
                      AppLocalizations.of(context).translate("logout"),
                      style: TextStyle(
                        // color: Colors.white,
                        color: Theme.of(context).primaryColor,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: getData,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: const CircularProgressIndicator());

          if (snapshot.hasData)
            // return Text('${snapshot.data}');
            // if(snapshot.data=='success'){
            return SlidingUpPanel(
              maxHeight: 400,
              minHeight: 150,
              color: Colors.transparent,
              parallaxEnabled: true,
              // parallaxOffset: 0.5,
              controller: panelController,
              body: Image(
                  image: AssetImage('images/David.jpg'),
                  fit: BoxFit.cover,
                ),
              panelBuilder: (ScrollController scroll) {
                return Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                '17',
                                style: TextStyle(
                                  // color: Colors.white,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                // 'Posts',
                                AppLocalizations.of(context)
                                    .translate("posts"),
                                style: TextStyle(
                                  // color: Colors.white,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '1473',
                                style: TextStyle(
                                  // color: Colors.white,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                // 'Followers',
                                AppLocalizations.of(context)
                                    .translate("followers"),
                                style: TextStyle(
                                  // color: Colors.white,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          // Column(
                          //   children: [
                          //     Text(
                          //       '203',
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 15.0,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       height: 4,
                          //     ),
                          //     Text(
                          //       'Following',
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 15.0,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0),
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        // 'David Brooks',
                                        '${profile.firstName} ' +
                                            '${profile.lastName}',
                                        style: TextStyle(
                                          // color: Colors.white,
                                          color:
                                              Theme.of(context).primaryColor,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6.0,
                                      ),
                                      Text(
                                        profile.address,
                                        // 'Damascus, SY',
                                        style: TextStyle(
                                          // color: Colors.white,
                                          color:
                                              Theme.of(context).primaryColor,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditProfile(
                                                  profile: profile,
                                                )),
                                      );
                                    },
                                    child: Text(
                                      // 'Edit Profile',
                                      AppLocalizations.of(context)
                                          .translate("editProfile"),
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                        // primary: Colors.blueAccent,
                                        primary:
                                            Theme.of(context).accentColor,
                                        side: BorderSide(
                                          // color: Colors.blueAccent,
                                          color:
                                              Theme.of(context).accentColor,
                                          width: 0.4,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 24.0, left: 24.0, bottom: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    profile.bio,
                                    // 'Syrian..\nIT ●Arab International University●\nOld enough to know better 😶\n"Where\'s your will to be weird?" - Jim Morrison   Syrian..\nIT ●Arab International University●\nOld enough to know better 😶\n"Where\'s your will to be weird?" - Jim MorrisonSyrian..\nIT ●Arab International University●\nOld enough to know better 😶\n"Where\'s your will to be weird?" - Jim MorrisonSyrian..\nIT ●Arab International University●\nOld enough to know better 😶\n"Where\'s your will to be weird?" - Jim MorrisonSyrian..\nIT ●Arab International University●\nOld enough to know better 😶\n"Where\'s your will to be weird?" - Jim Morrison',
                                    // 'Syrian..\n19 Years old\nAIU Arab International University\Love Music, Art, Swimming, and rkoob al5el',
                                    // 'Syrian..\n18 Years old\nAIU Arab International University\nLove Music, Art, Swimming, and rkoob al5el\nOld enough to know better 😶\nEvery day brings an opportunity to do something legendary.\n"Where\'s your will to be weird?" - Jim Morrison',

                                    style: TextStyle(
                                      // color: Colors.white,
                                      color: Theme.of(context).primaryColor,
                                      letterSpacing: 0.5,
                                      fontSize: 14.5,
                                      height: 1.25,
                                      // fontWeight: FontWeight.w400,
                                      // textBaseline: TextBaseline.ideographic,
                                    ),
                                    maxLines: 8,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => ProfilePosts(),
                                        //   ),
                                        // );
                                        Get.to(() => ProfilePosts(
                                              userID: widget.userID,
                                            ));
                                      },
                                      child: Text(
                                        // 'User posts',
                                        AppLocalizations.of(context)
                                            .translate("userPosts"),
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary:
                                              Theme.of(context).accentColor,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(28.0),
                                          ),
                                          padding: EdgeInsets.all(10.0)),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          // }
          // else return Center();
          else
            return const Text('Some error happened');
        },
      ),
    );
  }
}
