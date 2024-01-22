import 'dart:io';
// ignore: depend_on_referenced_packages, library_prefixes
import 'package:elabd_ems_admin/view/profile/profile_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddEmployeProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  File? _profileImage;
  File? get profileImage => _profileImage;

  void setImage(File image) {
    _profileImage = image;
    notifyListeners();
  }

  void pickImage(ImageSource source, BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      _profileImage = File(pickedFile.path);
      notifyListeners();
      Navigator.pop(context);
    } else {
      debugPrint('Error White packing image');
    }
  }

  Future<String> uploadImagetoFirebaseStorage(File? image) async {
    SmartDialog.showLoading();
    String imageURL = '';
    String fileName = Path.basename(image!.path);
    var reference =
        FirebaseStorage.instance.ref().child('profileImages/$fileName');
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    await taskSnapshot.ref.getDownloadURL().then((value) {
      imageURL = value;
    }).catchError((e) {
      debugPrint('Error happened $e.toString()');
      SmartDialog.dismiss();
    });

    return imageURL;
  }

  //   Stream<List<EmployeeModel>> streamPosts() {
  //   return FirebaseFirestore.instance
  //       .collection("employees")
  //       .snapshots()
  //       .map((event) =>
  //           event.docs.map((e) => EmployeeModel.fromJson(e.data())).toList())
  //       .handleError((error) => Stream.value(EmployeeModel(
  //       )));
  // }

  // sigin up user and add new employee

  // Future<String> signUpUser({
  //   required String email,
  //   required String password,
  //   // required String bio,
  //   // required Uint8List file,
  // }) async {
  //   try {
  //     if (email.isNotEmpty && password.isNotEmpty) {
  //       // registering user in auth with email and password
  //       UserCredential cred = await _auth.createUserWithEmailAndPassword(
  //         email: email,
  //         password: password,
  //       );
  //       model.UserModel _user = model.UserModel(
  //         id: cred.user!.uid,
  //         email: email,
  //         lastMessageTime: DateTime.now(),
  //         status: 'offline',
  //       );
  //       // adding user in our database
  //       await _firestore
  //           .collection("users")
  //           .doc(cred.user!.uid)
  //           .set(_user.toJson());
  //       return "success";
  //     } else {
  //       return "Please enter all the fields";
  //     }
  //   } on FirebaseException catch (err) {
  //     return err.toString();
  //   }
  // }

  // Future<void> addNewEmploye({
  //   required context,
  //   String? teamId,
  //   Timestamp? date,
  //   String? id,
  //   String? imageUrl,
  //   String? fullName,
  //   String? email,
  //   String? contact,
  //   String? address,
  //   String? status,
  //   String? salary,
  //   String? type,
  //   String? role,
  //   String? team,
  //   String? joinDate,
  //   String? password,
  //   String? fcmToken,
  // }) async {
  //   SmartDialog.showLoading();
  //   try {
  //     _auth
  //         .createUserWithEmailAndPassword(
  //       email: email!,
  //       password: password!,
  //     )
  //         .then((value) async {
  //       /// This is what when you store this data into cloud_firestore
  //       // var userID = FirebaseAuth.instance.currentUser!.uid;
  //       var uuid = const Uuid();
  //       String userID = uuid.v4();
  //       await _firestore.collection("employees").doc(userID).set({
  //         'name': fullName,
  //         'email': email,
  //         'address': address,
  //         'contact': contact,
  //         'id': userID,
  //         'image': imageUrl,
  //         'joinDate': joinDate,
  //         'status': 'Active',
  //         'salary': salary,
  //         'team': team,
  //         'teamId': teamId,
  //         'type': type,
  //         'role': 'user',
  //         'date': DateTime.now(),
  //         'fcmToken': '',
  //         'accountTitle': '',
  //         'accountNo': '',
  //         'iban': '',
  //         'bankName': '',
  //         'salaryStatus': 'UnPaid',
  //       });
  //       // await FirebaseFirestore.instance
  //       //     .collection('employees')
  //       //     .doc(userID)
  //       //     .set({
  //       //   'id': userID,
  //       //   "image": imageUrl,
  //       //   "name": fullName,
  //       //   "email": email,
  //       //   "contact": contact,
  //       //   "address": address,
  //       //   "status": status,
  //       //   "type": type,
  //       //   "team": team,
  //       //   "joinDate": joinDate,
  //       //   'teamId': teamId,
  //       //   "role": "User",
  //       // });
  //     }).then((value) {
  //       FirebaseFirestore.instance.collection('teams').doc(teamId).update({
  //         'uids':
  //             FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
  //       });
  //     }).then((value) {
  //       SmartDialog.dismiss();
  //       getFlushBar(context,
  //           title: 'Successfully Saved', color: primaryColor, isSuccess: true);
  //     }).onError((error, stackTrace) {
  //       SmartDialog.dismiss();
  //       getFlushBar(context, title: error.toString());
  //     });
  //   } catch (e) {
  //     SmartDialog.dismiss();
  //     getFlushBar(context, title: e.toString());
  //   }
  // }
  Future<void> addNewEmploye({
    required context,
    String? teamId,
    Timestamp? date,
    String? id,
    String? imageUrl,
    String? fullName,
    String? email,
    String? contact,
    String? address,
    String? status,
    String? salary,
    String? type,
    String? role,
    String? team,
    String? joinDate,
    String? password,
    String? fcmToken,
  }) async {
    SmartDialog.showLoading();
    FirebaseApp app = await Firebase.initializeApp(
        name: 'Secondary', options: Firebase.app().options);
    try {
      var userId;
      await FirebaseAuth.instanceFor(app: app)
          .createUserWithEmailAndPassword(email: email!, password: password!)
          .then((value) {
         userId = value.user!.uid.toString();
        FirebaseFirestore.instance
            .collection('employees')
            .doc(userId)
            .set({
          'name': fullName,
          'email': email,
          'address': address,
          'contact': contact,
          // 'id': value.user!.uid.toString(),
          'id':userId,
          'image': imageUrl,
          'joinDate': joinDate,
          'status': 'Active',
          'salary': salary,
          'team': team,
          'teamId': teamId,
          'type': type,
          'role': 'user',
          'date': DateTime.now(),
          'fcmToken': '',
          'accountTitle': '',
          'accountNo': '',
          'iban': '',
          'bankName': '',
          'salaryStatus': 'UnPaid',
        }).then((value) {
          FirebaseFirestore.instance.collection('teams').doc(teamId).update({
            'uids': FieldValue.arrayUnion([userId])
          });
        }).then((value) {
          SmartDialog.dismiss();
          getFlushBar(context,
              title: 'Successfully Saved',
              color: primaryColor,
              isSuccess: true);
        });
      });
    } on FirebaseAuthException catch (e) {
      SmartDialog.dismiss();
      if (e.code == "email-already-in-use") {
        getFlushBar(context, title: "Email already in use , try another email");
      } else if (e.code == "wrong-password") {
        getFlushBar(context, title: "Wrong Password , Try Again");
      }
      // Do something with exception. This try/catch is here to make sure
      // that even if the user creation fails, app.delete() runs, if is not,
      // next time Firebase.initializeApp() will fail as the previous one was
      // not deleted.
    }
    await app.delete();
  }

  Future<void> updateEmployee({
    required String id,
    required BuildContext context,
    required String address,
    required String contact,
    required String email,
    required String fullName,
    required String imageUrl,
    required String joinDate,
    required String salary,
    required String team,
    required String type,
    required String teamId,
    required String password,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('employees').doc(id).update({
        'address': address,
        'contact': contact,
        'email': email,
        'fullName': fullName,
        'imageUrl': imageUrl,
        'joinDate': joinDate,
        'salary': salary,
        'team': team,
        'type': type,
        'teamId': teamId,
        'password': password,
      });
      getFlushBar(context, title: 'Employee updated successfully');
    } catch (e) {
      getFlushBar(context, title: 'Error updating employee: $e');
    }
  }

  Future<void> addNewTeam(
      {required context,
      String? id,
      String? imageUrl,
      String? teamName,
      List? uids}) async {
    // SmartDialog.showLoading();
    try {
      await FirebaseFirestore.instance.collection('teams').doc(id).set({
        'teamId': id,
        "image": imageUrl,
        'teamName': teamName,
        'uids': uids,
      }).then((value) {
        SmartDialog.dismiss();
        getFlushBar(context, title: 'Successfully Saved', color: primaryColor);
      }).onError((error, stackTrace) {
        SmartDialog.dismiss();
        getFlushBar(context, title: error.toString());
      });
    } catch (e) {
      SmartDialog.dismiss();
      getFlushBar(context, title: e.toString());
    }
  }

  // uploadProfileData({
  //   required BuildContext context,
  //   String? imageurl,
  //   String? fullName,
  //   // String? email,
  //   String? contactNumber,
  //   String? address,
  //   String? type,
  //   String? joinDate,
  //   // String? password,
  // }) {
  //   SmartDialog.showLoading();
  //   String uid = FirebaseAuth.instance.currentUser!.uid;
  //   FirebaseFirestore.instance.collection('employees').doc(uid).set({
  //     'image': imageurl,
  //     'fullName': fullName,
  //     // 'email': email,
  //     'contactNumber': contactNumber,
  //     'address': address,
  //     'type': type,
  //     'joinDate': joinDate,
  //     // 'password': password,
  //   }).then((value) {
  //     SmartDialog.dismiss();
  //     getFlushBar(context, title: 'Successfully added');
  //   }).onError((error, stackTrace) {
  //     SmartDialog.dismiss();
  //     print('Error $error');
  //   });
  // }
}
