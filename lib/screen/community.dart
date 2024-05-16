import 'package:employeeforumsassignment/screen/filter.dart';
import 'package:employeeforumsassignment/utils/colors_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Communtiypage extends StatefulWidget{
  const Communtiypage({super.key});

  @override
  State<Communtiypage> createState() => _CommuntiypageState();
}

class _CommuntiypageState extends State<Communtiypage> {

  //Refresh the posts
  void onRefresh() async{
  }


  @override
  void initState(){
    super.initState();
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
              const Expanded(
                child: Text("No community posts.")
              ),
            ],
          ),
        ),
      ),
    );
  }
}