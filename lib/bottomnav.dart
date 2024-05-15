import 'package:employeeforumsassignment/screen/community.dart';
import 'package:employeeforumsassignment/screen/homepage.dart';
import 'package:employeeforumsassignment/screen/liked.dart';
import 'package:employeeforumsassignment/screen/saved.dart';
import 'package:employeeforumsassignment/utils/colors_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget{
  final int page;
  const BottomNav({super.key, required this.page});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _page = 0;

  static final List<Widget> bottomnavItems = [
    const Homepage(),
    const Likedpage(),
    const Communtiypage(),
    const Savedpage(),
  ];

  void pageChanged(int page){
    setState(() {
      _page = page;
    });
  }

  @override
  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:  bottomnavItems[_page],
        bottomNavigationBar: CupertinoTabBar(
          backgroundColor: blackOp,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded, color: _page==0? Colors.white: Colors.white70,),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded, color: _page==1? Colors.white: Colors.white70,),
              label: 'Liked',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group, color: _page==2? Colors.white: Colors.white70,),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border_rounded, color: _page==3? Colors.white: Colors.white70,),
              label: 'Saved',
            ),
          ],
          onTap: pageChanged,
          currentIndex: _page,
        ),
      ),
    );
  }
}