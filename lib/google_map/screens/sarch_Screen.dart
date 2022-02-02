
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medskin/google_map/Assistant/requset_assistent.dart';
import 'package:medskin/google_map/config_maps.dart';
import 'package:medskin/google_map/dataHandler/appData.dart';
import 'package:provider/provider.dart';

class searchScreen extends StatefulWidget {
  const searchScreen({Key? key}) : super(key: key);

  @override
  _searchScreenState createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {

  TextEditingController currentLTextEditingController = TextEditingController();
  TextEditingController medicalLTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    String placeAddress = Provider.of<appData>(context).userPickUpLocation!.placeName ??"";
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
          )
        ],
      ),
    );
  }

  void findLocation(String placeName) async {
    if(placeName.length>1){
      
      // String autoCompleteUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&location=37.76999%2C-122.44696&radius=500 &types=establishment &key=$mapKey &components=country:lk";
      String autoCompleteUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json ?input=$placeName&key=$mapKey&sessiontoken=1234567890&components=country:lk";

      var respons= await requestAssistant.getRequest(autoCompleteUrl);

      if(respons != "failed"){
        return;
      }
      print("Place predictions response ::");
      print(respons);
    }
  }
}
