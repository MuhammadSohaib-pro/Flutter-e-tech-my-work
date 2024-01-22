import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/employee_model.dart';


const String INTERNETDISCONNECTIONTEXT = 'Check Your Internet Connection';


Future<bool> isNetworkAvailable() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

class CreateServices {
  // Stream<EmployeeModel> fetchUserData() {
  //   return FirebaseFirestore.instance
  //       .collection('employers')
  //       .snapshots()
  //       .map((event) => EmployeeModel.fromJson(event.data()))
  //       .handleError((error) => Stream.value(EmployeeModel()));
  // }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<EmployeeModel>> getEmployees() {
    return FirebaseFirestore.instance
        .collection("employees")
        .snapshots()
        .map((event) =>
            event.docs.map((e) => EmployeeModel.fromJson(e.data())).toList())
        .handleError((error) => Stream.value(EmployeeModel()));
  }

  Stream<QuerySnapshot> streamTasksForCurrentUser() {
    final currentUser = _auth.currentUser;
    final userUID = currentUser?.uid;

    if (userUID != null) {
      return _firestore
          .collection('tasks')
          .where('id', isEqualTo: userUID)
          .snapshots();
    }

    return const Stream
        .empty(); // Return an empty stream if the user is not logged in
  }

  
}
