import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class BookmarkProvider extends ChangeNotifier {
  Set<String> bookmarkedIds = {}; // IDs of bookmarked items

  // void addBookmark(String id) {
  //   bookmarkedIds.add(id);
  //   notifyListeners();
  // }

  // void removeBookmark(String id){
  //   bookmarkedIds.remove(id);
  //   notifyListeners();
  // }
  // bool isBookmarked(String id) {
  //
  //   return bookmarkedIds.contains(id);
  // }


  Future<void> saveBookmark(
      String id,
      boatId,
      userId
      ) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;

      FirebaseFirestore.instance.collection('Fav').doc(id).set({
        'favId': id,
             'boatId':  boatId,
      'userId':userId

      }).then((value) {
        // bookmarkedIds.add(id);

      });

      notifyListeners();
    }

  }



  Future<void> removeBookmarkF(String id) async {
    print(id);
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Fav').where('userId', isEqualTo: userId).where('boatId', isEqualTo: id).get();
      if(snapshot.docs.isNotEmpty){
        String boatId = snapshot.docs[0]['favId'];
        FirebaseFirestore.instance.collection('Fav').doc(boatId).delete().then((value) {

        });
      }

    }
    notifyListeners();
  }





  Future<bool> isContainerBookmarked(String id) async {
    print(id);
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Fav').where('userId', isEqualTo: userId).where('boatId', isEqualTo: id).get();

      if (snapshot.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
