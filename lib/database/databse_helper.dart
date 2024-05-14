import 'package:employeeforumsassignment/models/post.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'posts.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE posts(
        id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT,
        likes INTEGER,
        comments TEXT,
        isLiked INTEGER,
        isSaved INTEGER,
      )
    ''');
  }

  Future<void> insertPost(Post post) async {
    Database db = await instance.database;
    await db.insert('posts', post.toJson());
  }

  Future<List<Post>> getPosts() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('posts');
    return List.generate(maps.length, (i) {
      return Post.fromJson(maps[i]);
    });
  }
}
