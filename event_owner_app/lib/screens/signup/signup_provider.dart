// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:event_owner_app/helper/exports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class SignUpProvider with ChangeNotifier {
  bool _obsecureText1 = true;

  bool get obsecureText1 => _obsecureText1;

  setObsecureText1(bool value) {
    _obsecureText1 = value;
    notifyListeners();
  }

  bool _obsecureText2 = true;

  bool get obsecureText2 => _obsecureText2;

  setObsecureText2(bool value) {
    _obsecureText2 = value;
    notifyListeners();
  }

  bool _showLoader = false;

  bool get showLoader => _showLoader;

  changeShowLoaderValue(bool value) {
    _showLoader = value;
    notifyListeners();
  }

  String _imageLink = "";

  String get imageLink => _imageLink;

  setImageLink(String value) {
    _imageLink = value;
    notifyListeners();
  }

  File _profileImage = File('');

  File get profileImage => _profileImage;

  signUp({
    required String email,
    required String password,
    required String restaurantName,
    required String ownerName,
    required String category,
    required String contact,
    required String address,
    required String description,
    required BuildContext context,
  }) async {
    try {
      changeShowLoaderValue(true);
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      )
          .then((value) {
        FirebaseAuth auth = FirebaseAuth.instance;
        FirebaseFirestore.instance
            .collection("owners")
            .doc(auth.currentUser!.uid)
            .set(
          {
            "id": auth.currentUser!.uid,
            "ownerName": ownerName,
            "email": email,
            "password": password,
            "restaurantName": restaurantName,
          },
        ).then((value) {
          FirebaseFirestore.instance.collection("restaurants").doc().set({
            "ownerId": auth.currentUser!.uid,
            "contact": contact,
            "restaurantName": restaurantName,
            "category": category,
            "image": imageLink,
            "restaurantAddress": address,
            "restaurantDescription": description,
          }).then((value) {
            changeShowLoaderValue(false);
            setImageLink("");
            _profileImage = File('');
            Navigator.pop(context);
            CommonFunctions.flushBarSuccessMessage(
                "SignUp Successful", context);
          });
        });
      });
    } on FirebaseAuthException catch (e) {
      changeShowLoaderValue(false);
      CommonFunctions.flushBarErrorMessage(
          e.message ?? "Error Occurred", context);
    }
  }

  imgFromCamera() async {
    try {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        final bytes = await image.readAsBytes();
        final kb = bytes.length / 1024;
        final mb = kb / 1024;

        if (kDebugMode) {
          print('original image size:$mb');
        }

        final dir = await path_provider.getTemporaryDirectory();
        final targetPath = '${dir.absolute.path}/temp.jpg';

        // converting original image to compress it
        final result = await FlutterImageCompress.compressAndGetFile(
          image.path,
          targetPath,
          minHeight: 1080, //you can play with this to reduce siz
          minWidth: 1080,
          quality: 90, // keep this high to get the original quality of image
        );

        final data = await result!.readAsBytes();
        final newKb = data.length / 1024;
        final newMb = newKb / 1024;
        if (kDebugMode) {
          print('compress image size:$newMb');
        }
        _profileImage = File(result.path);
        notifyListeners();
      }
    } catch (e) {
      print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
      print(e);
      print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
    }
  }

  imgFromGallery() async {
    try {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        final bytes = await image.readAsBytes();
        final kb = bytes.length / 1024;
        final mb = kb / 1024;

        if (kDebugMode) {
          print('original image size:$mb');
        }

        final dir = await path_provider.getTemporaryDirectory();
        final targetPath = '${dir.absolute.path}/temp.jpg';

        // converting original image to compress it
        final result = await FlutterImageCompress.compressAndGetFile(
          image.path,
          targetPath,
          minHeight: 1080, //you can play with this to reduce siz
          minWidth: 1080,
          quality: 90, // keep this high to get the original quality of image
        );

        final data = await result!.readAsBytes();
        final newKb = data.length / 1024;
        final newMb = newKb / 1024;
        if (kDebugMode) {
          print('compress image size:$newMb');
        }
        _profileImage = File(result.path);
        notifyListeners();
      }
    } catch (e) {
      print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
      print(e);
      print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
    }
  }
}
