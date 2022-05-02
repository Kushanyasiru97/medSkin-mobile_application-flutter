
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:medskin/testing/data.dart';

class doctorNotifier with ChangeNotifier{
  List<Data> _doctorList = [];

  Data _currentDoctors;

  UnmodifiableListView<Data> get doctorList => UnmodifiableListView(_doctorList);

  Data get currentDoctors => _currentDoctors;

  set doctorList(List<Data> doctorList){
    _doctorList = doctorList;
    notifyListeners();
  }
  set currentDoctors(Data doctors) {
    _currentDoctors = doctors;
    notifyListeners();
  }
}