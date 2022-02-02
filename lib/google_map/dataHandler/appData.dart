import 'package:flutter/cupertino.dart';
import 'package:medskin/google_map/models/address.dart';

class appData extends ChangeNotifier{

  Address ? userPickUpLocation;

  void updatePickUpLocationAddress(Address pickUpAddress){
    userPickUpLocation = pickUpAddress;
    notifyListeners();
  }
}