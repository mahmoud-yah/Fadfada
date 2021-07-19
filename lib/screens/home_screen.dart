import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_app/app_localizations.dart';
import 'package:intro_app/config/controller.dart';
// import 'package:intro_app/data/data.dart';
import 'package:intro_app/models/normal_post.dart';
// import 'package:intro_app/models/post_model.dart';
import 'package:intro_app/screens/create_post.dart';

// import 'package:intro_app/widgets/favorite_contacts.dart';
import 'package:intro_app/widgets/widgets.dart';
import 'package:intro_app/widgets/storiesv2.dart';

// import 'package:stacked_themes/stacked_themes.dart';

import 'package:http/http.dart' as http;
import 'package:draggable_fab/draggable_fab.dart';


class HomeScreen extends StatefulWidget {
  final List<Post> posts;

  HomeScreen({this.posts});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getData = getPosts();
    super.initState();
  }

  final Controller ctrl = Get.find();

  Future<String> getData;

  refreshData() {
    setState(() {
      getData = getPosts();
    });
  }

  Future<String> getPosts() async {
    ctrl.posts.clear();
    // ctrl.posts
    var url = Uri.parse('http://10.0.2.2:8000/api/posts');
    http.Response response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${ctrl.token}'});
    var data = jsonDecode(response.body);

    var dataHolder = data['data'];
    // print(dataHolder[0]['text']);
    for (var i = 0; i < dataHolder.length; i++) {
      Post post = Post(
        postID: dataHolder[i]['id'],
        userID: dataHolder[i]['user_id'],
        caption: dataHolder[i]['text'],
        timeAgo: dataHolder[i]['created_at'],
        imageUrl: dataHolder[i]['image'],
        likes: dataHolder[i]['like_number'],
        name: dataHolder[i]['name'],
        firstName: dataHolder[i]['first_name'],
        lastName: dataHolder[i]['second_name'],
        isLiked: false,
      );
      ctrl.addPost(post);
      // print(data['data'][i]['text']);
    }
    ctrl.posts = List.from(ctrl.posts.reversed);
    print(ctrl.posts.length);
    return 'ok';
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
      appBar:
      AppBar(

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
      ),
      body: FutureBuilder(
        future: getData,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: const CircularProgressIndicator());

          if (snapshot.hasData)
            // return Text('${snapshot.data}');
            // if(snapshot.data=='success'){
            return Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.01),
              child: RefreshIndicator(
                onRefresh: () async {
                  // print('refreshed');
                  setState(() {
                    refreshData();
                  });
                  return null;
                },
                child: ListView.builder(
                  // shrinkWrap: true,

                  itemBuilder: (BuildContext context, int index) {
                    final Post post = ctrl.posts[index];
                    return PostContainer(post: post);
                  },
                  itemCount: ctrl.posts.length,
                ),
              ),
            );
          else {
            print(snapshot.error);
            return const Text('Some error happened');
          }
        },
      ),

      // CustomScrollView(
      //   slivers: [
      // SliverAppBar(
      //   pinned: true,
      //   iconTheme: IconThemeData(color: Theme.of(context).accentColor),
      //   brightness: Theme.of(context).brightness,
      //   backgroundColor: Theme.of(context).backgroundColor,
      //   title: Text(
      //     AppLocalizations.of(context).translate('logo'),
      //     // 'fadfada',
      //     style: TextStyle(
      //       // color: Palette.facebookBlue,
      //       color: Theme.of(context).accentColor,
      //       fontSize: 28.0,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           homeScaffoldKey.currentState.openEndDrawer();
      //         },
      //         icon: Icon(
      //           Icons.camera,
      //           color: Theme.of(context).accentColor,
      //           size: 30,
      //         ))
      //   ],
      //   leadingWidth: 0,
      //   leading: Container(),
      //   floating: true,
      //   // actions: [IconButton(onPressed: ()=>Scaffold.of(context).openEndDrawer(), icon: Icon(Icons.ac_unit))],
      //   // actions: [
      //   //   // Container(
      //   //   //   margin: EdgeInsets.all(6.0),
      //   //   //   decoration: BoxDecoration(
      //   //   //     color: Color(0xFF4E4F50),
      //   //   //     shape: BoxShape.circle,
      //   //   //   ),
      //   //   //   child: IconButton(
      //   //   //       icon: Icon(
      //   //   //         Icons.search,
      //   //   //         size: 28.0,
      //   //   //         color: Colors.white,
      //   //   //       ),
      //   //   //       onPressed: () {}),
      //   //   // )
      //   //
      //   //   Icon(
      //   //     Icons.search,
      //   //     size: 30.0,
      //   //     color: Colors.white,
      //   //   ),
      //   // ],
      // ),
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
      //   SliverList(
      //     delegate: SliverChildBuilderDelegate((context, index) {
      //       final Post post = ctrl.posts[index];
      //       return PostContainer(post: post);
      //     }, childCount: ctrl.posts.length),
      //   )
      // ],

      floatingActionButton: DraggableFab(
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).accentColor,
          // elevation: 0,
          onPressed: () async{
            // setState(() {
            //   getThemeManager(context).selectThemeAtIndex(0
            //   );
            // });
            await Get.to(() => CreatePost());
            refreshData();
          },
          // child: Text('Post',style: TextStyle(color: Colors.white),),
          child: Icon(
            Icons.create,
            size: 25.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
