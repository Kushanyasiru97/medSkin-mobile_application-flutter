
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:medskin/firestore_test/Data.dart';

class DoctorNotifier with ChangeNotifier{
  List<Data> _doctorList = [];
  Data _currentDoctor;

  UnmodifiableListView<Data> get doctorList => UnmodifiableListView(_doctorList);

  Data get currentDoctor => _currentDoctor;

  set doctorList(List<Data> doctorList){
    _doctorList = doctorList;
    notifyListeners();
  }

  set currentDoctor(Data data){
    _currentDoctor = data;
    notifyListeners();
  }
}