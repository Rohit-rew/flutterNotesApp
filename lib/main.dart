import 'package:flutter/material.dart';
import 'package:notes/views/addNote_view.dart';
import 'package:notes/views/login_view.dart';
import 'package:notes/views/notes_view.dart';
import 'package:notes/views/register_view.dart';


void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeView(),
      routes: {
         "/login/" : (context) => const LoginView(),
        "/register/" : (context)=> Register_View(),
      },
    ),
  );
}




class HomeView extends StatelessWidget{

  HomeView({super.key});
  bool isLoggedIn = false;

  @override
  Widget build (BuildContext context){
    return Builder(builder: (BuildContext context){
      if(isLoggedIn){
        return Notes_View();
      }else{
        return LoginView();
      }
    });
  }
  
}