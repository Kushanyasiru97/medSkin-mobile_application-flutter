
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medskin/allwidgets/progressDialog.dart';
import 'package:medskin/google_map/Assistant/requset_assistent.dart';
import 'package:medskin/google_map/config_maps.dart';
import 'package:medskin/google_map/dataHandler/appData.dart';
import 'package:medskin/google_map/models/address.dart';
import 'package:medskin/google_map/models/placePrediction.dart';
import 'package:provider/provider.dart';

class searchScreen extends StatefulWidget {
  const searchScreen({Key key}) : super(key: key);

  @override
  _searchScreenState createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {

  TextEditingController currentLTextEditingController = TextEditingController();
  TextEditingController medicalLTextEditingController = TextEditingController();
  List<PlacePredictions> placePredictionList = [];

  @override
  Widget build(BuildContext context) {

    String placeAddress = Provider.of<AppData>(context).PickUpLocation.placeName ?? "";
    currentLTextEditingController.text = placeAddress;


    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 220.0,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 6.0,
                  spreadRadius:0.5,
                  offset: Offset(0.7,0.7),
                )
              ]
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
              child: Column(
                children: [
                  SizedBox(height: 5.0,),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(
                            Icons.arrow_back,
                        ),
                      ),
                     Center(
                       child: Text(
                         "Set Drop Off",
                         style: TextStyle(
                           fontSize: 20.0,
                         ),
                       ),
                     )
                    ],
                  ),
                  SizedBox(height: 15.0,),
                  Row(
                    children: [
                      Image.asset(
                        "images/medSkin.png",
                        height: 15.0,
                        width: 15.0,
                      ),
                      SizedBox(width: 18.0,),
                      
                      Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(5.0),

                              child: TextField(
                                controller: currentLTextEditingController,
                                decoration: InputDecoration(
                                  hintText: "Current Location",
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(top: 8.0,bottom: 8.0, left: 12.0 ),
                                ),
                              ),
                            ),
                          )
                      )
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    children: [
                      Image.asset(
                        "images/medSkin.png",
                        height: 15.0,
                        width: 15.0,
                      ),
                      SizedBox(width: 18.0,),

                      Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(5.0),

                              child: TextField(
                                onChanged: (val){
                                  findLocation(val);
                                },
                                controller: medicalLTextEditingController,
                                decoration: InputDecoration(
                                  hintText: "Where To?",
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(top: 8.0,bottom: 8.0, left: 12.0 ),
                                ),
                              ),
                            ),
                          )
                      )
                    ],
                  )
                ],
              ),
            ),
          ),

          (placePredictionList.length>0)
              ? Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
            child: ListView.separated(
              padding: EdgeInsets.all(0.0),
              itemBuilder: (context , index){
                return PredictionTile(placePredictions: placePredictionList[index]);
              },
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemCount: placePredictionList.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
            ),
          )
              : Container(),
          
        ],
      ),
    );
  }

  void findLocation(String placeName) async {
    if(placeName.length>1){
      
      String autoCompleteUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=1234567890&components=country:lk";
      // String autoCompleteUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json ?input=$placeName&key=$mapKey&sessiontoken=1234567890&components=country:LK";

      var res= await RequestAssistant.getRequest(autoCompleteUrl);

      if(res == "failed"){
        return;
      }

      if(res["status"] == "OK"){
        var predictions = res["predictions"];

        var placeList = (predictions as List).map((e) => PlacePredictions.fromJson(e)).toList();

        setState(() {
          placePredictionList = placeList;
        });
      }
    }
  }
}

class PredictionTile extends StatelessWidget {

  final PlacePredictions placePredictions;

  const PredictionTile({Key key , this.placePredictions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      FlatButton(
      padding: EdgeInsets.all(0.0),
      onPressed: (){
        getPlaceAddressDetails(placePredictions.place_id, context);
      },
       child:Container(
        child: Column(
          children: [
            SizedBox(width: 10.0,),
            Row(
              children: [
                Icon(Icons.add_location),
                SizedBox(width: 15.0,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        placePredictions.main_text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(height: 4.0,),
                      Text(
                        placePredictions.secondary_text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(width: 10.0,),
          ],
        ),
      ),
    );
  }
  void getPlaceAddressDetails(String placeId , context) async{
    
    showDialog(
        context: context,
        builder: (BuildContext context)=> progressDialog(message: 'Setting DropOff, Please wait..!',)
    );

    String placeDetailUrl = "https://maps.googleapis.com/maps/api/place/details/json?&place_id=$placeId&key=$mapKey";

    var res = await RequestAssistant.getRequest(placeDetailUrl);
    
    Navigator.pop(context);

    if(res == 'failed') {
        return ;
      }
    if(res['status'] == "OK"){
      Address address = Address();
      address.placeName = res["result"]["name"];
      address.placeId = placeId;
      address.latitude = res["result"]["geometry"]["location"]["lat"];
      address.longitude = res["result"]["geometry"]["location"]["lng"];


      Provider.of<AppData>(context,listen: false).updateDropOffLocationAddress(address);
      print("This is Searching Location ::");
      print(address.placeName);
      
      Navigator.pop(context , "obtainDirection");
    }
  }
}

