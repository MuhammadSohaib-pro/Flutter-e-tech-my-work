import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';

class PickImage with ChangeNotifier {
  File? _profileImage;
  File? get profileImage => _profileImage;

  void setImage(File image) {
    _profileImage = image;
    notifyListeners();
  }

  void pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _profileImage = File(pickedFile.path);
      notifyListeners();
    } else {
      debugPrint('Error White packing image');
    }
  }

  Future<String> uploadImagetoFirebaseStorage(File? image) async {
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
    });

    return imageURL;
  }

  Future<void> resetPasswor(
      {required BuildContext context, String? email}) async {
    var auth = FirebaseAuth.instance;
    try {
      auth.sendPasswordResetEmail(email: email!).then((value) {
        Fluttertoast.showToast(msg: 'We have sent password reset email');
      });
    } catch (e) {
     Fluttertoast.showToast(msg: 'Error $e');
    }
  }
}
