import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medskin/allwidgets/divider.dart';
import 'package:medskin/google_map/screens/sarch_Screen.dart';
import 'package:provider/provider.dart';

import '../Assistant/assistant_method.dart';
import '../dataHandler/appData.dart';



class googleMapMainScreen extends StatefulWidget {
  @override
  _googleMapMainScreenState createState() => _googleMapMainScreenState();
}



class _googleMapMainScreenState extends State<googleMapMainScreen> {

  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  late Position currentPosition;
  var geoLocator = Geolocator();

  double ? mapBottomPadding;

  void locatePosition() async{
    Position position = await geoLocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latlngPositon = LatLng(position.latitude, position.longitude);

    CameraPosition camPosition = new CameraPosition(target: latlngPositon,zoom: 14);

    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(camPosition));

    String address = await AssistantMethods.searchCoordinateAddress(position, context);
    print("This is Your location address :: " + address);
  }


  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Find Medical Center"),
        actions:[
          CircleAvatar(
            radius: 20.0,
            backgroundColor: Colors.transparent,
            child: Icon(Icons.logout_rounded,size: 20.0,color: Colors.black,),
          ),
        ],
      ),
      drawer: Container(
        color: Colors.white,
        width: 255.0,
        child: Drawer(
          child: ListView(
            children: [
              Container(
                height: 160.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "images/medSkin.png",
                        height:100.0,
                        width : 100.0,
                      ),
                      SizedBox(width : 15.0,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Profile Name",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(height: 8.0,),

                          Text(
                            "Visit Profile",
                          )
                        ],
                      )
                    ],
                ),
                ),
              ),
              dividerWidget(),

              SizedBox(height: 12.0,),

              ListTile(
                leading : Icon(Icons.history),
                title : Text(
                  "History",
                  style: TextStyle(
                    fontSize: 15.0,
                  )
                ),
              ),
              ListTile(
                leading : Icon(Icons.person),
                title : Text(
                    "profile",
                    style: TextStyle(
                      fontSize: 15.0,
                    )
                ),
              ),
              ListTile(
                leading : Icon(Icons.info),
                title : Text(
                    "About",
                    style: TextStyle(
                      fontSize: 15.0,
                    )
                ),
              ),
              // ListTile(
              //   leading : Icon(Icons.history),
              //   title : Text(
              //       "History",
              //       style: TextStyle(
              //         fontSize: 15.0,
              //       )
              //   ),
              // ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            // padding: EdgeInsets.only(bottom: mapBottomPadding),
            mapType : MapType.normal,
            myLocationButtonEnabled : true,
            initialCameraPosition: _kGooglePlex,

            //enabled controls
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,

            onMapCreated : (GoogleMapController controller){
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              setState(() {
                mapBottomPadding = 200.0;
              });

              locatePosition();
            },
          ),
          
          Positioned(
            top: 15.0,
            left: 10.0,
            child: GestureDetector(
              onTap: (){
                scaffoldKey.currentState!.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue,
                      blurRadius: 6.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7,0.7),
                    )
                  ]
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.menu, color: Colors.black,),
                  radius: 20.0,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,

            child: Container(
              height: 300.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),topRight: Radius.circular(15.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 15.0,
                    spreadRadius: 0.5 ,
                    offset: Offset(0.7,0.7),
                  )
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5.0,),
                    Text(
                      "Hi There",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      "Which place?",
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    SizedBox(height:25.0,),
                    
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => searchScreen(),),);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 6.0,
                                spreadRadius: 0.5 ,
                                offset: Offset(0.7,0.7),
                              )
                            ]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Icon(Icons.search,color: Colors.blueAccent,),
                              SizedBox(width: 10.0,),
                              Text(
                                "Search Location",
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.0,),
                    Row(
                      children: [
                        Icon(Icons.home,color: Colors.grey,),

                        SizedBox(width: 15.0,),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                             Provider.of<appData>(context).userPickUpLocation != null
                              ? Provider.of<appData>(context).userPickUpLocation!.placeName
                              : "Add Your Location",
                            ),
                            SizedBox(height: 5.0,),

                            Text(
                              "Your Current Location",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10.0,),

                    dividerWidget(),

                    SizedBox(height: 15.0,),

                    Row(
                      children: [
                        Icon(Icons.home,color: Colors.grey,),

                        SizedBox(width: 15.0,),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your Location",
                            ),
                            SizedBox(height: 5.0,),

                            Text(
                              "Your Current Location",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
