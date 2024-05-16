import 'package:employeeforumsassignment/database/database_helper.dart';
import 'package:employeeforumsassignment/models/post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostData {

  //Fetch the post from the Api
  Future fetchPostApi(int page) async {
    final dbHelper = DatabaseHelper.instance;
    var response  = await http.get(Uri.parse("https://post-api-omega.vercel.app/api/posts?page=$page"));
    if(response.statusCode == 200){
      final newposts = json.decode(response.body) as List<dynamic>;
      for (var item in newposts) {
        await dbHelper.insertPost(Post.fromJson(item));
      }
    }else{
      throw Exception("Error getting post");
    }
  }

  //Insert manual data for saving offline posts
  Future<void> insertManualData() async {
    final dbHelper = DatabaseHelper.instance;
    List<Post> initialPosts = [
      const Post(
        title: 'Post 1',
        description: 'Content for post 1',
        likes: 0,
        isLiked: false,
        isSaved: false,
        eventCategory: 'sports',
      ),
      const Post(
        title: 'Post 2',
        description: 'Content for post 2',
        likes: 0,
        isLiked: false,
        isSaved: false,
        eventCategory: 'sports',
      ),
      const Post(
        title: 'Post 3',
        description: 'Content for post 3',
        likes: 0,
        isLiked: false,
        isSaved: false,
        eventCategory: 'sports',
      ),
      const Post(
        title: 'Post 4',
        description: 'Content for post 4',
        likes: 0,
        isLiked: false,
        isSaved: false,
        eventCategory: 'sports',
      ),
      const Post(
        title: 'Post 5',
        description: 'Content for post 5',
        likes: 0,
        isLiked: false,
        isSaved: false,
        eventCategory: 'sports',
      ),
      const Post(
        title: 'Post 6',
        description: 'Content for post 6',
        likes: 0,
        isLiked: false,
        isSaved: false,
        eventCategory: 'concert',
      ),
      const Post(
        title: 'Post 7',
        description: 'Content for post 7',
        likes: 0,
        isLiked: false,
        isSaved: false,
        eventCategory: 'concert',
      ),
      const Post(
        title: 'Post 8',
        description: 'Content for post 8',
        likes: 0,
        isLiked: false,
        isSaved: false,
        eventCategory: 'concert',
      ),
      const Post(
        title: 'Post 9',
        description: 'Content for post 9',
        likes: 0,
        isLiked: false,
        isSaved: false,
        eventCategory: 'concert',
      ),
      const Post(
        title: 'Post 10',
        description: 'Content for post 10',
        likes: 0,
        isLiked: false,
        isSaved: false,
        eventCategory: 'concert',
      ),
    ];

    for (var post in initialPosts) {
      await dbHelper.insertPost(post);
    }
  }
}