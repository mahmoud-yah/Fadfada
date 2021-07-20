import 'package:meta/meta.dart';
import 'package:intro_app/models/user_model.dart';

class Post {
  final int userID;
   int postID;
  final String caption;
  final String timeAgo;
  final String imageUrl;
  int likes;
  final String name;
  final String firstName;
  final String lastName;

  // final int comments;
  // final int shares;
  bool isLiked;

  Post({

    this.userID,
    this.postID,
    this.caption,
    this.timeAgo,
    this.imageUrl,
    this.likes,
    this.name,
    this.firstName,
    this.lastName,
    // @required this.comments,
    // @required this.shares,
    this.isLiked,
  });
}
