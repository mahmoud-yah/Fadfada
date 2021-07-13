import 'package:meta/meta.dart';

class UserProfile {
  String userID;
  String firstName;
  String lastName;
  String imageUrl;
  String address;
  String gender;
  String phone;
  String bio;
  String birthDate;

   UserProfile({
    this.userID,
    this.firstName,
     this.lastName,
     this.imageUrl,
     this.address,
     this.gender,
     this.phone,
     this.bio,
     this.birthDate,
  });

   // void setInfo(){
   //   this.userID='0';
   // }
}
