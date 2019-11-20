import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myfirstflutterapp/note_list.dart';
import 'package:myfirstflutterapp/profile.dart';
import 'package:myfirstflutterapp/worktype.dart';

final List<String> notes=List<String>();

class FirstScreen extends StatelessWidget {
   String _title ="";
   String _notes="";
   void _getLocation() async{
     Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
     print(position.latitude.toString()+" : "+position.longitude.toString());
     Fluttertoast.showToast(
         msg: "Latitude : "+position.latitude.toString()+"\nLongitude : "+position.longitude.toString(),
         toastLength: Toast.LENGTH_LONG,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIos: 1,
         backgroundColor: Colors.teal,
         textColor: Colors.white,
         fontSize: 16.0
     );
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Center(
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 20,top: 20,right: 20),
            child: Image.asset('assets/images/welcome.jpg'),
            ),
            /*Padding(padding: EdgeInsets.only(left:20,top:70,right: 20),
            child:
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Title",
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(
                       )
                    )
               ),
                onChanged:(text)=>_title=text,
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
                onChanged: (text)=>_notes=text,
              ),
            ),*/
            Padding(padding: EdgeInsets.only(top:30),
            child:
             RaisedButton
              (
                color: Colors.teal,
                textColor: Colors.white,
                child: new Text("Location"),
                onPressed: (){
                  _getLocation();

                  /*Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SecondScreen(_notes))
                  );*/
                }
            )),
            Padding(padding: EdgeInsets.only(left: 20,top: 30,right: 20),
              child: RaisedButton
              (
                color: Colors.amberAccent,
                child: new Text("Map"),
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ShowMap()));
                }
            ),),
            Padding(padding: EdgeInsets.only(left: 20,top: 30,right: 20),
            child: RaisedButton(
              color: Colors.deepPurple,
              child: new Text("Note"),
              textColor: Colors.white,
              onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>NoteList()));
              },
            ),),
            Padding(padding: EdgeInsets.only(left: 20,top: 30,right: 20),
            child: RaisedButton(
              color: Colors.blueGrey,
              child: Text("Route from Server"),
              textColor: Colors.white,
              onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkType()));
            }
            ),
            ),
            Padding(padding: EdgeInsets.only(left: 20,top: 30,right: 20),
            child: RaisedButton(
              color: Colors.deepOrangeAccent,
              child: Text("My Profile"),
              onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
              },
            ),)

         ]
      ),
    )
    );
  }
}

class SecondScreen extends StatelessWidget {
   // final title,notes;
   SecondScreen(String note){
     //notes.add(title);
     notes.add(note);
   }
   Widget _buildProductItem(BuildContext context, int index) {
     return Card(
       child: Column(
         children: <Widget>[
           //Image.asset('assets/macbook.jpg'),
           //Text(notes[index],style: TextStyle(color: Colors.amberAccent)),
           Text(notes[index], style: TextStyle(color: Colors.deepPurple))
         ],
       ),
     );
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Stack(
        children: <Widget>[
        ListView.builder(
          itemBuilder: _buildProductItem,
          itemCount: notes.length,
       )
        ],


      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FirstScreen())
          );
        },
      ),
    );
  }
}


class ShowMap extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<ShowMap> {
  static const String _API_KEY = '{{YOUR_API_KEY_HERE}}';
  List<Marker> markers = <Marker>[];
  GoogleMapController googleMapController;

  final LatLng _latLng = new LatLng(16.7898344, 96.1699933);
  final Set<Marker> _markers = {};

  LatLng _lastMapPosition = new LatLng(16.7898344, 96.1699933);
  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }
  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
// This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: "Place",
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }



  void _onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map Screen"),
      ),
      body: GoogleMap(
        onCameraMove: _onCameraMove,
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
          target: _latLng,
          zoom: 10,
        ),
        markers: _markers,
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _onAddMarkerButtonPressed();
          },
          label: Text("Places Nearby"),
          backgroundColor: Colors.deepPurple,
          icon: Icon(Icons.place)),
    );
  }
  /*void createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'my.db');
    Database database = await openDatabase(dbPath, version: 1, onCreate: (Database db,int version) async{
      await db.execute('CREATE TABLE Notes (id INTEGER PRIMARY KEY,title TEXT,note TEXT)');
    });

  }*/


}




