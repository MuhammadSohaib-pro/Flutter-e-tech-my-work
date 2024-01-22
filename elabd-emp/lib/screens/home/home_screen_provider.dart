import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_tms_app/models/rooster_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

bool isCheckedIn = false;
bool isCheckedOut = false;

enum TimeType {
  CheckIn,
  CheckOut,
}

class HomeScreenProvider with ChangeNotifier {
  HomeScreenProvider(){
    setCheckInOutBtnView();
  }
  DateTime? checkInDateTime;
  String? formattedDate;
  CollectionReference? collection;
  QuerySnapshot? querySnapshot;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
  String? totalTime;
  String? arrivedTime;
  String? exitTime;
  DateTime currentDT = DateTime.now();
  String? currentMY;
  String? myformattedMY;
  String userCurrentAddress = "Islamabad I-10";
  bool userWithinRange = true;
  bool officeTimming = false;

  setCheckInOutBtnView(){
    DateTime now = DateTime.now();

    TimeOfDay startTime = const TimeOfDay(hour: 8, minute: 0);
    TimeOfDay endTime = const TimeOfDay(hour: 19, minute: 0);
    TimeOfDay currentTime = TimeOfDay.fromDateTime(now); // Get the current time

    bool isWithinRange = customIsAfter(currentTime, startTime) &&
        customIsBefore(currentTime, endTime);

// Check if currentTime is within the range
    if (isWithinRange) {
      print('Current time is within the range');
    } else {
      print('Current time is not within the range');
    }
    officeTimming=isWithinRange;
    notifyListeners();
    print(isWithinRange);
  }

  bool customIsAfter(TimeOfDay a, TimeOfDay b) {
    if (a.hour > b.hour) {
      return true;
    } else if (a.hour == b.hour) {
      return a.minute > b.minute;
    }
    return false;
  }

  bool customIsBefore(TimeOfDay a, TimeOfDay b) {
    if (a.hour < b.hour) {
      return true;
    } else if (a.hour == b.hour) {
      return a.minute < b.minute;
    }
    return false;
  }

  // Future<void> findRangBetweenUserAndCompnay(Position position) async {
  //   String apiUrl =
  //       "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyD5VL5sp3UUsOJgl8BvLWJrjw-uIGspu7w";
  //   String humanReadableAddress = "";

  //   var requestResponse = await receiveRequest(apiUrl);

  //   if (requestResponse != "Error Occurred, Failed. No Response.") {
  //     humanReadableAddress =
  //         requestResponse["results"][0]["address_components"][0]["long_name"];
  //     LatLng companyLocation = await getCompanyLatitideLogtitude();

  //     final double distance = Geolocator.distanceBetween(
  //         position.latitude,
  //         position.longitude,
  //         companyLocation.latitude,
  //         companyLocation.longitude);

  //     if (distance <= 100.0) {
  //       print("user with in range");
  //       userWithinRange = true;
  //     }

  //     print("distance and humanredableaddress ================>");
  //     print(distance);
  //     print(humanReadableAddress);
  //     // userPickUpAddress.locationLatitude = position.latitude;
  //     // userPickUpAddress.locationLongitude = position.longitude;
  //     // userPickUpAddress.locationName = humanReadableAddress;

  //     //Provider.of<HomeScreenProvider>(context, listen: false);
  //     userCurrentAddress = humanReadableAddress;
  //   // userWithinRange = true;
  //   // userCurrentAddress = 'Islamabad I-10';
  //     notifyListeners();
  //   }
  // }

  Future<LatLng> getCompanyLatitideLogtitude() async {
    try {
      collection = firestore.collection('companySetting');
      querySnapshot = await collection!
          .where('name', isEqualTo: "Elabd Technologies")
          .get();
      if (querySnapshot!.docs.isNotEmpty) {
        QueryDocumentSnapshot documentSnapshot = querySnapshot!.docs.first;

        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        print("Latatuide and longitude of company ================>");
        print(data['latitude']);
        print(data['longitude']);
        LatLng companyLocation = LatLng(data['latitude'], data['longitude']);
        return companyLocation;
        // querySnapshot!.docs.map((e){
        //     Map<String,dynamic> data =  e.data() as Map<String,dynamic>;
        //     print("Latatuide and longitude of company ================>");
        //     print(data['latitude']);
        //     print(data['longitude']);
        //     LatLng companyLocation = LatLng(data['latitude'], data['longitude']);
        //     return companyLocation;
        // });
      }
    } catch (error) {
      print(error);
    }
    throw (error) {
      print("Faild To Get CompanySetting");
    };
  }

  Future<dynamic> receiveRequest(String url) async {
    http.Response httpResponse = await http.get(Uri.parse(url));

    try {
      if (httpResponse.statusCode == 200) //successful
      {
        String responseData = httpResponse.body; //json

        var decodeResponseData = jsonDecode(responseData);

        return decodeResponseData;
      } else {
        return "Error Occurred, Failed. No Response.";
      }
    } catch (exp) {
      return "Error Occurred, Failed. No Response.";
    }
  }

  Future<void> performCheckIn() async {
    log("this is call");

    if (isCheckedIn) {
      log("$isCheckedIn this is what come");

      // User has already checked in
      // Handle the case where the user has already checked in
      // Update a boolean flag or notify listeners to trigger UI changes
      notifyListeners();
    } else {
      log("else is call");

      formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      // Check if document with current date exists in Firestore collection
      bool documentExists = await _checkIfDocumentExists(formattedDate!);

      if (documentExists) {
        log("$documentExists document exist is call");

        // Document already exists for the current date
        // Handle the case where the user has already checked in
        // Update a boolean flag or notify listeners to trigger UI changes
        notifyListeners();
      } else {
        // Perform the check-in process
        checkInDateTime = DateTime.now();
        await _storeCheckInDateTime();

        // Update the global variable to indicate that the user has checked in
        isCheckedIn = true;

        notifyListeners();
      }
    }
  }

  Future<bool> _checkIfDocumentExists(String date) async {
    final String userId = _auth.currentUser?.uid ?? '';

    try {
      collection = FirebaseFirestore.instance.collection('checkInOut');
      querySnapshot = await collection
          ?.where('date', isEqualTo: date)
          .where("currentUserId", isEqualTo: userId)
          .get();

      return querySnapshot!.docs.isNotEmpty;
    } catch (error) {
      print('Failed to check if document exists: $error');
      return false;
    }
  }

  Future<void> _storeCheckInDateTime() async {
    log("this is call");
    DateTime now = DateTime.now();
    String formattedTime = DateFormat.Hm().format(now);
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    bool isPresent = false;
    bool isAbsent = false;
    bool isLeave = false;
    DateTime currentTime = DateTime.now();
    int unixTimestamp = currentTime.millisecondsSinceEpoch ~/ 1000;
    try {
      collection = FirebaseFirestore.instance.collection('checkInOut');
      querySnapshot = await collection!
          .where('date', isEqualTo: formattedDate)
          .where('currentUserId', isEqualTo: _auth.currentUser?.uid)
          .get();
      DateTime currentMY = DateTime.now();

      myformattedMY = formatMonthAndYear(currentMY);
      log("$myformattedMY.", name: "myformattedMY");

      log("$formatMonthAndYear", name: "formatMonthAndYear");

      log("$querySnapshot", name: "Qqqqqq");
      arrivedTime = formattedTime;
      if (querySnapshot != null && querySnapshot!.docs.isEmpty) {
        await collection!.add({
          'checkInTime': formattedTime,
          'date': formattedDate,
          'checkOutTime': "",
          'currentUserId': _auth.currentUser?.uid,
          'currentMY': myformattedMY,
          'isPresent': true,
          'isAbsent': isAbsent,
          'isLeave': isLeave,
          'unixTimestamp': unixTimestamp,
        });
      } else {
        print('A record for $formattedDate already exists.');
      }
    } catch (error) {
      print('Failed to store check-in time: $error');
    }
  }

  String formatMonthAndYear(DateTime date) {
    final DateFormat formatter = DateFormat.yMMMM();
    return formatter.format(date);
  }

  Future<void> performCheckOut() async {
    if (isCheckedOut) {
      // User has already checked in
      // Handle the case where the user has already checked in
      // Update a boolean flag or notify listeners to trigger UI changes
      notifyListeners();
    } else {
      formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      // Check if document with current date exists in Firestore collection
      bool documentExists =
          await _checkIfDocumentExistsForCheckOut(formattedDate!);

      if (documentExists) {
        checkOutDateTime = DateTime.now();
        await _storeCheckOutDateTime();

        // Update the global variable to indicate that the user has checked in
        isCheckedOut = true;
        notifyListeners();
      } else {
        // Perform the check-in process

        notifyListeners();
      }
    }
  }

  Future<bool> _checkIfDocumentExistsForCheckOut(String date) async {
    try {
      collection = FirebaseFirestore.instance.collection('checkInOut');
      querySnapshot = await collection
          ?.where('date', isEqualTo: date)
          .where("checkOutTime", isEqualTo: '')
          .get();

      return querySnapshot!.docs.isNotEmpty;
    } catch (error) {
      print('Failed to check if document exists: $error');
      return false;
    }
  }

  Future<void> _storeCheckOutDateTime() async {
    String formattedTime = DateFormat.Hm().format(DateTime.now());

    exitTime = formattedDate;

    try {
      collection = FirebaseFirestore.instance.collection('checkInOut');
      querySnapshot = await collection!
          .where('date', isEqualTo: formattedDate)
          .where("currentUserId", isEqualTo: _auth.currentUser?.uid)
          .get();

      if (querySnapshot!.docs.isNotEmpty) {
        // Update the first document found with the check-out time
        QueryDocumentSnapshot documentSnapshot = querySnapshot!.docs.first;
        String documentId = documentSnapshot.id;
        await collection!.doc(documentId).update({
          'checkOutTime': formattedTime,
        });
        log(' Check-out time successfully updated for $formattedDate..',
            name: "formattedDate.");
      } else {
        print('A record for $formattedDate already exists.');
      }
    } catch (error) {
      print('Failed to store check-out time: $error');
    }
  }

  ///
  String formatDate(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    DateFormat monthFormat = DateFormat('MMMM'); // Format for month name
    DateFormat yearFormat = DateFormat('y'); // Format for year

    String monthName = monthFormat.format(date);
    String year = yearFormat.format(date);

    return '$monthName $year';
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    String formattedDate = dateFormat.format(now);
    return formattedDate;
  }

  ///
  int calculateTotalTime(String arrivalTime, String departureTime,
      String actualArrivalTime, String actualDepartureTime) {
    // Convert arrival time to minutes
    List<String> arrivalParts = arrivalTime.split(":");
    int arrivalMinutes =
        int.parse(arrivalParts[0]) * 60 + int.parse(arrivalParts[1]);

    // Convert actual arrival time to minutes
    List<String> actualArrivalParts = actualArrivalTime.split(":");
    int actualArrivalMinutes = int.parse(actualArrivalParts[0]) * 60 +
        int.parse(actualArrivalParts[1]);

    // Convert departure time to minutes
    List<String> departureParts = departureTime.split(":");
    int departureMinutes =
        int.parse(departureParts[0]) * 60 + int.parse(departureParts[1]);

    // Convert actual departure time to minutes
    List<String> actualDepartureParts = actualDepartureTime.split(":");
    int actualDepartureMinutes = int.parse(actualDepartureParts[0]) * 60 +
        int.parse(actualDepartureParts[1]);

    // Calculate total time in minutes
    int totalTimeMinutes = actualDepartureMinutes - actualArrivalMinutes;

    return totalTimeMinutes;
  }

  //
  File? _image;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isButtonVisible = true;

  File? get image => _image;
  List<RoosterModel> _roosterList = [];

  List<RoosterModel> get roosters => _roosterList;

  DateTime? checkOutDateTime;
  DateTime now = DateTime.now();
  String? formattedTime;

  Future<void> fetchUsers() async {
    final snapshot = await FirebaseFirestore.instance.collection('users').get();
    final roosters = snapshot.docs.map((doc) {
      final id = doc.id;
      final morning = doc.data()['morningTime'] as String;
      final evening = doc.data()['eveningTime'] as String;
      return RoosterModel(id: id, morning: morning, evening: evening);
    }).toList();
    _roosterList = roosters;
    notifyListeners();
  }

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      _image = File(pickedImage.path);
      notifyListeners();
    }
  }

  Future<bool> isDateStored(String date) async {
    final collection = FirebaseFirestore.instance.collection('checkInOut');
    final querySnapshot =
        await collection.where('date', isEqualTo: date).limit(1).get();
    log("$querySnapshot", name: "QuerySnapShot");
    return querySnapshot.size > 0;
  }

  // add present here
  Stream<List<Map<String, dynamic>>> fetchCheckInTimes() {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('checkInOut');

    return collection
        .where('currentUserId', isEqualTo: _auth.currentUser!.uid)
        .snapshots()
        .map((snapshot) {
      List<Map<String, dynamic>> checkInRecords = [];
      DateTime currentMY = DateTime.now();
      myformattedMY = formatMonthAndYear(currentMY);

      for (QueryDocumentSnapshot documentSnapshot in snapshot.docs) {
        try {
          Map<String, dynamic>? rawData =
              documentSnapshot.data() as Map<String, dynamic>?;
          if (rawData != null) {
            Map<String, dynamic> data = rawData;
            String checkInTime = data['checkInTime'];
            String date = data['date'];
            String checkOutTime = data['checkOutTime'];
            String currentUserId = data['currentUserId'];
            String currentMY = data['currentMY'];
            bool isPresent = data['isPresent'];
            bool isAbsent = data['isAbsent'];
            bool isLeave = data['isLeave'];
            int unixTimestamp = data['unixTimestamp'];

            checkInRecords.add({
              'checkInTime': checkInTime,
              'date': date,
              'checkOutTime': checkOutTime,
              'currentUserId': currentUserId,
              'currentMY': currentMY,
              'isPresent': isPresent,
              'isAbsent': isAbsent,
              'isLeave': isLeave,
              'unixTimestamp': unixTimestamp
            });
          }
        } catch (error) {
          print('Error while parsing document data: $error');
        }
      }

      return checkInRecords;
    });
  }

  Stream<List<Map<String, dynamic>>> fetchCheckOutTimes() {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('checkInOut');
    return collection.snapshots().map((snapshot) {
      List<Map<String, dynamic>> checkInRecords = [];
      for (QueryDocumentSnapshot documentSnapshot in snapshot.docs) {
        Map<String, dynamic> data =
            (documentSnapshot.data() as Map<String, dynamic>);
        String checkOutTime = data['checkOutTime'];
        String date = data['date'];
        checkInRecords.add({
          'checkOutTime': checkOutTime,
          'date': date,
        });
      }
      return checkInRecords;
    });
  }

  String calculateLateTime(String arrivalTime, String actualArrivalTime) {
    // Convert arrival time to minutes
    List<String> arrivalParts = arrivalTime.split(":");
    int arrivalMinutes =
        int.parse(arrivalParts[0]) * 60 + int.parse(arrivalParts[1]);

    // Convert actual arrival time to minutes
    List<String> actualArrivalParts = actualArrivalTime.split(":");
    int actualArrivalMinutes = int.parse(actualArrivalParts[0]) * 60 +
        int.parse(actualArrivalParts[1]);

    // Calculate late time
    int lateTimeMinutes = actualArrivalMinutes - arrivalMinutes;

    // Convert late time to hours and minutes
    int hours = lateTimeMinutes ~/ 60;
    int minutes = lateTimeMinutes % 60;

    return "You arrived $hours Hr $minutes Min Late";
    // Display the late time
    print('The person arrived $hours hour(s) and $minutes minute(s) late.');
  }
}
