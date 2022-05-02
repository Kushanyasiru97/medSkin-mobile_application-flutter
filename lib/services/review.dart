import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewServices{
  getLatestReview(String tip, String image){
    return FirebaseFirestore.instance.collection('daily_tips').where('tip', isEqualTo: tip)
        .where('image', isEqualTo: image)
        .get();
  }
}
