

import 'package:flutter/material.dart';

class Notes_View extends StatefulWidget{
  Notes_View({super.key});
  @override
  State<Notes_View> createState()=> _Notes_View();
}

class _Notes_View extends State<Notes_View>{

  List arrNotes = [
    {"title" : "My Note" , "note" : "buy grocery"} ,
    {"title" : "My Note" , "note" : "buy grocery"},
    {"title" : "My Note" , "note" : "buy grocery"},
    {"title" : "My Note" , "note" : "buy grocery"},
    {"title" : "My Note" , "note" : "buy grocery"},
    {"title" : "My Note" , "note" : "buy grocery"},
    {"title" : "My Note" , "note" : "buy grocery"},
    {"title" : "My Note" , "note" : "buy grocery"},
    {"title" : "My Note" , "note" : "buy grocery"},
    {"title" : "My Note" , "note" : "buy grocery"},
    {"title" : "My Note" , "note" : "buy grocery"},
    {"title" : "My Note" , "note" : "buy grocery"},
    {"title" : "My Note" , "note" : "buy grocery"},
  ];

  @override
  Widget build(BuildContext context) {
    print(arrNotes.length);
    return Scaffold(
      appBar: AppBar(title: Text("Notes"), actions: [
        PopupMenuButton(itemBuilder: (context){
          return const  [PopupMenuItem(value: "Logout", child: Text("Logout"),)];
        })
      ]),
      body: ListView.builder(itemBuilder: (context , index){
        return Card(
          child: ListTile(
            leading: Text('${index+1}'),
            title: Text(arrNotes[index]['title']),
            subtitle: Text(arrNotes[index]['note']),
            trailing: Icon(Icons.delete_outline),
          ),
        );
      }, itemCount: arrNotes.length,),
      floatingActionButton: ElevatedButton(onPressed: (){

      } , child: Icon(Icons.add),),

    );
  }

}