// ignore_for_file: use_build_context_synchronously

import 'package:event_owner_app/helper/exports.dart';
import 'package:event_owner_app/model/item_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class AddEditServicesProvider with ChangeNotifier {
  String _totalCategory = "";

  String get totalCategory => _totalCategory;

  setTotalCategory(String value) {
    _totalCategory = value;
    notifyListeners();
  }

  String _categoryRef = "";

  String get categoryReference => _categoryRef;

  setCategoryReference(String value) {
    _categoryRef = value;
  }

  setNotifyCategoryReference(String value) {
    _categoryRef = value;
    notifyListeners();
  }

  String _selectedCategory = "";

  String get selectedCategry => _selectedCategory;

  setCategory(String value) {
    _selectedCategory = value;
  }

  setCategoryNotify(String value) {
    _selectedCategory = value;
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

  bool _showLoader = false;

  bool get showLoader => _showLoader;

  ItemModel obj = ItemModel();

  changeShowLoaderValue(bool value) {
    _showLoader = value;
    notifyListeners();
  }

  Future<void> fetchSomething() async {
    String ref = "";
    var fs2 = await FirebaseFirestore.instance.collection("restaurants").get();
    var data1 = fs2.docs;
    for (var i = 0; i < data1.length; i++) {
      if (FirebaseAuth.instance.currentUser!.uid == data1[i].get("ownerId")) {
        ref = data1[i].reference.id;
      }
    }
    var firestore = await FirebaseFirestore.instance
        .collection("restaurants")
        .doc(ref)
        .collection("services")
        .get();
    if (firestore.docs.isNotEmpty) {
      _categoryRef = firestore.docs.first.reference.id;
      _selectedCategory = firestore.docs.first.get("categoryName");
    }
    notifyListeners();
  }

  Future<void> getKitchens() async {
    String ref = "";
    var fs2 = await FirebaseFirestore.instance.collection("restaurants").get();
    var data1 = fs2.docs;
    for (var i = 0; i < data1.length; i++) {
      if (FirebaseAuth.instance.currentUser!.uid == data1[i].get("ownerId")) {
        ref = data1[i].reference.id;
      }
    }
    var firestore = await FirebaseFirestore.instance
        .collection("restaurants")
        .doc(ref)
        .collection("services")
        .get();
    setTotalCategory(firestore.docs.isEmpty ? "" : "abc");
    notifyListeners();
  }

  Future<void> addNewCategory({
    required String categoryName,
    required String restaurantCategory,
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
          .collection(restaurantCategory)
          .doc()
          .set(
        {
          "categoryName": categoryName,
        },
      ).then((value) {
        changeShowLoaderValue(false);
        setImageLink("");
        _profileImage = File('');
        Navigator.pop(context);
        CommonFunctions.flushBarSuccessMessage(
            "Category Added Successfully", context);
      });
    } on FirebaseException catch (e) {
      changeShowLoaderValue(false);
      CommonFunctions.flushBarErrorMessage(e.code, context);
    }
  }

  Future<void> editCategory({
    required String categoryName,
    required String restaurantCategory,
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
          .collection(restaurantCategory)
          .doc(_categoryRef)
          .update(
        {
          "categoryName": categoryName,
        },
      ).then((value) {
        changeShowLoaderValue(false);
        setImageLink("");
        _profileImage = File('');
        Navigator.pop(context);
        CommonFunctions.flushBarSuccessMessage(
            "Category Updated Successfully", context);
      });
    } on FirebaseException catch (e) {
      changeShowLoaderValue(false);
      CommonFunctions.flushBarErrorMessage(e.code, context);
    }
  }

  Future<void> addNewItems({
    required String itemName,
    required double itemPrice,
    required String itemDescription,
    required String selectedCategoryDoc,
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
          .collection("serviceItems")
          .doc()
          .set(
        {
          "itemImage": _imageLink,
          "itemName": itemName,
          "itemPrice": itemPrice,
          "selectedCategoryDoc": selectedCategoryDoc,
          "itemDescription": itemDescription,
        },
      ).then((value) {
        changeShowLoaderValue(false);
        setImageLink("");
        _profileImage = File('');
        Navigator.pop(context);
        CommonFunctions.flushBarSuccessMessage(
            "Items Added Successfully", context);
      });
    } on FirebaseException catch (e) {
      changeShowLoaderValue(false);
      CommonFunctions.flushBarErrorMessage(e.code, context);
    }
  }

  Future<void> editItems({
    required String itemName,
    required double itemPrice,
    required String itemDescription,
    required String selectedCategoryDoc,
    required String itemReference,
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
          .collection("serviceItems")
          .doc(itemReference)
          .update(
        {
          "itemImage": obj.itemImage,
          "itemName": itemName,
          "itemPrice": itemPrice,
          "selectedCategoryDoc": selectedCategoryDoc,
          "itemDescription": itemDescription,
        },
      ).then((value) {
        changeShowLoaderValue(false);
        setImageLink("");
        _profileImage = File('');
        Navigator.pop(context);
        CommonFunctions.flushBarSuccessMessage(
            "Items Updated Successfully", context);
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

        final dir = await getTemporaryDirectory();
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

        final dir = await getTemporaryDirectory();
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
