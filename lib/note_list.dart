import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfirstflutterapp/model/Notes.dart';
import 'package:myfirstflutterapp/writenote.dart';
import 'database/dbhelper.dart';

Future<List<Notes>> selectNotesFromDatabase() async {
  var dbHelper = DBHelper();
  Future<List<Notes>> notes = dbHelper.getNotes();
  return notes;
}

class NoteList extends StatefulWidget{
  NoteListState createState()=> NoteListState();
}
class NoteListState extends State<NoteList>{
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        title:  Text("All Notes"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: FutureBuilder<List<Notes>>(
          future: selectNotesFromDatabase(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context,index)
              {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(snapshot.data[index].title, style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18.0),),
                    Text(snapshot.data[index].note,
                      style: TextStyle(fontSize: 14.0),),
                    new Divider()
                  ]);
              }
              );
            }
            else if (snapshot.hasError) {
              return new Text("${snapshot.error}");
            }
            return new Container(alignment:  AlignmentDirectional.center,child: new CircularProgressIndicator(),);

        }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => WriteNote())
          );
        },
      ),
    );
  }

}