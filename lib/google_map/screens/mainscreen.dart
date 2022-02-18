import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medskin/allwidgets/divider.dart';
import 'package:medskin/allwidgets/progressDialog.dart';
import 'package:medskin/google_map/models/directionDetails.dart';
import 'package:medskin/google_map/screens/search_Screen.dart';
import 'package:provider/provider.dart';

import '../Assistant/assistant_method.dart';
import '../dataHandler/appData.dart';



class googleMapMainScreen extends StatefulWidget {
  @override
  _googleMapMainScreenState createState() => _googleMapMainScreenState();
}



class _googleMapMainScreenState extends State<googleMapMainScreen>  with TickerProviderStateMixin{


  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  DirectionDetails tripDirectionDetails;

  List<LatLng> plineCordinates = [];
  Set<Polyline> polyLineSet = {};
  Position currentPosition;
  var geoLocator = Geolocator();

  double mapBottomPaddingOfMap = 0;

  Set<Marker> markerSet = {};
  Set<Circle> circleSet = {};

  double medicalCenterDetailsContainerHeight = 0;
  double requestRideContainerHeight = 0;
  double searchContainerHeight = 300.0;

  bool drawerOpen = true;

  void displayRequestRideContainer(){
    setState(() {
      requestRideContainerHeight = 250.0;
      medicalCenterDetailsContainerHeight = 0;
      mapBottomPaddingOfMap = 230.0;
      drawerOpen= false;
    });
  }

  resetApp(){
    setState(() {
      drawerOpen = true;
      searchContainerHeight = 300.0;
      medicalCenterDetailsContainerHeight = 0;
      mapBottomPaddingOfMap = 230.0;

      polyLineSet.clear();
      markerSet.clear();
      circleSet.clear();
      plineCordinates.clear();

    });

    locatePosition();

  }


  void displayDetailsContainer() async {
    await getPlaceDirection();

    setState(() {
      searchContainerHeight = 0;
      medicalCenterDetailsContainerHeight = 230.0;
      mapBottomPaddingOfMap = 230.0;

      drawerOpen = false;
    });
  }

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
    target: LatLng(37.42796133580664, -122.0857496555962),
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
            child: IconButton(
                icon: Icon(Icons.location_on_sharp,size: 20.0,color: Colors.blueGrey,),
              onPressed: () {
                  print("Add Marker");
              },
                ),
                ),
                ],
                ),
                drawer: Container(
                color: Colors.white,
                width: 300.0,
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
                padding: EdgeInsets.only(bottom: mapBottomPaddingOfMap),
                mapType : MapType.hybrid,
                myLocationButtonEnabled : true,
                initialCameraPosition: _kGooglePlex,

                //enabled controls
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: true,
                polylines: polyLineSet,
                markers: markerSet,
                circles: circleSet,

                onMapCreated : (GoogleMapController controller){
                _controllerGoogleMap.complete(controller);
                newGoogleMapController = controller;

                setState(() {
                mapBottomPaddingOfMap = 300.0;
                });

                locatePosition();
                },
                ),

                Positioned(
                top: 35.0,
                left: 20.0,
                child: GestureDetector(
                onTap: (){
                if(drawerOpen){
                scaffoldKey.currentState.openDrawer();
                }
                else{
                resetApp();
                }
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
                child: Icon((drawerOpen) ? Icons.menu: Icons.close, color: Colors.black,),
                radius: 20.0,
                ),
                ),
                ),
                ),
                Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 0.0,

                child: AnimatedSize(
                vsync: this,
                curve: Curves.bounceIn,
                duration: new Duration(milliseconds: 160),
                child: Container(
                height: searchContainerHeight,
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
                onTap: () async{
                var res =await Navigator.push(context, MaterialPageRoute(builder: (context) => searchScreen(),),);

                if(res== "obtainDirection"){
                displayDetailsContainer();
                }
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
                Provider.of<AppData>(context).PickUpLocation != null
                ? Provider.of<AppData>(context).PickUpLocation.placeName
                    :"Add Your Location" ,
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
                "Your Location"
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
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: AnimatedSize(
              vsync: this,
              curve: Curves.bounceIn,
              duration: new Duration(milliseconds: 160),
              child: Container(
                height: medicalCenterDetailsContainerHeight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0),),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 15.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7,0.7),
                      )
                    ]
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.tealAccent[100],
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              Image.asset(
                                "images/medSkin.png",
                                height: 70.0,
                                width: 80.0,
                              ),
                              SizedBox(width: 15.0,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Car",
                                    style: TextStyle(
                                      fontSize: 18.0,

                                    ),
                                  ),
                                  Text(
                                    ((tripDirectionDetails!= null) ? tripDirectionDetails.distanceText : ''),
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(child: Container()),
                              Text(
                                ((tripDirectionDetails!= null) ? '\Rs ${AssistantMethods.calculateFares(tripDirectionDetails)}' : ''),
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.moneyCheckAlt,
                              size: 20.0,
                              color: Colors.black54,
                            ),
                            SizedBox(width: 15.0,),
                            Text("Cash"),
                            SizedBox(width: 6.0,),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black54,
                              size: 15.0,
                            ),
                            SizedBox(height:25.0),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: RaisedButton(
                                onPressed: (){
                                  displayRequestRideContainer();
                                },
                                color: Theme.of(context).accentColor,
                                child: Padding(
                                  padding: EdgeInsets.all(17.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Request",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Icon(
                                        FontAwesomeIcons.taxi,
                                        color: Colors.white,
                                        size: 26.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,

            child: Container(
              height: requestRideContainerHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 0.5,
                    blurRadius: 15.0,
                    color: Colors.black54,
                    offset: Offset(0.7,0.7),
                  )
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    SizedBox(height: 10.0,),

                    SizedBox(
                      width: double.infinity,
                      child: ColorizeAnimatedTextKit(
                        onTap: (){
                          print("Tap Event");
                        },
                        text: [
                          "Requesting a Ride....",
                          "Please Wait...",
                          "Finding a Driver...",
                        ],
                        textStyle:TextStyle(
                          fontSize: 50.0,
                          fontFamily: "Signatra",
                        ),
                        colors: [
                          Colors.green,
                          Colors.purple,
                          Colors.pink,
                          Colors.blue,
                          Colors.yellow,
                          Colors.red,
                        ],
                        textAlign: TextAlign.center,
                        // alignment: Alignment.topLeft,
                      ),
                    ),
                    SizedBox(height:20.0,),
                    Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(width: 2.0, color: Colors.grey[300]),
                      ),
                      child: Icon(Icons.close, size: 25.0,),
                    ),
                    SizedBox(height:10.0,),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "Cancel Ride",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  Future<void> getPlaceDirection() async{
    var initialPos = Provider.of<AppData>(context , listen: false).PickUpLocation;
    var finalPos = Provider.of<AppData>(context , listen: false).DropOffLocation;

    var pickUpLatLng = LatLng(initialPos.latitude, initialPos.longitude);
    var dropoffLatLng = LatLng(finalPos.latitude, finalPos.longitude);

    showDialog(
      context: context,
      builder: (BuildContext context)=> progressDialog(message: "Please Wait..."),
    );

    var details = await AssistantMethods.obtainPlaceDirectionDetails(pickUpLatLng, dropoffLatLng);

    setState(() {
      tripDirectionDetails = details;
    });

    Navigator.pop(context);

    print("This is encoding Points ::");
    print(details.encodedPoints);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolylinePointsResult = polylinePoints.decodePolyline(details.encodedPoints);

    plineCordinates.clear();

    if(decodedPolylinePointsResult.isNotEmpty){
      decodedPolylinePointsResult.forEach((PointLatLng pointLatLng) {
        plineCordinates.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    polyLineSet.clear();
    setState((){
      Polyline polyline = Polyline(
        color: Colors.red,
        polylineId: PolylineId("PolylineID"),
        jointType: JointType.round,
        points: plineCordinates,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );
      polyLineSet.add(polyline);
    });

    LatLngBounds latLngBounds;
    if(pickUpLatLng.latitude > dropoffLatLng.latitude && pickUpLatLng.longitude > dropoffLatLng.longitude){
      latLngBounds = LatLngBounds(southwest: dropoffLatLng, northeast: pickUpLatLng);
    }
    else if(pickUpLatLng.longitude > dropoffLatLng.longitude){
      latLngBounds = LatLngBounds(southwest: LatLng(pickUpLatLng.latitude, dropoffLatLng.longitude), northeast: LatLng(dropoffLatLng.latitude, pickUpLatLng.longitude));
    }
    else if(pickUpLatLng.latitude > dropoffLatLng.latitude){
      latLngBounds = LatLngBounds(southwest: LatLng(dropoffLatLng.latitude, pickUpLatLng.longitude), northeast: LatLng(pickUpLatLng.latitude, dropoffLatLng.longitude));
    }
    else{
      latLngBounds = LatLngBounds(southwest: pickUpLatLng, northeast: dropoffLatLng);
    }
    newGoogleMapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70.0));

    Marker pickUpLocationMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(title: initialPos.placeName, snippet: "My Location"),
      position: pickUpLatLng,
      markerId: MarkerId("pickUpId")
    );

    Marker dropOffLocationMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: finalPos.placeName, snippet: "Drop Off Location"),
        position: dropoffLatLng,
        markerId: MarkerId("dropOffId")
    );

    setState(() {
      markerSet.add(pickUpLocationMarker);
      markerSet.add(dropOffLocationMarker);
    });

    Circle pickUpLocationCircle = Circle(
      fillColor: Colors.red,
      center: pickUpLatLng,
      radius: 12,
      strokeColor: Colors.redAccent,
      circleId: CircleId("pickUpId"),
    );

    Circle dropOffLocationCircle = Circle(
      fillColor: Colors.transparent,
      center: dropoffLatLng,
      radius: 12,
      strokeColor: Colors.blueAccent,
      circleId: CircleId("dropOffId"),
    );

    setState(() {
      circleSet.add(pickUpLocationCircle);
      circleSet.add(dropOffLocationCircle);
    });

  }

}
