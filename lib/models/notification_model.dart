// import 'package:intro_app/models/message_model.dart';

import 'user_model.dart';

class PostNotification {
  final User sender;
  final String time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String type;
  final bool seen;
  final String text;

  PostNotification({this.sender, this.time, this.type, this.seen, this.text});
}

  final User greg = User(id: 1, name: 'Ahmad', imageUrl: 'images/greg.jpg');
  final User james = User(id: 2, name: 'Khaled', imageUrl: 'images/james.jpg');
  final User john = User(id: 3, name: 'Saeed', imageUrl: 'images/john.jpg');
  final User olivia = User(id: 4, name: 'Heba', imageUrl: 'images/olivia.jpg');
  final User sam = User(id: 5, name: 'Samira', imageUrl: 'images/sam.jpg');
  final User sophia = User(id: 6, name: 'Lina', imageUrl: 'images/sophia.jpg');
  final User steven = User(id: 7, name: 'Omar', imageUrl: 'images/steven.jpg');

  List<PostNotification> notifications = [
    PostNotification(
      sender: greg,
      seen: false,
      time: '38m',
      type: 'Like',
      text: 'liked your post.'
    ),
    PostNotification(
      sender: james,
      seen: true,
      time: '13h',
      type: 'Comment',
      text: 'commented on your post.'
    ),
    PostNotification(
      sender: john,
      seen: false,
      time: '1d',
      type: 'Like',
      text: 'liked your post',
    ),
    PostNotification(
      sender: olivia,
      seen: true,
      time: '1d',
      type: 'Like',
      text: 'liked your post.',
    ),
    PostNotification(
      sender: sam,
      seen: true,
      time: '2d',
      type: 'Comment',
      text: 'commented on your post.'
    ),
    PostNotification(
      sender: sophia,
      seen: false,
      time: '3d',
      type: 'Like',
      text: 'liked your post.',
    ),
    PostNotification(
      sender: steven,
      seen: true,
      time: '5d',
      type: 'Comment',
      text: 'commented on your post.'
    ),
  ];

