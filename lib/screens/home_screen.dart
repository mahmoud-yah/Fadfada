import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_app/app_localizations.dart';
import 'package:intro_app/data/data.dart';
import 'package:intro_app/models/post_model.dart';
import 'package:intro_app/screens/create_post.dart';
// import 'package:intro_app/widgets/favorite_contacts.dart';
import 'package:intro_app/widgets/widgets.dart';
import 'package:intro_app/widgets/storiesv2.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: Color(0xFF242526),
      // backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            brightness: Brightness.dark,
            backgroundColor: Colors.black,
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
            leadingWidth: 0,
            leading: Container(),
            floating: true,
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
              final Post post = posts[index];
              return PostContainer(post: post);
            }, childCount: posts.length),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        // elevation: 0,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePost()),
          );
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
