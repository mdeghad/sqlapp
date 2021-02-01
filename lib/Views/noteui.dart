import 'package:flutter/material.dart';
import 'package:sqlfliteapp/Models/task.dart';
import 'package:sqlfliteapp/Utils/databasehelper.dart';




class NoteUi extends StatefulWidget{
  final String title;

  const NoteUi({Key key, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
   return NoteUiState();
  }

}

class NoteUiState extends State{
  DataBase_Helper dataBase_Helper;
  @override
  void initState() {
    super.initState();

    DataBase_Helper.instance.getAllData().then((value) {
      setState(() {
        value.forEach((element) {
          list.add(Task(id: element['id'], title: element["title"]));
        });
      });
    }).catchError((error) {
      print(error);
    });
  }

  void showInSnackBar(String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(value)
    ));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(''),
          content: SingleChildScrollView(
            child:TextFormField(
              decoration: InputDecoration(hintText: "Enter a task"),
              controller: textController,
            ),
          ),
          actions: <Widget>[
           RaisedButton(
             color: Colors.orangeAccent,
              child: Text('Add'),
              onPressed: () {

               addTodb();
               Navigator.of(context).pop();
              },
            ),

          ],
        );
      },
    );
  }


  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(''),
          content: Column(children: [
            TextFormField(
              decoration: InputDecoration(hintText: "Enter a task"),
              controller:idController,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Enter a task"),
              controller:descController,
            ),
        ]
          ),
          actions: <Widget>[
            RaisedButton(
              child: Text('Update'),
             color: Colors.orangeAccent,
              onPressed: () {
                updateTodb();
                Navigator.of(context).pop();
              },
            ),

          ],
        );
      },
    );
  }

List<Task>list=new List();
  final textController=TextEditingController();
  final descController=TextEditingController();
  final idController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task"),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Text("Add New Task",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),



            SizedBox(height: 20),

            Expanded(child: Container(
              child: list.isEmpty
              ? Container(

              ):ListView.builder(itemBuilder: (ctx,index){
                if(index==list.length)return null;
                return ListTile(
                  title: Text(list[index].title),
                  leading: IconButton(icon: Icon(Icons.edit),
                    onPressed: ()=>showDialog()
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteTask(list[index].id);
                      final snackBar = SnackBar(
                      content: Text('Deleted task'),
                      action: SnackBarAction(
                      label: 'Hide',
                      onPressed: () {},
                      ),
                      );

                      Scaffold.of(context).showSnackBar(snackBar);
                      print("false");
                    }
                  ),
                );
              }),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showMyDialog,
        child: Icon(Icons.add),
        backgroundColor: Colors.orangeAccent,
      ), // This trailing
    );

  }

  void addTodb()async{
    String task=textController.text;
    var id=await DataBase_Helper.instance.insert(Task(title:task));
    setState(() {
      list.insert(0, Task(id:id, title:task));
    });
  }

  void _deleteTask(int id) async {
    await DataBase_Helper.instance.delete(Task(id: id));
    setState(() {
      list.removeWhere((element) => element.id == id);
    });
  }

  void updateTodb() async{

        Map<String, dynamic> row ={
          DataBase_Helper.colId:int.parse(idController.text) as String,
         DataBase_Helper.colTitle:descController.text
        };
        final rowsAffected = await dataBase_Helper.update(row);
        print('updated $rowsAffected row(s)');


  }

  }



