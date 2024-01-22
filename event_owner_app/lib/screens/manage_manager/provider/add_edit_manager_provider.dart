// ignore_for_file: use_build_context_synchronously
import 'package:event_owner_app/helper/exports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class AddEditManagerProvider with ChangeNotifier {
  String _imageLink = "";

  String get imageLink => _imageLink;

  setImageLink(String value) {
    _imageLink = value;
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

  ManagerModel obj = ManagerModel();

  Future<void> addNewManager({
    required String managerName,
    required String email,
    required String address,
    required String phone,
    required BuildContext context,
  }) async {
    try {
      changeShowLoaderValue(true);
      String ref = "";
      var fs2 =
          await FirebaseFirestore.instance.collection("restaurants").get();
      var data = fs2.docs;
      for (var i = 0; i < data.length; i++) {
        if (FirebaseAuth.instance.currentUser!.uid == data[i].get("ownerId")) {
          ref = data[i].reference.id;
        }
      }

      await FirebaseFirestore.instance
          .collection("restaurants")
          .doc(ref)
          .collection("managers")
          .doc()
          .set(
        {
          "image": imageLink,
          "managerName": managerName,
          "mangerEmail": email,
          "address": address,
          "contact": phone,
          "activeOrDeactive": "Active",
          "deleteStatus": "notDeleted"
        },
      ).then((value) {
        changeShowLoaderValue(false);
        setImageLink("");
        _profileImage = File('');
        Navigator.pop(context);
        CommonFunctions.flushBarSuccessMessage(
            "Manager Added Successfully", context);
      });
    } on FirebaseException catch (e) {
      changeShowLoaderValue(false);
      CommonFunctions.flushBarErrorMessage(e.code, context);
    }
  }

  Future<void> editNewManager({
    required String managerName,
    required String email,
    required String address,
    required String reference,
    required String phone,
    required BuildContext context,
  }) async {
    try {
      changeShowLoaderValue(true);
      String ref = "";
      var fs2 =
          await FirebaseFirestore.instance.collection("restaurants").get();
      var data = fs2.docs;
      for (var i = 0; i < data.length; i++) {
        if (FirebaseAuth.instance.currentUser!.uid == data[i].get("ownerId")) {
          ref = data[i].reference.id;
        }
      }
      await FirebaseFirestore.instance
          .collection("restaurants")
          .doc(ref)
          .collection("managers")
          .doc(reference)
          .update(
        {
          "image": obj.image,
          "managerName": managerName,
          "mangerEmail": email,
          "address": address,
          "contact": phone,
        },
      ).then((value) {
        changeShowLoaderValue(false);
        setImageLink("");
        _profileImage = File('');
        Navigator.pop(context);
        CommonFunctions.flushBarSuccessMessage(
            "Manager Updated Successfully", context);
      });
    } on FirebaseException catch (e) {
      changeShowLoaderValue(false);
      CommonFunctions.flushBarErrorMessage(e.code, context);
    }
  }

  Future<void> activeDeactiveManager({
    required String activeDeactive,
    required String managerRef,
    required String restaurantRef,
    required BuildContext context,
  }) async {
    try {
      changeShowLoaderValue(true);
      await FirebaseFirestore.instance
          .collection("restaurants")
          .doc(restaurantRef)
          .collection("managers")
          .doc(managerRef)
          .update(
        {
          "activeOrDeactive": activeDeactive,
        },
      ).then((value) {
        changeShowLoaderValue(false);
        setImageLink("");
        _profileImage = File('');
        Navigator.pop(context);
        CommonFunctions.flushBarSuccessMessage(
            "Status Change Successfully", context);
      });
    } on FirebaseException catch (e) {
      changeShowLoaderValue(false);
      CommonFunctions.flushBarErrorMessage(e.code, context);
    }
  }

  Future<void> deleteManager({
    required String ref,
    required String deleteStatus,
    required BuildContext context,
  }) async {
    try {
      changeShowLoaderValue(true);
      String reference = "";
      var fs2 =
          await FirebaseFirestore.instance.collection("restaurants").get();
      var data = fs2.docs;
      for (var i = 0; i < data.length; i++) {
        if (FirebaseAuth.instance.currentUser!.uid == data[i].get("ownerId")) {
          reference = data[i].reference.id;
        }
      }
      await FirebaseFirestore.instance
          .collection("restaurants")
          .doc(reference)
          .collection("managers")
          .doc(ref)
          .update({"deleteStatus": deleteStatus}).then((value) {
        changeShowLoaderValue(false);
        setImageLink("");
        _profileImage = File('');
        Navigator.popUntil(context, (route) => route.isFirst);
        CommonFunctions.flushBarSuccessMessage(
            "Manager Deleted Successfully", context);
      });
    } on FirebaseException catch (e) {
      changeShowLoaderValue(false);
      CommonFunctions.flushBarErrorMessage(e.code, context);
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
