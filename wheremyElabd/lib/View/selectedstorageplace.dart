import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wheremyelabd/Component/appbar.dart';
import 'package:wheremyelabd/Component/appbaritemlist.dart';
import 'package:wheremyelabd/Component/storeditemcomponent.dart';
import 'package:wheremyelabd/Utils/textstyle.dart';
import 'package:wheremyelabd/boxes/boxes.dart';
import 'package:wheremyelabd/models/storage_model.dart';
import 'package:hive/hive.dart';

class SelectedStoragePlace extends StatefulWidget {
  final String storagePlaceName;
  const SelectedStoragePlace({Key? key, required this.storagePlaceName}) : super(key: key);

  @override
  State<SelectedStoragePlace> createState() => _SelectedStoragePlaceState();
}

class _SelectedStoragePlaceState extends State<SelectedStoragePlace> {
 //text feild controller define for editing the items if user want to edit
  TextEditingController itemNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // delete items for selected sotrage place
  void deleteItem(StorageModel storagePlace, int itemIndex) async {
    setState(() {
      storagePlace.items.removeAt(itemIndex);
      storagePlace.save();
    },);
  }


   // if user delete item first show his confirmation msg  through dialog box
  Future<void> _showMyDialogDelte(StorageModel storagePlace, int itemIndex) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this item?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                // Perform the delete operation here go to deleteItem function
                deleteItem(storagePlace, itemIndex);
                setState(() {

                });
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  // show a dialog box if user edit the item
  Future<void> _showMyDialog(StorageModel storagePlace, int itemIndex, String title, String description) async {
    itemNameController.text=title; // old title
    descriptionController.text=description; //  old description
    // to show on alert box

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          title: Text('Dialog Box'),
          content: Container(
            child: Column(

              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField( // take title in itemcontroller
                  controller: itemNameController,
                  decoration: InputDecoration(labelText: 'Title'),
                  // onChanged: (value) {
                  //   setState(() {
                  //    // _title = value;
                  //   });
                  // },
                ),
                TextField( // take description in descriptioncontroller
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                  // onChanged: (value) {
                  //   setState(() {
                  //   //  _description = value;
                  //   });
                  // },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(   // when user pressed ok data will be update of  specific item
              child: Text('OK'),
              onPressed: () {
                storagePlace.items[itemIndex].itemName=itemNameController.text.toString();
                storagePlace.items[itemIndex].itemDescription=descriptionController.text.toString();

                setState(() {
                  storagePlace.save();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  void initState() {
    super.initState();

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(

        body: SafeArea(
          child:  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ListCom( // component oof App Bar
                    title: 'Items List',

                  ),

                  const SizedBox(height: 30),
                  Expanded(
                    child: ValueListenableBuilder<Box<StorageModel>>(
                      valueListenable: Boxes.getData().listenable(),
                      builder: (context, box, _) {
                        List<StorageModel> storagePlaces = box.values.toList();

                        // Get name of the storage place
                        String selectedStoragePlaceName = widget.storagePlaceName;

                        // Filter the storagePlaces list to only include the selected storage place
                        List<StorageModel> selectedStoragePlace = storagePlaces
                            .where((storagePlace) =>
                        storagePlace.storageplacename == selectedStoragePlaceName)
                            .toList();

                        return ListView.builder(  // build items list
                          itemCount: selectedStoragePlace.length,
                          itemBuilder: (context, index) {
                            StorageModel storagePlace = selectedStoragePlace[index];


                            return Column(
                              children: [
                                Container(
                             // condition if items not fount show no items  else show all selected storage items
                                    child: storagePlace.items.isEmpty
                                        ?  Center(
                                      child: Text(
                                        "No items",
                                        style: MyTextStyles.maintextstyle(40),
                                      ),
                                    )
                                        :  ListView.builder(
                                    itemCount: storagePlace.items.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, itemIndex) {
                                      ItemModel item = storagePlace.items[itemIndex];
                                      return Column(
                                        children:[ StoredItemComponent(
                                          avatarPic: item.imagePath,
                                          title: item.itemName,
                                          subtitle: item.itemDescription,
                                          time: item.time,
                                          onEdit: () {
                                            // call alert box to edit data
                                            _showMyDialog(storagePlace, itemIndex, storagePlace.items[itemIndex].itemName, storagePlace.items[itemIndex].itemDescription);


                                          },
                                          onDelete: () async {
                                            // call alert box to delete data
                                            _showMyDialogDelte(storagePlace, itemIndex);

                                            print("Deleting item at index $itemIndex: ${storagePlace.items}");

                                          },
                                        ),
                                          SizedBox(height: 10),

                                        ],

                                      );
                                    },
                                  ),
                                ),

                            ],
                            );
                          },
                        );
                      },
                    ),
                  )

                ],
              ),
            ),
          ),


    );
  }
}
