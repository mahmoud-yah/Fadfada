import 'package:meta/meta.dart';
import 'package:intro_app/models/user_model.dart';

class Post {
  final int userID;
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
    @required this.userID,
    @required this.caption,
    @required this.timeAgo,
    @required this.imageUrl,
    @required this.likes,
    this.name,
    this.firstName,
    this.lastName,
    // @required this.comments,
    // @required this.shares,
    this.isLiked,
  });
}
