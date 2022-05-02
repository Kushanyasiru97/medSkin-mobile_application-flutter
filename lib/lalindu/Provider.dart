import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:medskin/lalindu/doctor_model.dart';


class MyProvider extends ChangeNotifier {

  /////////////////////  Single Food Item     //////////////////////////

  List<doctorListModel> foodModleList = [];
  doctorListModel foodModle;

  Future<void> getFoodList() async {
    List<doctorListModel> newSingleFoodList = [];
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('doctorList').get();
    querySnapshot.docs.forEach(
          (element) {
        foodModle = doctorListModel(
            image: element['image'],
            name: element["Name"],
            age: element['Age'],
        );
        //   name: element.data()['name'],
        //   image: element.data()['image'],
        //   age: element.data()['price'],
        // );
        newSingleFoodList.add(foodModle);
      },
    );

    foodModleList = newSingleFoodList;
    notifyListeners();
  }

  get throwFoodModleList {
    return foodModleList;
  }
}
