import 'package:meta/meta.dart';
import 'package:intro_app/models/models.dart';

class DummyStory {
  final User user;
  final String imageUrl;
  final bool isViewed;

  const DummyStory({
    @required this.user,
    @required this.imageUrl,
    this.isViewed = false,
  });
}
