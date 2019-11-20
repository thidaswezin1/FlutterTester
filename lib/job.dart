import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobDesc extends StatelessWidget{
  final job;
  final salary;
  final routeName;

  JobDesc({this.job,this.salary,this.routeName});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Route"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("Your current job -"),
              Text(job),
              Text(" , Salary - "),
              Text(salary)
            ],
          ),
          Divider(height: 10,thickness: 2,),
          Text("Route Name "),
          Text(routeName),
          Text((routeName as String).split("[").first)
        ],
      )

    );
  }

}