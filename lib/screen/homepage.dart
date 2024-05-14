import 'dart:convert';

import 'package:employeeforumsassignment/models/post.dart';
import 'package:employeeforumsassignment/utils/colors_fonts.dart';
import 'package:employeeforumsassignment/widgets/post_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget{
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ScrollController controller = ScrollController();
  final List<Post> posts = [];


  Future fetchPostApi(int page) async {
    var response  = await http.get(Uri.parse("https://post-api-omega.vercel.app/api/posts?page=$page"));
    if(response.statusCode == 200){
      final newposts = json.decode(response.body).cast<Map<String, dynamic>>();
      setState(() {
         posts.addAll(newposts.map<Post>((json) =>Post.fromJson(json)).toList());
      });
    }else{
      throw Exception("Error getting post");
    }
  }
  
  
  @override
  void initState(){
    super.initState();
    fetchPostApi(1);
    controller.addListener(() {
      if(controller.position.maxScrollExtent == controller.offset){
        fetchPostApi(1);
      }
    });
  }
  
  @override
  void dispose(){
    super.dispose();
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
                    margin: EdgeInsets.fromLTRB(9, 15, 9, 15),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search messages',
                        hintStyle: GoogleFonts.roboto(color: textColor, fontSize: 16, fontWeight: FontWeight.w400),
                        border: InputBorder.none, // Hide the default border of the TextField
                        contentPadding: EdgeInsets.zero, // Remove extra padding inside the TextField
                        prefixIcon: Icon(Icons.search, color: greyColor,), // Optional: add a search icon
                      ),
                    ),
                  ),
                  IconButton(
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
                      return PostCard(id: 1,
                          title: post.title,
                          body: post.description,
                          likes: post.likes,
                          comments: post.comments,
                          shares: 1);
                    }else{
                      return const Padding(
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