import 'package:meta/meta.dart';

class User {
  final int id;
  final String name;
  final String imageUrl;

  const User({
    this.id,
    @required this.name,
    @required this.imageUrl,
  });
}
