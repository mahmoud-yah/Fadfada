import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_app/models/normal_post.dart';

// import 'package:intro_app/screens/profile.dart';
import 'package:intro_app/models/profile_model.dart';

class Controller extends GetxController {
  var count = 0;
  var token;
  var posts = [];
  UserProfile currentUserProfile = UserProfile();

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

  void printPostsIds() {
    for (var i = 0; i < posts.length; i++) {
      print(posts[i].userID);
    }
  }

  void addPost(Post post) {
    posts.add(post);
  }

  addProfileInfo(
      String userID,
      String firstName,
      String lastName,
      String imageUrl,
      String address,
      String gender,
      String phone,
      String bio,
      String birthDate) {
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
}
