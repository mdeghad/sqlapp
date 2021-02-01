import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqlfliteapp/Views/notelist.dart';
class SaveDetails extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SaveDetailsState();

  }

}

class SaveDetailsState extends State{

  final titleController=TextEditingController();
  final detailController=TextEditingController();

  String dropdownValue = 'High';
  String holder="";
  List <String> actorsName = [
    'High',
    'Low',
  ] ;

  void getDropDownItem(){

    setState(() {
      holder = dropdownValue ;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Color(0XFF7986CB),
      ),

      body:
      Container(
        color: Colors.grey,
      //  margin: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        child: ListView(

          children: [
Row(children: [
            DropdownButton<String>(

              value: dropdownValue,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
             // elevation: 16,
              style: TextStyle(color: Colors.black, fontSize: 18),
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              onChanged: (String data) {
                setState(() {
                  dropdownValue = data;
                  print("");
                });
              },
              items: actorsName.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
]),
            Container(

              margin: const EdgeInsets.all(5),
              child:

            TextField(

                  cursorColor: Colors.black,
                  controller: titleController,
                  style: TextStyle(color: Colors.black),
                  decoration: new InputDecoration(
                    labelText: "Title",
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
            Container(
              margin: const EdgeInsets.all(5),

              child:
            TextField(

                cursorColor: Colors.black,
                controller: detailController,
                style: TextStyle(color: Colors.black),
                decoration: new InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.black),
                  fillColor: Colors.white,
                  focusedBorder:OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black,),

                  ),
                  //  hintText:( "Enter your Email Id"),
                  // errorText: _validate? 'Enter Correct email':null,
                )

            ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Container(
            // width: MediaQuery.of(context).size.width*0.4,
            // height: MediaQuery.of(context).size.height/4,

            child:
               RaisedButton(
                 child: Text("Save",style: TextStyle(color: Colors.black),),
                 color: Color(0XFF7986CB),
                 onPressed: (){
                   Navigator.push(context,MaterialPageRoute(builder: (context)=>NoteList()));
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