class Comment {
  int userID;
  String name;
  String caption;
  String timeAgo;
  String imageUrl;
  int likes;
  bool isLiked;

  Comment({
    this.userID,
    this.name,
    this.caption,
    this.timeAgo,
    this.imageUrl,
    this.likes,
    this.isLiked,
  });
}
