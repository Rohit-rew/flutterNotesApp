

import 'package:flutter/material.dart';

class AddNote_View extends StatefulWidget{
  AddNote_View({super.key});
  @override
  State<AddNote_View> createState ()=> _AddNote_View();
}

class _AddNote_View extends State<AddNote_View>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("New Note"),),
    );
  }
}
