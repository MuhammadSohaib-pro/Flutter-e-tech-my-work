import 'dart:io';

import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:image_picker/image_picker.dart';

class PickImage with ChangeNotifier{

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

  uploadImagetoFirebaseStorage(File file) {}


}