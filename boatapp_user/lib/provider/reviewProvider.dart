import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ReviewProvider with ChangeNotifier{

  Future<bool> isReviewed(String id) async {
    print(id);
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Reviews').where('userId', isEqualTo: userId).where('boatId', isEqualTo: id).get();

      if (snapshot.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}