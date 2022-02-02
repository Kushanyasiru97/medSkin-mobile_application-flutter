import 'package:geolocator/geolocator.dart';
import 'package:medskin/google_map/config_maps.dart';
import 'package:medskin/google_map/dataHandler/appData.dart';
import 'package:medskin/google_map/models/address.dart';
import 'package:provider/provider.dart';
import 'requset_assistent.dart';

class AssistantMethods{
  static Future<String> searchCoordinateAddress(Position position,context) async{
    String placeAddress = "";
    String st1, st2,st3,st4;
    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";

    var response = await requestAssistant.getRequest(url);

    if(response != "Failed"){
      // placeAddress = response["results"][0]["formatted_address"];
      st1 = placeAddress = response["results"][0]["address_components"][0]["long_name"];
      st2 = placeAddress = response["results"][0]["address_components"][4]["long_name"];
      st3 = placeAddress = response["results"][0]["address_components"][5]["long_name"];
      st4 = placeAddress = response["results"][0]["address_components"][6]["long_name"];

      placeAddress = st1 + "," + st2 + "," + st3 + "," + st4;

      Address userPickUpAddress = new Address(
          placeFormattedAddress: placeAddress ,
          placeName: placeAddress,
           placeId: placeAddress,
          latitude: position.latitude,
          longitude: position.longitude);
      // userPickUpAddress.longitude = position.longitude;
      // userPickUpAddress.latitude = position.latitude;
      // userPickUpAddress.placeName = placeAddress;

      Provider.of<appData>(context, listen: false).updatePickUpLocationAddress(userPickUpAddress);

    }
    return placeAddress;
  }
}