import 'package:employeeforumsassignment/database/database_helper.dart';
import 'package:employeeforumsassignment/database/post_data.dart';
import 'package:employeeforumsassignment/models/post.dart';
import 'package:employeeforumsassignment/provider/postprovider.dart';
import 'package:employeeforumsassignment/screen/filter.dart';
import 'package:employeeforumsassignment/utils/colors_fonts.dart';
import 'package:employeeforumsassignment/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget{
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ScrollController controller = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  List<Post> posts = [];
  bool isEmpty = false;


  //Initial flow when users visits this page
  Future<void> _initializeData() async {
    final postProvider = Provider.of<PostProvider>(context, listen:false);
    final dbHelper = DatabaseHelper.instance;

    // Check if the database is empty
    int count = await dbHelper.getPostCount();
    if (count == 0) {
      // Fetch data from the API
      await PostData().fetchPostApi(1);
      // Insert manual data
      await PostData().insertManualData();

      //Check if the filter is applied
      if(postProvider.filter.isEmpty) {
        await _loadDataFromDatabase();
      }else{
        await _performFilter(postProvider.filter);
      }
    } else {
      if(postProvider.filter.isEmpty) {
        // Load data from the database
        await _loadDataFromDatabase();
      }else{
        await _performFilter(postProvider.filter);
      }
    }
    setState(() {});
  }

  //Load Data from the SQL Database
  Future<void> _loadDataFromDatabase() async {
    final dbHelper = DatabaseHelper.instance;
    List<Map<String, dynamic>> data = await dbHelper.getPosts();
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

  //Filter posts based on eventCategory
  Future _performFilter(String query) async {
    final dbHelper = DatabaseHelper.instance;
    List<Map<String, dynamic>> results = await dbHelper.filterPosts(query);
    List<Post> filterPosts = results.map((json) => Post.fromJson(json)).toList();
    setState(() {
      posts = [];
      posts.addAll(filterPosts);
      if(results.isEmpty){
        isEmpty = true;
      }else{
        isEmpty = false;
      }
    });
  }

  //Refresh the posts
  void onRefresh() async{
    setState(() {
      _searchController.text = '';
      posts = [];
      isEmpty = false;
    });
    _initializeData();
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
          actions: [
            Stack(
              children: [
                const IconButton(
                  onPressed: null,
                  icon: Icon(Icons.notifications_none_rounded, color: textColor,),
                ),
                Positioned(
                  top: 15,
                  right: 15,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                    child: Container(
                      width: 10,
                      height: 10,
                      color: bellNotificationColor,
                    ),
                  ),
                ),
             ],
            ),
          ],
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            onRefresh();
          },
          color: blackText,
          child: Column(
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
                          hintStyle: GoogleFonts.roboto(color: greyColor, fontSize: 16, fontWeight: FontWeight.w400),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          prefixIcon: const Icon(Icons.search, color: greyColor,),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FilterPage())),
                      icon: const Icon(Icons.tune_rounded, color: blueColor, size: 40,),
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
      ),
    );
  }
}