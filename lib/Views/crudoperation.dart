import 'package:flutter/material.dart';
import 'package:sqlfliteapp/Models/note.dart';
import 'package:sqlfliteapp/Utils/dtatbase_helper.dart';
import 'package:sqlfliteapp/Views/update_screen.dart';

class CrudMethods extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return CrudMethodState();
  }

}

class CrudMethodState extends State {
  DatabaseHelper dbHelper = new DatabaseHelper();
  TextEditingController nameController;
  TextEditingController ageController;
  List<Note> items = new List();

  @override
  void initState() {
    super.initState();


  }

  void _deleteNote(BuildContext context, Note note, int position) async {
    dbHelper.deleteNote(note.id).then((notes) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToupdate(BuildContext context, Note note) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(note)),
    );

    if (result == 'update') {
      dbHelper.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Note.fromMap(note));
          });
        });
      });
    }
  }

  void _createNewNote(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(Note('', ''))),
    );
    if (result == 'save') {
      dbHelper.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Note.fromMap(note));
          });
        });
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Tasks"),
        backgroundColor:  Color(0XFF7986CB),),
        body:
        Center(

          child: ListView.builder(
                  itemCount: items.length,
                  // padding: const EdgeInsets.all(15.0),
                  itemBuilder: (context, position) {
                    return Column(
                      children: <Widget>[
                        Divider(),
                        Card(child:
                        ListTile(
                          title: Text(
                            '${items[position].name}',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.deepOrangeAccent,
                            ),
                          ),
                          subtitle: Text(
                            '${items[position].age}',
                            style: new TextStyle(
                              fontSize: 18.0,
                              fontStyle: FontStyle.normal,
                              color: Colors.black
                            ),
                          ),
                          leading: Column(
                            children: <Widget>[
                              // Padding(padding: EdgeInsets.all(10.0)),
                              IconButton( icon: const Icon(Icons.edit, color:  Color(0XFF7986CB) ,),
                                  onPressed: () => _navigateToupdate(context, items[position])),


                            ],
                          ),
                          trailing:  IconButton(
                              icon: const Icon(Icons.delete, color:  Color(0XFF7986CB),),
                              onPressed: () => _deleteNote(context, items[position], position)),
                       //   onTap: () => _navigateToupdate(context, items[position]),
                        ),
                        ),
                      ],
                    );
                  }),


        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor:  Color(0XFF7986CB),
        onPressed: () => _createNewNote(context),
      ),
    );
  }




}
