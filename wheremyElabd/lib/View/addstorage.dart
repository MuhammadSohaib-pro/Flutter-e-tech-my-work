import 'package:flutter/material.dart';
import 'package:wheremyelabd/Component/addingitemstoragecomponet.dart';
import 'package:wheremyelabd/Component/custombutton.dart';
import 'package:wheremyelabd/Component/customdescriptiontfield.dart';
import 'package:wheremyelabd/Component/textfieldcustom.dart';
import 'package:wheremyelabd/Utils/appcolor.dart';
import 'package:wheremyelabd/Utils/textstyle.dart';
import 'package:wheremyelabd/View/homescreen.dart';
import 'package:wheremyelabd/boxes/boxes.dart';
import 'package:wheremyelabd/models/storage_model.dart';

class AddStorage extends StatefulWidget {
  const AddStorage({Key? key}) : super(key: key);

  @override
  State<AddStorage> createState() => _AddStorageState();
}

class _AddStorageState extends State<AddStorage> {

  final TextEditingController storageNameController = TextEditingController();
  final TextEditingController maxItemCountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed from the tree
    storageNameController.dispose();
    maxItemCountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SafeArea(
            child: Column(

              children: [
                ItemStorageCom(
                  title: 'Add Storage',
                  onQuestionMarkPress: () {
                    // Handle question mark icon press
                  },
                ),
                const SizedBox(
                  height: 45,
                ),


                CustomTextField(
                  controller: storageNameController,
                  hintText: 'Storage place name',

                ),

                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: maxItemCountController,
                  hintText: 'Maximum Item',

                ),
                const SizedBox(
                  height: 10,
                ),
                CustomDescriptionField(
                  controller: descriptionController,
                  hintText: 'Description goes here',
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomButton(
                  text: 'Add Place',
                  textColor: Colors.white,
                  containerColor: AppColors.buttoncolor,

                  onPressed: (){
                    //Hive data save

                    final data = StorageModel(storageplacename: storageNameController.text, itemcount: int.parse(maxItemCountController.text), description: descriptionController.text, items: [],);
                    final box = Boxes.getData();
                    box.add(data);
                   // data.save();
                    
                    print(box);



                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ));
                  }, // Use AssetImage
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
