
import 'package:boat_app/provider/filter_provider.dart';
import 'package:boat_app/utils/colors.dart';
import 'package:boat_app/utils/utils.dart';
import 'package:boat_app/view/auth/auth_controller.dart';
import 'package:boat_app/view/auth/signin/loginscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/loading_provider/loading_provider.dart';
import 'global_function.dart';



Future<Map<String, dynamic>?> fetchDataFromFirebase() async {
  // Replace 'your_collection' with the actual name of your Firestore collection

  try {
    // Fetch data from Firebase
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
    await FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).get();

    // Convert the data to a map
    Map<String, dynamic>? dataMap = {};
    dataMap = documentSnapshot.data();


    return dataMap;
  } catch (e) {
    // Handle errors
    print('Error fetching data: $e');
    return {};
  }
}


void idGuest(BuildContext context){
  if(FirebaseAuth.instance.currentUser == null){
 showDialogGuest(context);
  }
}

Future<String> getSecretAPIKey(
    String docName,fieldName
    ) async{
  var data= await FirebaseFirestore.instance.collection('ApiKeys').doc(docName).get();
  return data[fieldName];
}

Future<void> checkUserStatusAndLogout(BuildContext context) async {
  AuthService authService = AuthService();
  if(FirebaseAuth.instance.currentUser == null){

  }else{
  String? userStatus= await getUserStatus(FirebaseAuth.instance.currentUser!.email!);

  if(userStatus == 'Activate'){
    print('Do nothing');
  }
  else{
    authService.signOut().then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginView()));
      showDialogStatus(context, 'User is deactivated by admin, Kindly contact admin');

    });

  }}
}


void showDialogStatus(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('User Inactive', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Utils.launchSocialApps('mailto:taimoor00777@gmail.com');

              final loadingProvider =
              Provider.of<LoadingProvider>(context, listen: false);
              loadingProvider.loginLoading(false);
              Navigator.of(context).pop();
            },
            child: Text('Contact'),
          ),
          TextButton(
            onPressed: () {
              final loadingProvider =
              Provider.of<LoadingProvider>(context, listen: false);
              loadingProvider.loginLoading(false);
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}

Future<String?> getUserType(String email) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('User')
      .where('email', isEqualTo: email)
      // .limit(1)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs[0]['userType'].toString();
  } else {
    return null;
  }
}
Future<String?> getUserName( ) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('User')
      .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  // .limit(1)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs[0]['name'].toString();
  } else {
    return null;
  }
}

Future<bool?> getOwner(String email) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('Owner')
      .where('email', isEqualTo: email)
  // .limit(1)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}

Future<bool?> getLockedStatus(String id) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('BoatData')
      .where('boatId', isEqualTo: id)
      .limit(1)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs[0]['locked'];
  } else {
    return false;
  }
}
Future<String?> getUserStatus(String email) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('User')
      .where('email', isEqualTo: email)
      .limit(1)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs[0]['status'].toString();
  } else {
    return null;
  }
}

Future<bool?> getUserDeleteStatus(String email) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('User')
      .where('email', isEqualTo: email)
      .limit(1)
      .get();
  print('object');

  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs[0]['isDeleted'];
  } else {
    return null;
  }
}

Future<String?> getUserTypeO(String email) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('Owner')
      .where('email', isEqualTo: email)
      .limit(1)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs[0]['userType'].toString();
  } else {
    return null;
  }
}

Future<bool> checkGoogleExists(String email) async {
  final QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
      .collection('User')
      .where('email', isEqualTo: email) .
  where('signUpWith', isEqualTo: 'google')
      .limit(1)
      .get();

  return querySnapshot.docs.isNotEmpty;
}

Future<bool> checkEmailExists(String email) async {
  final QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
      .collection('User')
      .where('email', isEqualTo: email) .
  where('signUpWith', isEqualTo: 'email')
      .limit(1)
      .get();

  return querySnapshot.docs.isNotEmpty;
}
Future<bool> getEmergencyDetails() async {
  final QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
      .collection('emergencyDetails')
      .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .limit(1)
      .get();

  return querySnapshot.docs.isNotEmpty;
}
Future<String?> getBoat(String id) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('BoatData')
      .where('id', isEqualTo: id)
      .limit(1)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs[0]['id'].toString();
  } else {
    return null;
  }
}



Future<String?> getBoatPrice( boatId) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('BoatData').where(boatId)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs[0]['boatPrice'].toString();
  } else {
    return null;
  }
}
Future<String?> getOrderPrice( index) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('orders')
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs[index]['Amount'].toString();
  } else {
    return null;
  }
}
Future<String?> getBookingData( ) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('orders').where('status', isEqualTo: 'Confirmed')
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    for(int i =1; i<= querySnapshot.docs.length; i++){
      return querySnapshot.docs[i]['status'].toString();

    }
  } else {
    return null;
  }
}

Future<String?> checkPendingStatus(String orderId ) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('orders').where('orderId', isEqualTo: orderId).where('status', isEqualTo: 'Confirmed')
      .get();

  if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs[0]['status'].toString();


  } else {
    return null;
  }
}
Future<bool?> checkNotPendingStatus(String boatId, String startDate, String timeSlot ) async {
  print(boatId);
  print(startDate.runtimeType);
  print(timeSlot.runtimeType);
  print('2023-09-26 '.runtimeType);
  print(timeSlot);
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('orders').where('boatId', isEqualTo: boatId)
      .where('status', isEqualTo: 'Pending')
      .where('userIdB', isEqualTo:FirebaseAuth.instance.currentUser!.uid )
      .where('startDate', isEqualTo: startDate).where('timeSlot', isEqualTo: timeSlot)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
print(true);
    return true;


  } else {
    print(false);
    return false;
  }
}



//
// Future<String?> getBoatPackagePrice(boatId, index ) async {
//   final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//       .collection('BoatData').doc(boatId).collection('packages')
//       .limit(1)
//       .get();
//
//   if (querySnapshot.docs.isNotEmpty) {
//     return querySnapshot.docs[index]['package'].toString();
//   } else {
//     return null;
//   }
// }
Future<bool> getReview(String orderId) async {
  final QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
      .collection('Reviews')
      .where('orderId', isEqualTo: orderId)
  // .where('signUpWith', isEqualTo: 'google')
      .get();

  return querySnapshot.docs.isNotEmpty;
}

Future<double?> getReviewAvg( String boatId) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('Reviews').
  where('boatId', isEqualTo: boatId)
      .get();
  print(boatId);
print('+++++++++');
print(querySnapshot.docs.isNotEmpty);
  if (querySnapshot.docs.isNotEmpty) {
    print('+++++++++1');
    double totalrating = 0;
    int totalboats = 0;
    for(int i =0; i <querySnapshot.docs.length; i++ ){
      String rating = querySnapshot.docs[i]['rating'].toString();
      double rat = double.parse(rating);

      totalrating = totalrating + rat;
      totalboats = querySnapshot.docs.length;
      print(totalrating);

    }
    print(totalboats);
    print(totalrating);
    double result = totalrating/totalboats;
    print(result);
    return result;

  } else {
    print('+++++++++2');
    return 0;
  }
}


Future<bool> checkOrderStatus(String orderId) async {
  final DocumentSnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
      .collection('orders').doc(orderId)
      .get();
  if (kDebugMode) {
    print(querySnapshot.data()!['startDate']);
    print(querySnapshot.data()!['startTime']);

  }
  String dateString2 = querySnapshot.data()!['startDate'];
  String time = querySnapshot.data()!['startTime'];
  dateString2 = dateString2.substring(0, 10); // Keep on
  DateTime dateTime = DateTime.parse(dateString2);

  String Now = DateTime.now().toString();
  TimeOfDay currentTime = TimeOfDay.now();
  print(currentTime);

  Now = Now.substring(0, 10); // Keep on
  DateTime dateTimeNow = DateTime.parse(Now);
  TimeOfDay timeFromFirebase = _getTimeOfDayFromString(time.trim());
  print(timeFromFirebase);



  // DateTime date = DateTime.parse(querySnapshot.data()!['startDate']);
  // print(date.isAfter(DateTime.now()));
  if(dateTime.isAtSameMomentAs(dateTimeNow) && timeFromFirebase.hour <= currentTime.hour &&
      timeFromFirebase.minute <= currentTime.minute){
    return true;
  }else{
    return false;
  }

  return querySnapshot.exists;
}
TimeOfDay _getTimeOfDayFromString(String timeString) {
  final format = DateFormat.jm(); // Create a date format for the given time string format
  DateTime dateTime = format.parse(timeString); // Parse the time string to a DateTime object
  return TimeOfDay.fromDateTime(dateTime); // Convert DateTime to TimeOfDay
}
void sendArrayToFirebase(List array) {
  FirebaseFirestore.instance
      .collection('typesOfBoats') // Replace 'myCollection' with your desired collection name
      .doc('JjVw5MQScr2ur0uS2VWT') // Replace 'myDocument' with your desired document name
      .update({'boattypes': array})
      .then((value) => print('Array sent to Firebase'))
      .catchError((error) => print('Error sending array: $error'));
}


String id = DateTime.now().millisecondsSinceEpoch.toString();
void sendAreasToFirebase(List array) {
  FirebaseFirestore.instance
      .collection('area') // Replace 'myCollection' with your desired collection name
      .doc(id) // Replace 'myDocument' with your desired document name
      .set({
    'area': '',
  })
      .then((value) => print('Array sent to Firebase'))
      .catchError((error) => print('Error sending array: $error'));
}

Future<String?> getStatus(String boatId, time) async {
  final QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
      .collection('orders').where('boatId', isEqualTo: boatId).where('timeSlot', isEqualTo: time).get();
  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs[0]['status'].toString();
  } else {
    return null;
  }
}

Future<bool> isPhoneNumberUsed(String phoneNumber) async {
  try {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance
        .collection('User') // Replace with your collection name
        .where('phone', isEqualTo: phoneNumber)
        .get();

    return snapshot.docs.isNotEmpty;
  } catch (e) {
    // Handle error
    return false;
  }
}

Future<bool> checkNotification() async {
  final QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
      .collection('notifications')
      .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  .where('status', isEqualTo: 'unread')
      .get();
  print(querySnapshot.docs.isEmpty);

  return querySnapshot.docs.isNotEmpty;
}

String getDayOfWeek(int value) {
  String dayOfWeek = "";

  switch (value) {
    case 1:
      dayOfWeek = "Monday";
      break;
    case 2:
      dayOfWeek = "Tuesday";
      break;
    case 3:
      dayOfWeek = "Wednesday";
      break;
    case 4:
      dayOfWeek = "Thursday";
      break;
    case 5:
      dayOfWeek = "Friday";
      break;
    case 6:
      dayOfWeek = "Saturday";
      break;
    case 7:
      dayOfWeek = "Sunday";
      break;
    default:
      dayOfWeek = "Invalid day";
  }

  return dayOfWeek;
}

Future<String?> getPhone() async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('User')
      .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .limit(1)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs[0]['phone'].toString();
  } else {
    return null;
  }
}



Future<int?> getTime(orderId) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('orders')
      .where('orderId',isEqualTo: orderId)
      .limit(1)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    var time = DateTime.now();
    var orderTime = querySnapshot.docs[0]['orderTime'];

    return time.difference(orderTime).inSeconds;
  } else {
    return 0;
  }
}

// Future<Map<String, dynamic>?> getBoatsSearch(orderId, BuildContext context) async {
//   final filterProvider = Provider.of<FilterProvider>(context,listen: false);
//   final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//       .collection('BoatData')
//       .where('boatPrice',isLessThan: filterProvider.sprice)
//   .where('boatPrice', isGreaterThan: filterProvider.eprice)
//   .where('maxPerson', isGreaterThan: filterProvider.spassengers)
//       .where('maxPerson', isGreaterThan: filterProvider.epassengers)
//       .where('boatType', isEqualTo: filterProvider.boatType, )
//
//
//       .get();
//
//   if (querySnapshot.docs.isNotEmpty) {
//     Map<String, dynamic> Data = querySnapshot.data;
//     return Data;
//   } else {
//     return null;
//   }
// }


Future<List<Map<String, dynamic>>> getBoatsSearch(BuildContext context) async {
  final filterProvider = Provider.of<FilterProvider>(context, listen: false);
  print(filterProvider.boatType);
  print(filterProvider.eprice);
  print(filterProvider.spassengers);

  final QuerySnapshot querySnapshot = filterProvider.boatType == 'All'
      ? await FirebaseFirestore.instance
      .collection('BoatData')
      .where('boatStatusApproved', isEqualTo: true)
      .get()
      : await FirebaseFirestore.instance
      .collection('BoatData')
      .where('boatType', isEqualTo: filterProvider.boatType)
      .where('boatStatusApproved', isEqualTo: true)
      .get();

  List<Map<String, dynamic>> boatDataList = [];

  if (querySnapshot.docs.isNotEmpty) {
    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      if (filterProvider.sprice != null &&
          filterProvider.eprice != null &&
          filterProvider.spassengers != null &&
          filterProvider.epassengers != null &&
          filterProvider.boatType != null &&
          filterProvider.boatindex != null) {
        int price = int.parse(data['boatPrice']);
        int maxPerson = int.parse(data['maxPerson']);

        if (filterProvider.sprice! < price &&
            filterProvider.eprice! > price) {
          if (filterProvider.spassengers! < maxPerson &&
              filterProvider.epassengers! > maxPerson) {
            boatDataList.add(data);
          }
        }
      } else {
        boatDataList.add(data);
      }
    }
    return boatDataList;
  } else {
    return [];
  }
}

Future<Map<String, dynamic>?> getUserPaymentData( ) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('User')
      .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .limit(1)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    final Map<String, dynamic> userData = {
      'name': querySnapshot.docs[0]['name'],
      'phone': querySnapshot.docs[0]['phone'],
      'email': querySnapshot.docs[0]['email'],
    };
    return userData;
  } else {
    return null;
  }
}

Future<String?> getPaymentKey( ) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('payementKey')
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs[0]['key'].toString();
  } else {
    return null;
  }
}