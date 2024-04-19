import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class OrderProvider with ChangeNotifier{

  Future<bool> isOrdered(String id) async {
    print(id);
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      print(userId);
      print(id);
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('orders').where('userIdB', isEqualTo: userId).where('boatId', isEqualTo: id).get();

      if (snapshot.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}