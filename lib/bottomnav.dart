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

  //BottomNavigation Items
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
        bottomNavigationBar: Container(
          width: 373,
          height: 63,
          margin: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: CupertinoTabBar(
              backgroundColor: blackOp,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded, color: _page==0? Colors.blue: mobileBackgroundColor),
                  label: 'Feed',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_rounded, color: _page==1? Colors.blue: mobileBackgroundColor),
                  label: 'Liked',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.group, color: _page==2? Colors.blue: mobileBackgroundColor),
                  label: 'Community',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark_border_rounded, color: _page==3? Colors.blue: mobileBackgroundColor),
                  label: 'Saved',
                ),
              ],
              onTap: pageChanged,
              currentIndex: _page,
              activeColor: mobileBackgroundColor,
              inactiveColor: mobileBackgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}