import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheremyelabd/Component/custombutton.dart';
import 'package:wheremyelabd/Utils/textstyle.dart';
import 'package:wheremyelabd/View/homescreen.dart';
import 'package:wheremyelabd/boxes/boxes.dart';
import 'package:wheremyelabd/models/storage_model.dart';


class EditProfile extends StatefulWidget {
  final String myVariable;
  final String email;
  final String country;
  final String description;
  final String profilepicture;
  final VoidCallback onUpdateProfile;
  final String? userId;
  const EditProfile({Key? key,
    required this.myVariable,
    required this.userId,
    required this.onUpdateProfile,
    required this.email,
    required this.country,
    required this.description, required this.profilepicture}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? pathpicture;

  @override
  void initState() {
    super.initState();
    nameController.text= widget.myVariable;
    emailController.text=widget.email;
    countryController.text=widget.country;
    descriptionController.text=widget.description;
    pathpicture=widget.profilepicture;
  }
  String? _ImagePath;

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
          _ImagePath = imagePath;
          print(_ImagePath);
        });
      }
    }
  }
 // save image to a local storage path
  Future<void> saveImagePathToSharedPreferences(String imagePath) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('image_path', imagePath);
    print(imagePath);
  }
 // Initialize a variable to store the text data

  String? nameError;
  String? emailError;
  String? countryError;
  String? descriptionError;


  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed from the tree
    nameController.dispose();
    emailController.dispose();
    descriptionController.dispose();
    countryController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child:  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 25,
                    ),
                    child: Row(
                      children: [
                        //back arrow to back page
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pop();
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[350],
                            ),
                            child: const Icon(Icons.arrow_back_ios_new),
                          ),
                        ),
                        const SizedBox(
                          width: 75,
                        ),
                        const Center(
                          child: Text(
                            'Update Profile',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF573353),
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              height: 0.10,
                              letterSpacing: -0.54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: _pickImage,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                // if user not set image then set domy image ,if user pick image then set image
                                radius: screenSize.width * 0.14,
                                backgroundImage: _ImagePath != null && File(_ImagePath!).existsSync()
                                    ? FileImage(File(_ImagePath.toString()))
                                    : FileImage(File(pathpicture.toString()))  as ImageProvider,
                              ),

                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[350],
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Colors.blue,
                                      size: 24,
                                    ),
                                    onPressed: _pickImage,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Text(
                          widget.myVariable,
                          textAlign: TextAlign.center,
                          style: MyTextStyles.namestyle(17.0),
                        ),
                        const SizedBox(height: 20,),
 
                        // validate the text fields must be not empty ,or .com or @ etc check 
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Container(
                                  width: 351,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding:const EdgeInsets.symmetric(horizontal: 10) ,
                                    child: TextFormField(
                                      //name text field
                                      controller: nameController,
                                      style: MyTextStyles.settingsblacklit,
                                      decoration: InputDecoration(
                                        hintText: 'Enter Name',
                                        errorText: nameError,
                                        hintStyle:MyTextStyles.hinttextfield(16.0),

                                      ),
                                      cursorColor: Colors.blue,
                                      showCursor: true,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Name cannot be empty';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 351,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding:const EdgeInsets.symmetric(horizontal: 10) ,
                                    child: TextFormField(
                                      //email text field 
                                      controller: emailController,
                                      style:MyTextStyles.settingsblacklit,
                                      decoration: InputDecoration(
                                        hintText: 'Enter Email',
                                        errorText: emailError,
                                        hintStyle:MyTextStyles.hinttextfield(16.0),
                                      ),
                                      cursorColor: Colors.blue,
                                      showCursor: true,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Email cannot be empty';
                                        } else if (!value.contains('@') || !value.contains('.com')) {
                                          return 'Invalid email format';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 351,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding:const EdgeInsets.symmetric(horizontal: 10) ,
                                    child: TextFormField(
                                      //country text feild
                                      controller: countryController,
                                      style:MyTextStyles.settingsblacklit,
                                      decoration: InputDecoration(
                                        hintText: 'Enter Country',
                                        errorText: countryError,
                                        hintStyle:MyTextStyles.hinttextfield(16.0),
                                      ),
                                      cursorColor: Colors.blue,
                                      showCursor: true,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Country cannot be empty';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 351,
                                  height: 175,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: TextFormField(
                                      //description text field
                                      controller: descriptionController,
                                      style: MyTextStyles.settingsblacklit,
                                      decoration: InputDecoration(
                                        hintText: 'Description goes here',
                                        errorText: descriptionError,
                                        hintStyle:MyTextStyles.hinttextfield(16.0),
                                      ),
                                      cursorColor: Colors.blue,
                                      showCursor: true,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Description cannot be empty';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),

                              ],
                            ),

                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        //update button and if all field complete all checks then userprofile will updated
                        CustomButton(
                          text: 'Update',
                          textColor: Colors.white,
                          containerColor: const Color(0xFF57C4E5),

                          onPressed: () async {
                           if (_formKey.currentState!.validate()) {

                             final box = Boxes.getEditprofile();
                             const key = 'editProfile';
                             editprofile? existingData = box.get(key);
                             //if user not empty
                             if (existingData != null) {
                               // Modify the existing profile
                               existingData.imagePath = _ImagePath.toString();
                               print(_ImagePath.toString());
                               existingData.name = nameController.text.toString();
                               existingData.email = emailController.text.toString();
                               existingData.description = descriptionController.text.toString();
                               existingData.country = countryController.text.toString();
                               box.put(key, existingData);
                               print(box.values);
                               print(existingData);
                               print('if');
                            // Update the user's data in the "users" collection
                            await FirebaseFirestore.instance.collection('users').doc('${widget.userId}').update({
                            'editProfileData': {
                            'imagePath': _ImagePath.toString(),
                            'name': nameController.text.toString(),
                            'email': emailController.text.toString(),
                            'description': descriptionController.text.toString(),
                            'country': countryController.text.toString(),
                            },
                            });

                             } else {
                               final data = editprofile(
                                 imagePath: _ImagePath.toString(),
                                 name: nameController.text.toString(),
                                 email: emailController.text.toString(),
                                 description: descriptionController.text.toString(),
                                 country: countryController.text.toString(),
                               );
                               box.put(key, data);
                               print(box.values);
                               print(data);
                               print('else');
                            // Update the user's data in the "users" collection
                            await FirebaseFirestore.instance.collection('users').doc('${widget.userId}').set({
                            'editProfileData': {
                            'imagePath': _ImagePath.toString(),
                            'name': nameController.text.toString(),
                            'email': emailController.text.toString(),
                            'description': descriptionController.text.toString(),
                            'country': countryController.text.toString(),
                            },
                            });
                             }
                             setState(() {
                               widget.onUpdateProfile();
                               Navigator.of(context).push(MaterialPageRoute(
                                 builder: (context) => HomeScreen(userId: widget.userId,),
                               ));
                             });
                           }


                            },
                             // Use AssetImage
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),

    );
  }
}
