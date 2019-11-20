import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget{
  ProfileState createState()=>ProfileState();
}
class ProfileState extends State<Profile>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
      ),
      drawer: Drawer(
        child:ListView(
          children: <Widget>[
            Column(
              // Important: Remove any padding from the ListView.
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top:20),
                    child:Container(
                      width: 150,
                      height:150 ,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(

                            image:AssetImage("assets/images/photo1.jpg"),
                            fit: BoxFit.fill
                        ),

                        color: Colors.cyan,
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),

                    ))
                ,
                Text("Ms. Thida Swe Zin",textAlign: TextAlign.center,style: TextStyle(color: Colors.brown,fontSize: 18)),
                Text("(Android Developer)",textAlign: TextAlign.center,style: TextStyle(color: Colors.brown,fontSize: 17)),
                Divider(thickness: 1),




//            ListTile(
//              title: Text('Item 1'),
//              onTap: () {
//                // Update the state of the app.
//                // ...
//              },
//            ),
//            ListTile(
//              title: Text('Item 2'),
//              onTap: () {
//                // Update the state of the app.
//                // ...
//              },
//            ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.phone_android),
              title:Text("09450992378")
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text("29 July, 1996"),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title:Text("thidaswezin@gmail.com")
            ),
            ListTile(
              leading: Icon(Icons.link),
              title:Text("https://github.com/thidaswezin1")
            ),
            ListTile(
              leading:Icon(Icons.school),
              title: Text("B.E(IST)"),
            ),
            ListTile(
              leading: Icon(Icons.work),
              title:Text("ICT Star Group Myanmar Co.Ltd")
            ),
            ListTile(
                leading: Icon(Icons.location_on),
                title:Text("Yangon")
            )
          ],
        )
        ,
      ),
      body: Center(
      child:Column(

        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: 380,
              child:Carousel(
                images: [
                  ExactAssetImage("assets/images/photo1.jpg"),
                  ExactAssetImage("assets/images/photo2.jpg"),
                  ExactAssetImage("assets/images/photo3.jpg")
                ],
                dotSize: 4.0,
                dotSpacing: 15.0,
                dotColor: Colors.yellow,
                indicatorBgPadding: 5.0,
                dotBgColor: Colors.blue.withOpacity(0.5),
                borderRadius: false,
                //moveIndicatorFromBottom: 180.0,
                //noRadiusForIndicator: true,
                // overlayShadow: true,
                //overlayShadowColors: Colors.white,
                //overlayShadowSize: 0.7,
              )
          )
          ,
              Padding(padding: EdgeInsets.only(top:20),
              child: Text("Welcome to My World!!!",style: TextStyle(fontSize: 18),textAlign: TextAlign.center),)

        ],
      )),
    );
  }

}