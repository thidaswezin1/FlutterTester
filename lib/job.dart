import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobDesc extends StatelessWidget{
  final job;
  final salary;

  JobDesc({this.job,this.salary});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Job"),
      ),
      body: Row(
        children: <Widget>[
          Text("Your current job -"),
          Text(job),
          Text(" , Salary - "),
          Text(salary)
        ],
      ),
    );
  }

}