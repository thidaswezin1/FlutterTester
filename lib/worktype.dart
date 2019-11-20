import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfirstflutterapp/job.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:app_settings/app_settings.dart';

class WorkType extends StatefulWidget{
  WorkTypeState createState()=>WorkTypeState();
}
class WorkTypeState extends State<WorkType>{
  var scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription<ConnectivityResult> _subscription;
  @override

  void initState() {
      super.initState();
      _subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result){
          if(result==ConnectivityResult.none){
              scaffoldKey.currentState.showSnackBar(
                  SnackBar(content: Text("No Connection"),
                  duration: Duration(seconds: 5),
                  action: SnackBarAction(
                    label: "Network Settings",
                    onPressed:(){ AppSettings.openWIFISettings();},
                  ),));
          }
          else{
              scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("Connection Restored"),duration: Duration(seconds: 2),));
          }
      });
  }

  void dispose(){
    super.dispose();
    _subscription.cancel();
  }

  void getDataFromServer(String term) async{
    final response = await http.get("http://167.172.70.248:8000/routes/search?term="+term);
    if(response.statusCode==200){
      setState(() {
        var jsonData = json.decode(response.body);
        print(response.body);
        print(jsonData);
        _routeList.clear();
        _routeList.addAll((jsonData["results"] as List).map((i)=>Route.fromJson(i)));

      });
    }
  }

  List _routeList = new List();
  String _routeName = "Route Name";

 // final _listOfJob={"SE":"Software Engineer","PM":"Project Manager"};
  List job = ["System Engineer","Software Developer","Project Manager"];
  String jobValue="System Engineer";
  List<DropdownMenuItem<String>> getJobList(){
    List<DropdownMenuItem<String>> jobList = new List();
    /*_listOfJob.forEach((k,v){
      jobList.add(DropdownMenuItem(value: k,child: Text(v)));
    });*/
    for(String s in job){
        jobList.add(DropdownMenuItem(value: s,child: Text(s),));
    }
    return jobList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Route Finder"),
      ),
      body: Container(
        child:SingleChildScrollView(
        child:Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top:30),
               child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:<Widget>[
                  Text("Job Description"),
                  SizedBox(
                    width: 200,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      value: jobValue,
                      items: getJobList(),
                      onChanged: (v){
                        setState(() {
                          jobValue = v;
                        });
                      },
                    ),
                  ),
//                  DropdownButtonHideUnderline(
//                 child: DropdownButton(
//
//                   value: jobValue,
//                   items: getJobList(),
//                   onChanged: (v){
//                     setState(() {
//                       jobValue=v;
//                     });
//                   },
//                 ),
//                ),
                ])),
                Divider(thickness: 2,),
                Padding(padding: EdgeInsets.only(top:20),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Route From Server"),
                    SizedBox(
                      width: 200,
                      child:TextField(
                        decoration: InputDecoration(
                          hintText: "Search Routes",
                          border: OutlineInputBorder()
                        ),
                        textAlign: TextAlign.center,
                        onChanged: (value){
                           getDataFromServer(value);
                        },
                      ) ,
                    )

                  ],
                )),
                Container(
                  color: Colors.greenAccent,
                  child:  ConstrainedBox(
                    constraints: BoxConstraints(
                      // minHeight: 35,
                      maxHeight: 250,
                    ),
                    child: ListView.builder(
                        itemCount: _routeList.length,
                        itemBuilder: (context,index){
                          return Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(_routeList[index].text),
                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                onTap: (){
                                  setState(() {
                                    _routeName = _routeList[index].text;
                                  });
                                },
                              ),

                            ],
                          );
                        }
                    ),

                  ),
                )
               ,
                Padding(padding: EdgeInsets.only(top:20),
                child:Text(_routeName,textAlign: TextAlign.center,style: TextStyle(fontStyle: FontStyle.italic),)),
                RaisedButton(
                  color: Colors.greenAccent,
                  child: Text("Next Page"),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>JobDesc(job:jobValue,salary: "400000",routeName: _routeName,)));
                  },
                )
             ],
    )
    )));
  }



}
class Route{
  int id;
  String text;
  Route({this.id, this.text});
  factory Route.fromJson(Map<String, dynamic> json){
    return Route(
        id: json["id"], text: json["text"]
    );
  }
}