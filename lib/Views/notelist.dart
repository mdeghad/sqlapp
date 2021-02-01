import 'package:flutter/material.dart';
import 'package:sqlfliteapp/Views/SaveDetails.dart';


class NoteList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NoteListState();

  }

}
class NoteListState extends State{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(

     appBar: AppBar(
       title: Text("Notes"),
       backgroundColor: Color(0XFF7986CB),
     ),
     body: Center(child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
    children: [


   ])
     ),
     floatingActionButton: FloatingActionButton(onPressed: (){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>SaveDetails()));
     },
       child: Icon(Icons.add),
       backgroundColor: Color(0XFF7986CB),
     ),

   );
  }

}