import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intro_app/models/models.dart';
import 'package:intro_app/widgets/profile_avatar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PostContainer extends StatelessWidget {
  final Post post;

  const PostContainer({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100.0,
      // color: Colors.black,
      color: Theme.of(context).backgroundColor,
      // decoration: BoxConstraints,
      margin: const EdgeInsets.symmetric(vertical: 0.5),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PostHeader(post: post),
                const SizedBox(height: 6.0),
                Text(
                  post.caption,
                  style: TextStyle(
                    // color: Colors.white,
                    color: Theme.of(context).primaryColor,
                    height: 1.25,
                    letterSpacing: 0.5,
                  ),
                ),
                post.imageUrl != null
                    ? const SizedBox.shrink()
                    : const SizedBox(
                        height: 6.0,
                      ),
              ],
            ),
          ),
          post.imageUrl != null
              ?
              // Padding(
              //         padding: const EdgeInsets.symmetric(vertical: 8.0),
              //         child: CachedNetworkImage(imageUrl: post.imageUrl),
              //       )
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    child: CachedNetworkImage(imageUrl: post.imageUrl),
                  ),
                )
              // Container(
              //   decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(post.imageUrl),fit: BoxFit.cover)),
              //   constraints: BoxConstraints(maxHeight: 400.0),
              //     padding: EdgeInsets.symmetric(vertical: 8.0),
              //     // child: CachedNetworkImage(
              //     //   imageUrl: post.imageUrl,
              //     // ),
              //   )
              : const SizedBox.shrink(),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
          //   child: _PostButton(
          //     icon: Icon(
          //       MdiIcons.heart,
          //       color: Colors.white,
          //       size: 20.0,
          //     ),
          //     label: 'Like',
          //     onTap: () {
          //       print('Like');
          //     },
          //   ),
          // ),
          // Row(
          //   children: [
          //     Icon(Icons.favorite_border,color: Colors.white,)
          //   ],
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      post.isLiked ? Icons.favorite : Icons.favorite_border,
                      color: post.isLiked
                          ? Colors.red.shade800
                          : Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      post.likes.toString(),
                      style: TextStyle(
                        // color: Colors.white,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    // Text(
                    //   'Likes',
                    //   style: TextStyle(color: Colors.white),
                    // ),
                  ],
                ),
                // OutlinedButton(
                //     onPressed: () {},
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Icon(
                //           Icons.add_comment,
                //           color: Colors.white,
                //         ),
                //         SizedBox(
                //           width: 5.0,
                //         ),
                //         Text(
                //           'Add a comment',
                //           style: TextStyle(color: Colors.white),
                //         ),
                //       ],
                //     )),
                Column(
                  children: [
                    Icon(
                      Icons.mode_comment,
                      // color: Colors.white,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      post.comments.toString(),
                      style: TextStyle(
                        // color: Colors.white,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    // Text(
                    //   'Comments',
                    //   style: TextStyle(color: Colors.white),
                    // ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final Post post;

  const _PostHeader({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ProfileAvatar(imageUrl: post.user.imageUrl),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.user.name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  // color: Colors.white,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                height: 2.0,
              ),
              Row(
                children: [
                  Text(
                    '${post.timeAgo}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                  // Icon(
                  //   Icons.public,
                  //   color: Colors.grey[600],
                  //   size: 12.0,
                  // )
                ],
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.more_vert,
            // color: Colors.white,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () => print('more'),
        ),
      ],
    );
  }
}

class _PostStats extends StatelessWidget {
  final Post post;

  const _PostStats({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _PostButton(
              icon: Icon(
                MdiIcons.thumbUpOutline,
                color: Colors.blue,
                size: 20.0,
              ),
              label: 'Like',
              onTap: () => print('Like'),
            )
          ],
        ),
      ],
    );
  }
}

class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function onTap;

  const _PostButton({
    Key key,
    @required this.icon,
    @required this.label,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              children: [
                icon,
                const SizedBox(
                  width: 4.0,
                ),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
