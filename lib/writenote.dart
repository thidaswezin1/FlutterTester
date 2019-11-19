import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'database/dbhelper.dart';
import 'model/Notes.dart';
import 'note_list.dart';

class WriteNote extends StatefulWidget{
  WriteNoteState createState()=> WriteNoteState();
}

class WriteNoteState extends State<WriteNote> {
  Notes notes = new Notes("","");
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  String title;
  String note1;

  Future<bool> _onWillPop(){
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
          title: new Text('Add Note'),
          actions: <Widget>[
            new IconButton(
              icon: const Icon(Icons.view_list),
              tooltip: 'Next choice',
              onPressed: () {
                navigateToNoteList();
              },
            ),
          ]
      ),
      body: Center(
        child: Form(
          key: formKey,
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left:20,top:70,right: 20),
              child:
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Title",
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(
                        )
                    )
                ),
                validator: (val)=>val.length==0?"Write Title":null,
                onSaved:(val)=>this.title=val,
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 20,top:30,right:20),
              child:
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                decoration: InputDecoration(
                    labelText: "Notes",
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide()
                    )
                ),
                validator: (val)=>val.length==0?"Write Notes":null,
                onSaved: (val)=>this.note1=val,
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 20,top:30,right:20),
            child:
                RaisedButton(
                  child: Text("Save"),
                  onPressed: (){
                    _save();
                  },
                )
            )

          ],
        ),
        )
      ),
      ));
  }
  void _save() {
    if (this.formKey.currentState.validate()) {
      formKey.currentState.save();
    }else{
      return null;
    }
    var note = Notes(title,note1);
    var dbHelper = DBHelper();
    dbHelper.saveNotes(note);
    _showSnackBar("Data saved successfully");
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  void navigateToNoteList() {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => new NoteList()));
  }
}