import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_app/app_localizations.dart';
import 'package:intro_app/config/controller.dart';
import 'package:intro_app/data/data.dart';
import 'package:intro_app/models/normal_post.dart';
import 'package:intro_app/models/post_model.dart';
import 'package:intro_app/screens/create_post.dart';

// import 'package:intro_app/widgets/favorite_contacts.dart';
import 'package:intro_app/widgets/widgets.dart';
import 'package:intro_app/widgets/storiesv2.dart';

// import 'package:stacked_themes/stacked_themes.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  // void initState() async{
  //   // TODO: implement initState
  //   super.initState();
  // await getPosts();
  // }

  final Controller ctrl = Get.find();

  Future getPosts() async {
    var url = Uri.parse('http://10.0.2.2:8000/api/posts');
    http.Response response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}'});
    var data = jsonDecode(response.body);

    var dataHolder = data['data'];
    // print(dataHolder[0]['text']);
    for (var i = 0; i < dataHolder.length; i++) {
      Post post = Post(
        userID: dataHolder[i]['id'],
        caption: dataHolder[i]['text'],
        timeAgo: dataHolder[i]['created_at'],
        imageUrl: dataHolder[i]['image'],
        likes: dataHolder[i]['like_number'],
        name: dataHolder[i]['name'],
      );
      ctrl.addPost(post);
      // print(data['data'][i]['text']);
    }
    print(ctrl.posts.length);
  }

  GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: true,
      key: homeScaffoldKey,
      endDrawer: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        child: Drawer(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              color: Colors.white,
              child: StoriesTest(),
            ),
          ),
        ),
      ),
      // backgroundColor: Color(0xFF242526),
      // backgroundColor: Colors.black,
      backgroundColor: Theme.of(context).backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(color: Theme.of(context).accentColor),
            brightness: Theme.of(context).brightness,
            backgroundColor: Theme.of(context).backgroundColor,
            title: Text(
              AppLocalizations.of(context).translate('logo'),
              // 'fadfada',
              style: TextStyle(
                // color: Palette.facebookBlue,
                color: Theme.of(context).accentColor,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    homeScaffoldKey.currentState.openEndDrawer();
                  },
                  icon: Icon(
                    Icons.camera,
                    color: Theme.of(context).accentColor,
                    size: 30,
                  ))
            ],
            leadingWidth: 0,
            leading: Container(),
            floating: true,
            // actions: [IconButton(onPressed: ()=>Scaffold.of(context).openEndDrawer(), icon: Icon(Icons.ac_unit))],
            // actions: [
            //   // Container(
            //   //   margin: EdgeInsets.all(6.0),
            //   //   decoration: BoxDecoration(
            //   //     color: Color(0xFF4E4F50),
            //   //     shape: BoxShape.circle,
            //   //   ),
            //   //   child: IconButton(
            //   //       icon: Icon(
            //   //         Icons.search,
            //   //         size: 28.0,
            //   //         color: Colors.white,
            //   //       ),
            //   //       onPressed: () {}),
            //   // )
            //
            //   Icon(
            //     Icons.search,
            //     size: 30.0,
            //     color: Colors.white,
            //   ),
            // ],
          ),
          // SliverToBoxAdapter(
          //   child: CreatePostContainer(
          //     currentUser: currentUser,
          //   ),
          // ),
          // SliverPadding(
          //   padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
          //   sliver: SliverToBoxAdapter(
          //     child: Rooms(onlineUsers: onlineUsers),
          //   ),
          // ),
          // SliverPadding(
          //   padding: EdgeInsets.fromLTRB(0, 0.5, 0, 0),
          //   sliver: SliverToBoxAdapter(
          //     child: StoriesTest(),
          //     // Stories(
          //     //   currentUser: currentUser,
          //     //   stories: stories,
          //     // ),
          //   ),
          // ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final Post post = ctrl.posts[index];
              return PostContainer(post: post);
            }, childCount: ctrl.posts.length),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        // elevation: 0,
        onPressed: () {
          // setState(() {
          //   getThemeManager(context).selectThemeAtIndex(0
          //   );
          // });
          // getPosts();
          // print(ctrl.count);
          // print(ctrl.token);
          Get.to(() => CreatePost());

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => CreatePost()),
          // );
        },
        // child: Text('Post',style: TextStyle(color: Colors.white),),
        child: Icon(
          Icons.create,
          size: 25.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
