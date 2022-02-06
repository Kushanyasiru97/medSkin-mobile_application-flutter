import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medskin/google_map/config_maps.dart';
import 'package:medskin/google_map/dataHandler/appData.dart';
import 'package:medskin/google_map/models/address.dart';
import 'package:medskin/google_map/models/directionDetails.dart';
import 'package:provider/provider.dart';
import 'requset_assistent.dart';

class AssistantMethods{
  static Future<String> searchCoordinateAddress(Position position,context) async{
    String placeAddress = "";
    String st1, st2,st3,st4;
    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";

    var response = await RequestAssistant.getRequest(url);

    if(response != "failed"){
      st1 = placeAddress = response["results"][0]["address_components"][0]["long_name"];
      st2 = placeAddress = response["results"][0]["address_components"][1]["long_name"];
      st3 = placeAddress = response["results"][0]["address_components"][2]["long_name"];
      st4 = placeAddress = response["results"][0]["address_components"][4]["long_name"];

      placeAddress = st1 + "," + st2 + ","+ st3 +"," + st4;

      Address userPickUpAddress = new Address();
      userPickUpAddress.longitude = position.longitude;
      userPickUpAddress.latitude = position.latitude;
      userPickUpAddress.placeName = placeAddress;
      
      Provider.of<AppData>(context, listen: false).updatePickUpLocationAddress(userPickUpAddress);

    }
    return placeAddress;
  }

  static Future<DirectionDetails>obtainPlaceDirectionDetails(LatLng initialPosition, LatLng finalPosition) async {
    String directionUrl = "https://maps.googleapis.com/maps/api/directions/json?destination=${finalPosition.latitude},${finalPosition.longitude}&origin=${initialPosition.latitude},${initialPosition.longitude}&key=$mapKey";
    
    var res = await RequestAssistant.getRequest(directionUrl);

    if(res == "failed"){
      return null;
    }
    DirectionDetails directionsDetails = DirectionDetails();

    directionsDetails.encodedPoints = res["routes"][0]["overview_polyline"]["points"];
    directionsDetails.distanceText = res["routes"][0]["legs"][0]["distance"]["text"];
    directionsDetails.durationText = res["routes"][0]["legs"][0]["duration"]["text"];
    directionsDetails.distanceValue = res["routes"][0]["legs"][0]["distance"]["value"];
    directionsDetails.durationValue = res["routes"][0]["legs"][0]["duration"]["value"];


    return directionsDetails;
  }

}