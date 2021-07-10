import 'package:get/get.dart';
import 'package:intro_app/models/normal_post.dart';

class Controller extends GetxController {
  var count = 0;
  var token;
  var posts = [];

  void increment() {
    count++;
  }

  void setTokenValue(userToken) {
    token = userToken;
  }

  void logout() {
    count = 0;
    token = null;
  }

  void printPostsIds() {
    for (var i = 0; i < posts.length; i++){
      print(posts[i].userID);
    }
  }

  void addPost(Post post){
    posts.add(post);
  }

}