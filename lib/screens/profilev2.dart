import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_app/data/data.dart';
import 'package:intro_app/models/post_model.dart';
import 'package:intro_app/screens/edit_profile.dart';

// import 'package:intro_app/widgets/favorite_contacts.dart';
import 'package:intro_app/widgets/widgets.dart';

class ProfileV2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            brightness: Brightness.dark,
            backgroundColor: Colors.black,
            leading: Container(),
            leadingWidth: 0,
            title: Text('Profile'),
            actions: [IconButton(icon: Icon(Icons.menu), onPressed: () {})],
          ),
          SliverPadding(
            padding: EdgeInsets.all(10.0),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 66.0,
                      foregroundColor: Colors.green,
                      // backgroundColor: Colors.green,
                      child: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80'),
                        radius: 65.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'David Brooks',
                      style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          // textDirection: TextDirection.rtl,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                              size: 22,
                            ),
                            SizedBox(
                              width: 3.0,
                            ),
                            Text(
                              'Damascus, SY',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cake,
                              color: Colors.white,
                              size: 22,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              'May 16, 1984',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              '5',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w400,
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
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        Container(
                          color: Colors.white,
                          height: 50.0,
                          width: 0.3,
                        ),

                        Column(
                          children: [
                            Text(
                              '1.5M',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Followers',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        Container(
                          color: Colors.white,
                          height: 50.0,
                          width: 0.3,
                        ),

                        // ElevatedButton(
                        //   onPressed: () {},
                        //   child: Text(
                        //     'Unfollow',
                        //     style: TextStyle(fontSize: 20.0),
                        //   ),
                        //   style: ElevatedButton.styleFrom(primary: Colors.blueAccent),
                        // ),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfile()),
                            );
                          },
                          child: Text('Edit Profile'),
                          style: OutlinedButton.styleFrom(
                              primary: Colors.white,
                              side:
                                  BorderSide(color: Colors.white, width: 0.4)),
                        ),
                      ],
                    ),
                    Container(
                      margin:  EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                      // padding: EdgeInsets.fromLTRB(0, 20.0, 0, 10.0),
                      color: Colors.grey,
                      width: MediaQuery.of(context).size.width*0.9,
                      height: 0.2,
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final Post post = profilePosts[index];
              return PostContainer(post: post);
            }, childCount: posts.length),
          )
        ],
      ),
    );
  }
}
