import 'package:flutter/cupertino.dart';
import 'package:medskin/google_map/models/address.dart';

class AppData extends ChangeNotifier{

  Address PickUpLocation, DropOffLocation;

  void updatePickUpLocationAddress(Address pickUpAddress){
    PickUpLocation = pickUpAddress;
    notifyListeners();
  }

  void updateDropOffLocationAddress(Address dropOffAddress){
    DropOffLocation = dropOffAddress;
    notifyListeners();
  }
}