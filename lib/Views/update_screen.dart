import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlfliteapp/Models/note.dart';
import 'package:sqlfliteapp/Utils/dtatbase_helper.dart';

class NoteScreen extends StatefulWidget {
  final Note note;
  NoteScreen(this.note);

  @override
  State<StatefulWidget> createState() => new _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  DatabaseHelper db = new DatabaseHelper();

  TextEditingController _titleController;
  TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();

    _titleController = new TextEditingController(text: widget.note.name);
    _descriptionController = new TextEditingController(text: widget.note.age);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Note'),
      backgroundColor:   Color(0XFF7986CB),),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
              child: Text("Add New  Task",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),

            ),
            Container(

              margin: const EdgeInsets.all(5),
              child:

              TextField(

                  cursorColor: Colors.black,
                  controller: _titleController,
                  style: TextStyle(color: Colors.black),
                  decoration: new InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black,),

                    ),
                    //  hintText:( "Enter your Email Id"),
                    // errorText: _validate? 'Enter Correct email':null,
                  )

              ),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            Container(

              margin: const EdgeInsets.all(5),
              child:

              TextField(

                  cursorColor: Colors.black,
                  controller: _descriptionController,
                  style: TextStyle(color: Colors.black),
                  decoration: new InputDecoration(
                    labelText: "Description",
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black,),

                    ),
                    //  hintText:( "Enter your Email Id"),
                    // errorText: _validate? 'Enter Correct email':null,
                  )

              ),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // width: MediaQuery.of(context).size.width*0.4,
                  // height: MediaQuery.of(context).size.height/4,

                  child:
                  RaisedButton(
                    color:  Color(0XFF7986CB),
                    child: (widget.note.id != null) ? Text('Update') : Text('Add'),
                    onPressed: () {
                      if (widget.note.id != null) {
                        db.updateNote(Note.fromMap({
                          'id': widget.note.id,
                          'name': _titleController.text,
                          'age': _descriptionController.text
                        })).then((_) {
                          Navigator.pop(context, 'update');
                        });
                      }else {
                        db.saveNote(Note(_titleController.text, _descriptionController.text)).then((_) {
                          Navigator.pop(context, 'save');
                        });
                      }
                    },
                  ),
                ),

                Container(
                  // width: MediaQuery.of(context).size.width*0.4,
                  // height: MediaQuery.of(context).size.height/4,
                  margin: const EdgeInsets.all(5),
                  child:
                  RaisedButton(
                    child: Text("Cancel",style: TextStyle(color: Colors.black)),
                    color:  Color(0XFF7986CB),
                    onPressed: (){},

                  ),
                )
              ],
            ),


          ],
        ),
      ),
    );
  }
}