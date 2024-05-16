import 'package:employeeforumsassignment/models/post.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  DatabaseHelper._privateConstructor();

  //Get the post database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  //Initializing database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'posts.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  //Create database
  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE posts(
        title TEXT,
        description TEXT,
        likes INTEGER,
        isLiked INTEGER,
        isSaved INTEGER,
        eventCategory TEXT
      )
    ''');
  }

  //Insert each post
  Future<void> insertPost(Post post) async {
    Database db = await instance.database;
    await db.insert('posts', post.toJson());
  }

  //Get all the posts
  Future<List<Map<String, dynamic>>> getPosts() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> result = await db.query('posts');
    return result;
  }

  //Get only liked posts
  Future<List<Map<String, dynamic>>> getLikedPosts() async {
    final Database db = await instance.database;
    List<Map<String, dynamic>> likedPosts = await db.query('posts', where: 'isLiked = ?', whereArgs: [1]);
    return likedPosts;
  }

  //Get only saved posts
  Future<List<Map<String, dynamic>>> getSavedPosts() async {
    final Database db = await instance.database;
    List<Map<String, dynamic>> savedPosts = await db.query('posts', where: 'isSaved = ?', whereArgs: [1]);
    return savedPosts;
  }

  //Get only searched posts by title or event category
  Future<List<Map<String, dynamic>>> searchPosts(String query) async {
    final Database db = await instance.database;
    List<Map<String, dynamic>> searchResults = await db.rawQuery('''
      SELECT * FROM posts
      WHERE title LIKE '%$query%'  
        OR eventCategory LIKE '%$query%'
    ''');
    return searchResults;
  }

  //Get only filter posts
  Future<List<Map<String, dynamic>>> filterPosts(String query) async {
    final Database db = await instance.database;
    List<Map<String, dynamic>> filterResults = await db.rawQuery('''
      SELECT * FROM posts
      WHERE eventCategory LIKE '%$query%'
    ''');
    return filterResults;
  }

  //Get the posts count if available
  Future<int> getPostCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM posts'))!;
  }

  //Update posts likes in the database
  Future<void> updatePostLikeStatus(String title, bool isLiked, int likes) async {
    final Database db = await instance.database;
    await db.update(
      'posts',
      {'isLiked': isLiked ? 1 : 0, 'likes': isLiked? likes+1: likes-1},
      where: 'title = ?',
      whereArgs: [title],
    );
  }

  //Update posts saved in the database
  Future<void> updatePostSavedStatus(String title, bool isSaved) async {
    final Database db = await instance.database;
    await db.update(
      'posts',
      {'isSaved': isSaved ? 1 : 0},
      where: 'title = ?',
      whereArgs: [title],
    );
  }
}
