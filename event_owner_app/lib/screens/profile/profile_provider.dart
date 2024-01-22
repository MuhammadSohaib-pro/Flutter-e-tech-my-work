// ignore_for_file: use_build_context_synchronously

import 'package:event_owner_app/helper/exports.dart';
import 'package:event_owner_app/model/profile_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:image_picker/image_picker.dart';

class ProfileProvider with ChangeNotifier {
  bool _editFlag = false;

  bool get editFlag => _editFlag;

  setEditFlag(bool value) {
    _editFlag = value;
    notifyListeners();
  }

  bool _obsecureText = true;

  bool get obsecureText => _obsecureText;

  setObsecureText(bool value) {
    _obsecureText = value;
    notifyListeners();
  }

  String _imageLink = "";

  String get imageLink => _imageLink;

  setImageLink(String value) {
    _imageLink = value;
    notifyListeners();
  }

  setProfileImage(File value) {
    _profileImage = value;
    notifyListeners();
  }

  File _profileImage = File('');

  File get profileImage => _profileImage;

  bool _showLoader = false;

  bool get showLoader => _showLoader;

  changeShowLoaderValue(bool value) {
    _showLoader = value;
    notifyListeners();
  }

  ProfileModel obj = ProfileModel();
  setProfileObject() {
    obj = ProfileModel();
    notifyListeners();
  }

  Future<void> updateProfileAndRestaurant({
    required String email,
    required String password,
    required String restaurantName,
    required String ownerName,
    required String category,
    required String contact,
    required String address,
    required String description,
    required String reference,
    required BuildContext context,
  }) async {
    try {
      changeShowLoaderValue(true);
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore.instance
          .collection("owners")
          .doc(auth.currentUser!.uid)
          .update(
        {
          "id": auth.currentUser!.uid,
          "ownerName": ownerName,
          "email": email,
          "password": password,
          "restaurantName": restaurantName,
        },
      ).then((value) {
        FirebaseFirestore.instance
            .collection("restaurants")
            .doc(reference)
            .update({
          "ownerId": auth.currentUser!.uid,
          "contact": contact,
          "restaurantName": restaurantName,
          "catergory": category,
          "image": imageLink.isNotEmpty ? imageLink : obj.restaurantImage,
          "restaurantAddress": address,
          "restaurantDescription": description,
        }).then((value) {
          changeShowLoaderValue(false);
          setImageLink("");
          _profileImage = File('');
          obj = ProfileModel();
          CommonFunctions.flushBarSuccessMessage(
              "Profile Updated Successfully", context);
        });
      });
    } on FirebaseAuthException catch (e) {
      changeShowLoaderValue(false);
      CommonFunctions.flushBarErrorMessage(
          e.message ?? "Error Occurred", context);
    }
  }

  Future<void> deletePreviousImage(String imageUrl) async {
    try {
      changeShowLoaderValue(true);
      if (imageUrl.isNotEmpty) {
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference reference = storage.refFromURL(imageUrl);
        try {
          await reference.delete();
          print('Previous image deleted successfully.');
        } catch (e) {
          print('Error deleting previous image: $e');
        }
      }
    } catch (e) {
      changeShowLoaderValue(false);
      print('Error deleting previous image: $e');
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
