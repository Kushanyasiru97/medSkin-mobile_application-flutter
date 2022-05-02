import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:medskin/daily_Tips/dailyTip_model.dart';

class MydailytipProvider extends ChangeNotifier {

  List<dailytipListModel> foodModleList = [];
  dailytipListModel foodModle;

  Future<void> getFoodList() async {
    List<dailytipListModel> newSingleFoodList = [];
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('daily_tips').get();
    querySnapshot.docs.forEach(
          (element) {
        foodModle = dailytipListModel(
            image: element['image'],
            name: element["name"],
        );
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
