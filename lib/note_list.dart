import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfirstflutterapp/model/Notes.dart';
import 'package:myfirstflutterapp/writenote.dart';
import 'database/dbhelper.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<List<Notes>> selectNotesFromDatabase() async {
  var dbHelper = DBHelper();
  Future<List<Notes>> notes = dbHelper.getNotes();
  return notes;
}


class NoteList extends StatefulWidget{
  NoteListState createState()=> NoteListState();
}
class NoteListState extends State<NoteList>{
  Future<bool> _onWillPop(){
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => SystemNavigator.pop(),
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ?? false;
  }
  static DateTime now = DateTime.now();
  String dateFormat = DateFormat('MMMM d').format(now);
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onWillPop,
        child: Scaffold(
          key: scaffoldKey,
      appBar: AppBar(
        title:  Text("All Notes"),
      ),
      body: Container(
        color: Colors.cyan,
        padding: EdgeInsets.all(8),
        child: FutureBuilder<List<Notes>>(
          future: selectNotesFromDatabase(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context,index)
              {
                return Card(
                  child: ListTile(
                    onTap:()=> Fluttertoast.showToast(msg: "Note $index is clicked!",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.teal,
                        textColor: Colors.white,
                        fontSize: 16.0),
                  subtitle:Text(snapshot.data[index].note+"\n"+dateFormat, style: TextStyle(fontSize: 14.0),) ,
                  title: Text(snapshot.data[index].title, style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17.0),) ,

                ));
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
    ));
  }

}