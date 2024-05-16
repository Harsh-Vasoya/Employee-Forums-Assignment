import 'package:employeeforumsassignment/bottomnav.dart';
import 'package:employeeforumsassignment/provider/postprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Employee Forums Assignment',
        theme: ThemeData(
          primaryColor: Colors.blue,
          brightness: Brightness.light,
          useMaterial3: true,
        ),
        home: const BottomNav(page: 0),
      ),
    );
  }
}