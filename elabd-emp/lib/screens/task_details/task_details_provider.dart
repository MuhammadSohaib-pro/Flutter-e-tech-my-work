import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class TaskDetailsProvider with ChangeNotifier {
  int _selectedButton = 1; // Default selected button is 1

  int get selectedButton => _selectedButton;

  CollectionReference? collection;
  QuerySnapshot? querySnapshot;

  void setSelectedButton(int button) {
    _selectedButton = button;
    notifyListeners();
  }

  Stream<List<Map<String, dynamic>>> taskData() {
    final collection = FirebaseFirestore.instance.collection('tasks').where(
        'assignedUserId',
        isEqualTo: FirebaseAuth.instance.currentUser?.uid);
    return collection.snapshots().map((snapshot) {
      List<Map<String, dynamic>> data = [];
      for (var doc in snapshot.docs) {
        data.add(doc.data());
      }
      return data;
    });
  }

  Stream<Map<String, dynamic>> detailtaskData(Map<String, dynamic> task) {
    final collection = FirebaseFirestore.instance
        .collection('tasks')
        .where('taskTitle', isEqualTo: task['taskTitle'])
        .where('assignedUserId', isEqualTo: task['assignedUserId'])
        .where('startDate', isEqualTo: task['startDate'])
        .where("endDate", isEqualTo: task["endDate"]);
    return collection.snapshots().map((snapshot) {
      List<Map<String, dynamic>> data = [];
      for (var doc in snapshot.docs) {
        data.add(doc.data());
      }
      return data.first;
    });
  }

  Future<void> changeStatus(Map<String, dynamic> task, String status) async {
    try {
      collection = FirebaseFirestore.instance.collection('tasks');
      querySnapshot = await collection
          ?.where('taskTitle', isEqualTo: task['taskTitle'])
          .where('assignedUserId', isEqualTo: task['assignedUserId'])
          .where('startDate', isEqualTo: task['startDate'])
          .where("endDate", isEqualTo: task["endDate"])
          .get();

      if (querySnapshot!.docs.isNotEmpty) {
        QueryDocumentSnapshot documentSnapshot = querySnapshot!.docs.first;
        String documentId = documentSnapshot.id;
        await collection!.doc(documentId).update({
          'taskStatus': status,
        });
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }
}
