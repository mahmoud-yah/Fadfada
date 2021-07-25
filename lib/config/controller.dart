import 'package:get/get.dart';
import 'package:intro_app/models/normal_post.dart';
import 'package:intro_app/models/profile_model.dart';

class Controller extends GetxController {
  var count = 0;
  var token;
  bool isEmulator;
  var posts = [];
  var toVisitPosts = [];
  UserProfile currentUserProfile = UserProfile();
  UserProfile toVisitProfile = UserProfile();

  void increment() {
    count++;
  }

  void setTokenValue(userToken) {
    token = userToken;
  }

  void logout() {
    count = 0;
    token = null;
    posts.clear();
  }

  // void printPostsIds() {
  //   for (var i = 0; i < posts.length; i++) {
  //     print(posts[i].userID);
  //   }
  // }



  void addPost(Post post) {
    posts.add(post);
  }

  addProfileInfo(
      String profileID,
      String userID,
      String firstName,
      String lastName,
      String imageUrl,
      String address,
      String gender,
      String phone,
      String bio,
      String birthDate) {
    currentUserProfile.profileID=profileID;
    currentUserProfile.userID = userID;
    currentUserProfile.firstName = firstName;
    currentUserProfile.lastName = lastName;
    currentUserProfile.imageUrl = imageUrl;
    currentUserProfile.address = address;
    currentUserProfile.gender = gender;
    currentUserProfile.phone = phone;
    currentUserProfile.bio = bio;
    currentUserProfile.birthDate = birthDate;
  }

  addToVisitProfileInfo(
    String firstName,
    String lastName,
    String imageUrl,
    String address,
    String bio,
  ) {
    toVisitProfile.firstName = firstName;
    toVisitProfile.lastName = lastName;
    toVisitProfile.imageUrl = imageUrl;
    toVisitProfile.address = address;
    toVisitProfile.bio = bio;
  }

  void addToVisitPost(Post post) {
    toVisitPosts.add(post);
  }
}
