//
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:medskin/firestore_test/Data.dart';
// import 'package:medskin/firestore_test/doctorNotifier.dart';
//
// getDoctors(DoctorNotifier doctorNotifier) async {
//   QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("doctorList").get();
//
//   List<Data> _doctorList = [];
//
//   snapshot.docs.forEach((document) {
//     Data doctor = Data.fromMap(document.data());
//     _doctorList.add(doctor);
//   });
//
//   doctorNotifier.doctorList = _doctorList;
// }