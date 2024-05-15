
import 'package:employeeforumsassignment/utils/colors_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Communtiypage extends StatefulWidget{
  const Communtiypage({super.key});

  @override
  State<Communtiypage> createState() => _CommuntiypageState();
}

class _CommuntiypageState extends State<Communtiypage> {


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
                      decoration: InputDecoration(
                        hintText: 'Search messages',
                        hintStyle: GoogleFonts.roboto(color: textColor, fontSize: 16, fontWeight: FontWeight.w400),
                        border: InputBorder.none, // Hide the default border of the TextField
                        contentPadding: EdgeInsets.zero, // Remove extra padding inside the TextField
                        prefixIcon: const Icon(Icons.search, color: greyColor,), // Optional: add a search icon
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
            const Expanded(
              child: Text("No community posts.")
            ),
          ],
        ),
      ),
    );
  }
}