//Post model
class Post{
  final String title;
  final String description;
  final int likes;
  final bool isLiked;
  final bool isSaved;
  final String eventCategory;


  const Post({
    required this.title,
    required this.description,
    required this.likes,
    required this.isLiked,
    required this.isSaved,
    required this.eventCategory,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'likes': likes,
      'isLiked': isLiked ? 1 : 0,
      'isSaved': isSaved ? 1 : 0,
      'eventCategory': eventCategory,
    };
}

  factory Post.fromJson(Map<String, dynamic> map) {
    return Post(
      title: map['title'],
      description: map['description'],
      likes: map['likes'],
      isLiked: map['isLiked'] == 1,
      isSaved: map['isSaved'] == 1,
      eventCategory: map['eventCategory'],
    );
  }
}