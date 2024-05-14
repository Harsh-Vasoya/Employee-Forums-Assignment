class Post{
  final String id;
  final String title;
  final String description;
  final int likes;
  final List comments;


  const Post({
    required this.id,
    required this.title,
    required this.description,
    required this.likes,
    required this.comments,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'likes': likes,
      'comments': comments,
    };
}

  factory Post.fromJson(Map<String, dynamic> map) {
    return Post(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      likes: map['likes'],
      comments: map['comments'],
    );
  }
}