//
//
// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_icons/flutter_icons.dart';
// import 'package:medskin/testing/data.dart';
// import 'package:medskin/testing/doctorsNotifier.dart';
//
// getDoctors(doctorNotifier doctorsNotifier) async {
//   QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('doctorList').get();
//
//   List<Data> _doctorList = [];
//
//   snapshot.docs.forEach((element) {
//     Data doctors = Data.fromMap(.data);
//     _doctorList.add(doctors);
//   });
//
//   doctorsNotifier.doctorList = _doctorList;
// }