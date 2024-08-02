import 'package:flutter/material.dart';
import 'package:git_hub_app/pages/home/home.page.dart';
import 'package:git_hub_app/pages/users/users.pages.dart';
// import 'package:http/http.dart as http';

void main()=> runApp(MyApp());


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange
      ),

      routes: {
        "/":(context)=>HomePage(),
        "/users":(context)=>UsersPage(),
      },
      initialRoute: "/users",
    );
  }


}


