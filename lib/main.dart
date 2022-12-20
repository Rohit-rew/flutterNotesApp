import 'package:flutter/material.dart';
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
      home: Notes_View(),
      routes: {
         "/login/" : (context) => const LoginView(),
        "/register/" : (context)=> Register_View(),
      },
    ),
  );
}

