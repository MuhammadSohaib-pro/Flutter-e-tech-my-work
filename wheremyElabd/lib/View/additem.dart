import 'package:flutter/material.dart';
import 'package:wheremyelabd/Component/addingitemstoragecomponet.dart';
import 'package:wheremyelabd/Component/custombutton.dart';
import 'package:wheremyelabd/Component/customdescriptiontfield.dart';
import 'package:wheremyelabd/Component/textfieldcustom.dart';
import 'package:wheremyelabd/Utils/appcolor.dart';
import 'package:wheremyelabd/View/homescreen.dart';
import 'package:wheremyelabd/boxes/boxes.dart';
import 'package:wheremyelabd/models/storage_model.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Import for File class

import 'package:shared_preferences/shared_preferences.dart';


class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  // use dateformate to formating
  final dateTimeFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  List<String> storagePlaces = [];
  String? selectedStoragePlace;
  TextEditingController itemNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? _imagePath;
  String? description;
  int? countitem;
  @override
  void initState() {
    super.initState();
    fetchStoragePlaces();
  }

  //fetch storage places
  Future<void> fetchStoragePlaces() async {
    final box = Boxes.getData();
    final storageData = box.values.toList().cast<StorageModel>();
    setState(() {
      storagePlaces = storageData.map((storage) => storage.storageplacename).toList();
    });
  }




// image picker function
  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Image Source"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(ImageSource.camera);
              },
              child: Text("Camera"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(ImageSource.gallery);
              },
              child: Text("Gallery"),
            ),
          ],
        );
      },
    );

    if (source != null) {
      final pickedFile = await imagePicker.pickImage(source: source);
      if (pickedFile != null) {
        final imagePath = pickedFile.path;

        // Save the image path to shared preferences
        await saveImagePathToSharedPreferences(imagePath);

        // Update the UI with the selected image
        setState(() {
          _imagePath = imagePath;
          print(_imagePath);
        });
      }
    }
  }

  //save image to local storage path
  Future<void> saveImagePathToSharedPreferences(String imagePath) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('image_path', imagePath);
    print(imagePath);
  }

  //save items to selected storage place
  void saveItemToStoragePlace() {
    if (selectedStoragePlace != null) {
      final box = Boxes.getData();
      final selectedStorage = box.values.firstWhere(
            (storage) => storage.storageplacename == selectedStoragePlace,
        orElse: () => StorageModel(
          storageplacename: selectedStoragePlace!,
          itemcount: 0, // Set the default item count to 0 or any other suitable value
          description: '', // Set the default description to an empty string or any other suitable value
          items: [],
        ),
      );

      final data = StorageModel(
        storageplacename: selectedStoragePlace!,
        itemcount: selectedStorage.itemcount,
        description: selectedStorage.description, // Use the description from the selected storage place
        items: [
          ItemModel(
            itemName: itemNameController.text,
            itemDescription: descriptionController.text,
            imagePath: _imagePath.toString(),
            time: dateTimeFormatter.format(DateTime.now()), // Assign the picture path here
          ),
          ...selectedStorage.items, // Add the existing items from the selected storage
        ],
      );

      // Remove the old storage model and add the updated one
      box.delete(selectedStorage.key);
      box.add(data);

      print(box);

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ));
    } else {
      // Handle the case where no storage place is selected.
      // You can show an error message or take appropriate action.
    }
  }

  @override
  void dispose() {
    itemNameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ItemStorageCom(
                  title: 'Add Item to Storage',
                  onQuestionMarkPress: () {
                    // Handle question mark icon press
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
              GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  children: [
                    //set image fot item
                    CircleAvatar(
                      radius: screenSize.width * 0.08,
                      backgroundImage: _imagePath != null && File(_imagePath!).existsSync()
                          ? FileImage(File(_imagePath.toString()))
                          : AssetImage('assets/noimage.jpg')  as ImageProvider,
                    ),

                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 35,
                        height: 40,
                        decoration: BoxDecoration(

                          shape: BoxShape.circle,
                          color: Colors.grey[350],
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.add_a_photo_outlined,
                            color: Colors.blue,
                            size: 20,
                          ),
                          onPressed: _pickImage,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
                SizedBox(height: 10),
                //drop sown button show to storage places
                DropdownButtonHideUnderline(
                  child: Container(
                    width: 351,
                    height: 68,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButton<String>(
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Color(0xFF796D61),
                              ),
                              iconSize: 24,
                              elevation: 0,
                              style: const TextStyle(
                                color: Color(0xFF796D61),
                                fontSize: 16,
                              ),
                              dropdownColor: Colors.grey[200],
                              hint: Text(
                                "Select storage place",
                                style: TextStyle(
                                  color: Color(0xFF796D61),
                                ),
                              ),
                              value: selectedStoragePlace,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedStoragePlace = newValue;
                                });
                              },
                              items: storagePlaces.map((place) {
                                return DropdownMenuItem<String>(
                                  value: place,
                                  child: Text(
                                    place,
                                    style: const TextStyle(
                                      color: Color(0xFF796D61),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: itemNameController,
                  hintText: 'Item name',

                ),
                const SizedBox(
                  height: 10,
                ),
                CustomDescriptionField(
                  controller: descriptionController,
                  hintText: 'Description goes here',
                ),

                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: 'Add Item',
                  textColor: Colors.white,
                  containerColor: AppColors.buttoncolor,
                  onPressed: saveItemToStoragePlace,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }




}
