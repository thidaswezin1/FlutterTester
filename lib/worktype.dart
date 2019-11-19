import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfirstflutterapp/job.dart';

class WorkType extends StatefulWidget{
  WorkTypeState createState()=>WorkTypeState();
}
class WorkTypeState extends State<WorkType>{
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
      appBar: AppBar(
        title: Text("Job Finder"),
      ),
      body: Container(
        child:Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:<Widget>[
                  Text("Job Description"),
                  DropdownButtonHideUnderline(
                 child: DropdownButton(
                   value: jobValue,
                   items: getJobList(),
                   onChanged: (v){
                     setState(() {
                       jobValue=v;
                     });
                   },
                 ),
                )
                ]),
                RaisedButton(
                  color: Colors.greenAccent,
                  child: Text("Next Page"),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>JobDesc(job:jobValue,salary: "400000",)));
                  },
                )
             ],
    )
    ));
  }

}