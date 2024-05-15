import 'package:employeeforumsassignment/database/database_helper.dart';
import 'package:employeeforumsassignment/database/post_data.dart';
import 'package:employeeforumsassignment/models/post.dart';
import 'package:employeeforumsassignment/utils/colors_fonts.dart';
import 'package:employeeforumsassignment/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Likedpage extends StatefulWidget{
  const Likedpage({super.key});

  @override
  State<Likedpage> createState() => _LikedpageState();
}

class _LikedpageState extends State<Likedpage> {
  final ScrollController controller = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  List<Post> posts = [];
  bool isEmpty = false;


  Future<void> _initializeData() async {
    final dbHelper = DatabaseHelper.instance;

    // Check if the database is empty
    int count = await dbHelper.getPostCount();
    if (count == 0) {
      // Fetch data from the API
      await PostData().fetchPostApi(1);
      // Insert manual data
      await PostData().insertManualData();
      await _loadDataFromDatabase();
    } else {
      // Load data from the database
      await _loadDataFromDatabase();
    }
    setState(() {});
  }

  //Load Data from the SQL Database
  Future<void> _loadDataFromDatabase() async {
    final dbHelper = DatabaseHelper.instance;
    List<Map<String, dynamic>> data = await dbHelper.getLikedPosts();
    List<Post> postList = data.map<Post>((json) => Post.fromJson(json)).toList();
    setState(() {
      posts.addAll(postList);
      if(data.isEmpty){
        isEmpty = true;
      }else{
        isEmpty = false;
      }
    });
  }

  //Search posts based on title or eventCategory
  void _performSearch(String query) async {
    final dbHelper = DatabaseHelper.instance;
    List<Map<String, dynamic>> results = await dbHelper.searchPosts(query);
    List<Post> searchPosts = results.map((json) => Post.fromJson(json)).toList();
    setState(() {
      posts = [];
      posts.addAll(searchPosts);
      if(results.isEmpty){
        isEmpty = true;
      }else{
        isEmpty = false;
      }
      if(_searchController.text.isEmpty){
        posts = [];
        _initializeData();
      }
    });
  }


  @override
  void initState(){
    super.initState();
    _initializeData();
    controller.addListener(() {
      if(controller.position.maxScrollExtent == controller.offset){
        _initializeData();
      }
    });
  }

  @override
  void dispose(){
    super.dispose();
    _searchController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const IconButton(
            onPressed: null,
            icon: Icon(Icons.menu, color: textColor,),
          ),
          title: Text("DEMO APP", style: GoogleFonts.roboto(color: textColor, fontSize: 18, fontWeight: FontWeight.w500),),
          actions: const [
            IconButton(
              onPressed: null,
              icon: Icon(Icons.notifications_none_rounded, color: textColor,),
            ),
          ],
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 393,
              height: 67,
              margin: const EdgeInsets.fromLTRB(8, 16, 10, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 306,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: searchBackgroundColor,
                    ),
                    margin: const EdgeInsets.fromLTRB(9, 15, 9, 15),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value){
                        _performSearch(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search messages',
                        hintStyle: GoogleFonts.roboto(color: textColor, fontSize: 16, fontWeight: FontWeight.w400),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        prefixIcon: const Icon(Icons.search, color: greyColor,),
                      ),
                    ),
                  ),
                  const IconButton(
                    onPressed: null,
                    icon: Icon(Icons.tune_rounded, color: textColor,),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: controller,
                  itemCount: posts.length + 1,
                  itemBuilder: (context, index) {
                    if(index < posts.length) {
                      final post = posts[index];
                      return PostCard(
                        title: post.title,
                        body: post.description,
                        likes: post.likes,
                        isLiked: post.isLiked,
                        isSaved: post.isSaved,
                      );
                    }else{
                      return isEmpty?
                      const Center(child: Text("No liked posts."),):
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}