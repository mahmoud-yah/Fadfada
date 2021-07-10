import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_app/data/data.dart';
import 'package:intro_app/models/post_model.dart';
import 'package:intro_app/widgets/widgets.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xFF181818),
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text('Profile'),
        backgroundColor: Colors.black,
        leading: Icon(
          Icons.arrow_back_rounded,
          color: Colors.white,
          size: 35.0,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.menu,
              color: Colors.white,
              size: 35.0,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    // bottomRight: Radius.circular(50.0),
                    // bottomLeft: Radius.circular(50.0),
                    ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 45.0,
                              // backgroundImage: AssetImage('images/greg.jpg'),
                              backgroundImage: CachedNetworkImageProvider('https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80'),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // height: 500.0,
                                  constraints: BoxConstraints(
                                      maxWidth:
                                      MediaQuery.of(context).size.width * 0.5),
                                  // width: MediaQuery.of(context).size.width*0.4,
                                  child: Text(
                                    'David Brooks',
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),

                                Row(
                                  // textDirection: TextDirection.rtl,
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                    Text(
                                      'Damascus, SY',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                )

                              ],
                            ),

                          ],
                        ),


                        Column(
                          children: [
                            Text(
                              '23',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Posts',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        // Column(
                        //   children: [
                        //     Text(
                        //       '1.5M',
                        //       style: TextStyle(
                        //         fontSize: 20.0,
                        //         fontWeight: FontWeight.bold,
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       height: 5.0,
                        //     ),
                        //     Text(
                        //       'Followers',
                        //       style: TextStyle(
                        //         fontSize: 16.0,
                        //         fontWeight: FontWeight.w500,
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Column(
                          children: [
                            Text(
                              '319',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Friends',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              // height: 500.0,
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.5),
                              // width: MediaQuery.of(context).size.width*0.4,
                              child: Text(
                                'David Brooks',
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: 30.0,
                            ),
                            Row(
                              // textDirection: TextDirection.rtl,
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.white,
                                  size: 22,
                                ),
                                Text(
                                  'Damascus, SY',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                          // height: 410,
                          // padding: EdgeInsets.all(6),
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Text(
                            // 'Syrian..\nIT ●Arab International University●\nOld enough to know better 😶\n"Where\'s your will to be weird?" - Jim Morrison',
                             'Syrian..\n17 Years old\nAIU Arab International University\Love Music, Art, Swimming, and rkoob al5el\nOld enough to know better 😶\n"Where\'s your will to be weird?" - Jim Morrison',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 0.5,
                              fontSize: 14.5,
                              height: 1.25,
                              // fontWeight: FontWeight.w400,
                              // textBaseline: TextBaseline.ideographic,
                            ),
                            maxLines: 9,
                          ),
                        )
                      ],
                    ),
                  ),
                  // ListView.builder(
                  //     itemCount: posts.length,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       final Post post = posts[index];
                  //       return PostContainer(post: post);
                  //     }),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              // color: Colors.black87,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    final TestPost post = posts[index];
                    return PostContainer(post: post);
                  }),
              // height: ,
            ),
          ),
          // ListView.builder(
          //     itemCount: posts.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       final Post post = posts[index];
          //       return PostContainer(post: post);
          //     }),
          // SliverList(
          //   delegate: SliverChildBuilderDelegate((context, index) {
          //     final Post post = posts[index];
          //     return PostContainer(post: post);
          //   }, childCount: posts.length),
          // ),
          // CustomScrollView(
          //   slivers: [
          // SliverAppBar(
          //   brightness: Brightness.dark,
          //   backgroundColor: Colors.black,
          //   title: Text(
          //     'fadfada',
          //     style: TextStyle(
          //       // color: Palette.facebookBlue,
          //       color: Theme.of(context).accentColor,
          //       fontSize: 28.0,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          //   floating: true,
          //   actions: [
          //     Container(
          //       margin: EdgeInsets.all(6.0),
          //       decoration: BoxDecoration(
          //         color: Color(0xFF4E4F50),
          //         shape: BoxShape.circle,
          //       ),
          //       child: IconButton(
          //           icon: Icon(
          //             Icons.search,
          //             size: 28.0,
          //             color: Colors.white,
          //           ),
          //           onPressed: () {}),
          //     )
          //   ],
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
          //   padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          //   sliver: SliverToBoxAdapter(
          //     child: Stories(
          //       currentUser: currentUser,
          //       stories: stories,
          //     ),
          //   ),
          // ),
          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //           (context, index) {
          //         final Post post = posts[index];
          //         return PostContainer(post: post);
          //       },
          //       childCount: posts.length
          //   ),
          // )
          //   ],
          // ),
        ],
      ),
    );
  }
}
