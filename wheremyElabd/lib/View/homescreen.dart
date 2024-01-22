import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wheremyelabd/Component/Togglesettingcomponent.dart';
import 'package:wheremyelabd/Component/appbar.dart';
import 'package:wheremyelabd/Component/notificationcompoent.dart';
import 'package:wheremyelabd/Component/settingscomponent.dart';
import 'package:wheremyelabd/Component/storageplacecomponent.dart';
import 'package:wheremyelabd/Component/storeditemcomponent.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:wheremyelabd/Utils/textstyle.dart';
import 'package:wheremyelabd/View/Editprofile.dart';
import 'package:wheremyelabd/View/additem.dart';
import 'package:wheremyelabd/View/addstorage.dart';
import 'package:wheremyelabd/View/onboardpage.dart';
import 'package:wheremyelabd/View/selectedstorageplace.dart';
import 'package:wheremyelabd/boxes/boxes.dart';

import 'package:wheremyelabd/models/storage_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final String? userId;
  const HomeScreen({Key? key, this.userId}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic selected;
  var heart = false;
  PageController controller = PageController();
  String? PlacesCount;
  int? ItemsCountt;
  TextEditingController itemNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool? checkbox;

  @override
  void dispose() {
    controller.dispose();
    //super.dispose();
  }

  //function to delete items from the selected storage place
  void deleteItem(StorageModel storagePlace, int itemIndex) async {
    setState(
      () {
        storagePlace.items.removeAt(itemIndex);
        storagePlace.save();
      },
    );
  }

  // function to delete items of storage place
  Future<void> _showMyDialogDelte(
      StorageModel storagePlace, int itemIndex) async {
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
                // Perform the delete operation here
                deleteItem(storagePlace, itemIndex);
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  // function to edit items of storage place
  Future<void> _showMyDialog(StorageModel storagePlace, int itemIndex,
      String title, String description) async {
    itemNameController.text = title;
    descriptionController.text = description;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Dialog Box'),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  //use to show old value also and modify value
                  controller: itemNameController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  //use to show old value also and modify value
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
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
            TextButton(
              // edit selected storage placeitem
              child: Text('OK'),
              onPressed: () {
                print(itemNameController.text.toString());
                storagePlace.items[itemIndex].itemName =
                    itemNameController.text.toString();
                storagePlace.items[itemIndex].itemDescription =
                    descriptionController.text.toString();

                storagePlace.save();
                // print('Title: '', Description: '');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String? profilename;
  String? _picture;
  String? profileemail;
  String? profilecountry;
  String? profiledescription;

  // fetch profile picture and user name to show on home page and others pages where needed
  void fetchEditProfileData() {
    // get data from editProfile model
    final box = Boxes.getEditprofile();
    const key = 'editProfile';

    // Get the existing editProfile data in object
    editprofile? existingData = box.get(key);

    if (existingData != null) {
      profilename = existingData.name;
      _picture = existingData.imagePath;
      profileemail = existingData.email;
      profilecountry = existingData.country;
      profiledescription = existingData.description;
    } else {
      // Set _picture and name to an empty string if data doesn't exist
      profilename = '';
      _picture = '';
    }
  }

  // save userId to local storage
  Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  //fetching data first of user profile and userId
  @override
  void initState() {
    super.initState();
    fetchEditProfileData();
    saveUserId('${widget.userId}');
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: PageView(
          controller: controller,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  AppbarCustom(
                    // in custom button show user profile , title and trailing icon
                    title: 'Homepage',
                    trailingIcon: Icons.question_mark,
                  ),

                  SizedBox(
                    height: screenSize.height * 0.04,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Storage Places',
                            style: MyTextStyles.maintextstyle(
                                21.0), // use custom text style
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AddStorage()), // navigate to addstorage page
                              );
                            },
                            child: Text(
                              '+ Add Storage',
                              textAlign: TextAlign.right,
                              style: MyTextStyles.maintextstyle(
                                  14.0), // use custom text style
                            ),
                          ),
                        ],
                      ),

                      // show all Storage place with count item init in home

                      ValueListenableBuilder<Box<StorageModel>>(
                        valueListenable: Boxes.getData().listenable(),
                        builder: (context, box, _) {
                          List<StorageModel> data =
                              box.values.toList().cast<StorageModel>();
                          PlacesCount = data.length.toString();
                          print(PlacesCount);

                          return Container(
                            width: screenSize.width * 0.99,
                            height: screenSize.height * 0.19,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data
                                  .length, // Use data.length instead of box.length
                              itemBuilder: (context, index) {
                                int itemCount = data[index]
                                    .items
                                    .length; // Count items in the list
                                String itemCountText = itemCount.toString();
                                return Row(
                                  children: [
                                    StoragePlaceComponent(
                                      itemCount: itemCountText,
                                      storageName: data[index]
                                          .storageplacename
                                          .toString(),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SelectedStoragePlace(
                                                    storagePlaceName:
                                                        data[index]
                                                            .storageplacename
                                                            .toString()),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(width: screenSize.width * 0.04),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.035,
                  ),
                  //item count
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Stored Items',
                            style: MyTextStyles.maintextstyle(
                                21.0), //use custom style
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AddItem()), // navigate to additem page to adding items
                              );
                            },
                            child: Text(
                              '+ Add Item',
                              textAlign: TextAlign.right,
                              style: MyTextStyles.maintextstyle(
                                  14.0), //use custom style
                            ),
                          ),
                        ],
                      ),
                      //show all items from all storages
                      Container(
                        height: screenSize.height * 0.344,
                        child: ValueListenableBuilder<Box<StorageModel>>(
                          valueListenable: Boxes.getData().listenable(),
                          builder: (context, box, _) {
                            List<StorageModel> storagePlaces =
                                box.values.toList();

                            return ListView.builder(
                              itemCount: storagePlaces.length,
                              itemBuilder: (context, index) {
                                StorageModel storagePlace =
                                    storagePlaces[index];

                                ItemsCountt = storagePlaces.fold<int>(
                                  0,
                                  (previousValue, storagePlace) =>
                                      previousValue + storagePlace.items.length,
                                );
                                print(ItemsCountt.toString());
                                return Container(
                                  child: ListView.builder(
                                    itemCount: storagePlace.items.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, itemIndex) {
                                      ItemModel item =
                                          storagePlace.items[itemIndex];
                                      print(item.imagePath);
                                      print(ItemsCountt);
                                      return Column(
                                        children: [
                                          StoredItemComponent(
                                            avatarPic: item.imagePath,
                                            title: item.itemName,
                                            subtitle: item.itemDescription,
                                            time: item.time,
                                            onEdit: () {
                                              _showMyDialog(
                                                  storagePlace,
                                                  itemIndex,
                                                  storagePlace.items[itemIndex]
                                                      .itemName,
                                                  storagePlace.items[itemIndex]
                                                      .itemDescription);

                                              //  edit button for items
                                            },
                                            onDelete: () async {
                                              _showMyDialogDelte(
                                                  storagePlace, itemIndex);

                                              print(
                                                  "Deleting item at index $itemIndex: ${storagePlace.items}");
                                            },
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      );
                                    },
                                  ),

                                  // SizedBox(height: 10),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // storage places page which show all storage places in a grid view
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppbarCustom(
                    title: 'Storage Place',
                    trailingIcon: Icons.question_mark,
                  ),
                  //next
                  SizedBox(
                    height: screenSize.height * 0.05,
                  ),
                  ValueListenableBuilder<Box<StorageModel>>(
                    valueListenable: Boxes.getData().listenable(),
                    builder: (context, box, _) {
                      List<StorageModel> data =
                          box.values.toList().cast<StorageModel>();

                      return Expanded(
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Set the number of columns here
                          ),

                          itemCount: data
                              .length, // Use data.length instead of box.length
                          itemBuilder: (context, index) {
                            int itemCount = data[index]
                                .items
                                .length; // Count items in the list
                            String itemCountText = itemCount.toString();
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                StoragePlaceComponent(
                                  itemCount:
                                      itemCountText, //data[index].itemcount.toString(),
                                  storageName:
                                      data[index].storageplacename.toString(),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SelectedStoragePlace(
                                                storagePlaceName: data[index]
                                                    .storageplacename
                                                    .toString()),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.01,
                                ), //height: screenSize.height*0.1),
                              ],
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            //Center(child: Text('Star')),

            // storage items to show all storage place items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppbarCustom(
                    title: 'Items List ',
                    trailingIcon: Icons.question_mark,
                  ),
                  SizedBox(height: 30),
                  Expanded(
                    child: ValueListenableBuilder<Box<StorageModel>>(
                      valueListenable: Boxes.getData().listenable(),
                      builder: (context, box, _) {
                        List<StorageModel> storagePlaces = box.values.toList();

                        return ListView.builder(
                          itemCount: storagePlaces.length,
                          itemBuilder: (context, index) {
                            StorageModel storagePlace = storagePlaces[index];
                            ItemsCountt = storagePlaces.fold<int>(
                              0,
                              (previousValue, storagePlace) =>
                                  previousValue + storagePlace.items.length,
                            );

                            return Container(
                              width: screenSize.width * 0.999,
                              // height: screenSize.height * 0.348,
                              child: ListView.builder(
                                itemCount: storagePlace.items.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, itemIndex) {
                                  ItemModel item =
                                      storagePlace.items[itemIndex];
                                  return Column(
                                    children: [
                                      StoredItemComponent(
                                        avatarPic: item.imagePath,
                                        title: item.itemName,
                                        subtitle: item.itemDescription,
                                        time: item.time,
                                        onEdit: () {
                                          _showMyDialog(
                                              storagePlace,
                                              itemIndex,
                                              storagePlace
                                                  .items[itemIndex].itemName,
                                              storagePlace.items[itemIndex]
                                                  .itemDescription);
                                          // Handle edit button click
                                        },
                                        onDelete: () async {
                                          print(
                                              "Deleting item at index $itemIndex: ${storagePlace.items}");
                                          _showMyDialogDelte(
                                              storagePlace, itemIndex);
                                        },
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            //settings page to show all neceesary functions

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 25,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //show a profie picture if user set profile then show use profile otherwsie show domy image
                        CircleAvatar(
                          radius: 23.6,
                          backgroundImage:
                              _picture != null && File(_picture!).existsSync()
                                  ? FileImage(File(_picture.toString()))
                                  : AssetImage('assets/noimage.jpg')
                                      as ImageProvider,
                        ),

                        Expanded(
                          child: Center(
                            child: Text(
                              'Settings',
                              textAlign: TextAlign.center,
                              style: MyTextStyles.maintextstyle(20),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        //if user sign in with google then show user edit profile button otherwise button will not be shown
                        widget.userId != null && widget.userId != '1'
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditProfile(
                                      myVariable: profilename ?? "",
                                      onUpdateProfile: fetchEditProfileData,
                                      email: '$profileemail',
                                      country: '$profilecountry',
                                      description: '$profiledescription',
                                      profilepicture: '$_picture',
                                      userId: '${widget.userId}',
                                    ),
                                  ));
                                  setState(() {});
                                },
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[350],
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                ),
                              )
                            : Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                ),
                              ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //show a profie picture if user set profile then show use profile otherwsie show domy image

                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        _picture != null && File(_picture!).existsSync()
                            ? FileImage(File(_picture.toString()))
                            : AssetImage('assets/noimage.jpg') as ImageProvider,
                  ), // Use the default image when picture is null or empty

                  const SizedBox(
                    height: 8.7,
                  ),
                  // user set name then show user nmae otherwsie show unnamed text
                  Text(
                    (profilename ?? '').isEmpty ? 'Unnamed' : profilename!,
                    textAlign: TextAlign.center,
                    style: MyTextStyles.namestyle(18),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  // showing total places aand item count
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              (PlacesCount == null)
                                  ? '0'
                                  : PlacesCount.toString(),
                              textAlign: TextAlign.center,
                              style: MyTextStyles.storagetextstyle(17),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Total Places',
                              textAlign: TextAlign.center,
                              style: MyTextStyles.settingsGrey(12.0),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              (ItemsCountt == null || ItemsCountt == 0)
                                  ? '0'
                                  : ItemsCountt.toString(),
                              textAlign: TextAlign.center,
                              style: MyTextStyles.storagetextstyle(17),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Total Item',
                              textAlign: TextAlign.center,
                              style: MyTextStyles.settingsGrey(12.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 375,
                    height: 7,
                    decoration: const BoxDecoration(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  Expanded(
                    child: ListView(
                      children: [
                        NotificationComponent(
                          title: "Notifications",
                          subtitle: "Get Update",
                          icon: Icons.notifications_active_sharp,

                        ),


                        const SizedBox(
                          height: 15,
                        ),

                        SettingsComponent(
                          title: "Language",
                          subtitle: "English",
                          icon: Icons.language,
                          onTap: () {
                            // Add your onTap functionality here

                            print("language clicked!");
                          },
                        ),

                        // if user on the toggle button then all data of user will be saved in firebase

                        ToggleSettingsComponent(
                          title: "Synchronization",

                          subtitle: "online database",

                          icon: Icons.sync,

                          initialToggleState:
                              false, // Set the initial state to true if needed

                          onToggle: (bool isToggleOn) {
                            // Handle the toggle state change here

                            print("Toggle state is now: $isToggleOn");
                          },
                          userId: '${widget.userId}',
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        //user see a terms a condition to click on this

                        SettingsComponent(
                          title: "Terms & Condition",
                          subtitle: "Need Help",
                          icon: Icons.help,
                          onTap: () {
                            _launchURL('https://www.google.com');

                            print("help clicked!");
                          },
                        ),



                        // if user sgn in with google then show his  logout button

                        widget.userId != null && widget.userId != '1'
                            ? SettingsComponent(
                                title: "LOGOUT",
                                subtitle: "sign out",
                                icon: Icons.logout_outlined,
                                onTap: () {
                                  Future.delayed(Duration.zero, () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text("Confirm Logout"),
                                        content: Text(
                                            "Are you sure you want to log out?"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                            child: Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              // Perform logout and data removal here

                                              try {
                                                // Sign the user out from Firebase

                                                await FirebaseAuth.instance
                                                    .signOut();

                                                print("Logging out...");

                                                // Close the dialog and navigate to the home page

                                                Navigator.of(context)
                                                    .pop(); // Close the dialog

                                                Navigator.of(context)
                                                    .pushReplacement(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HomeScreen(
                                                            userId: '1'),
                                                  ),
                                                );
                                              } catch (e) {
                                                // Handle any errors that occur during logout

                                                print("Error logging out: $e");

                                                // You can show an error message to the user if needed
                                              }
                                            },
                                            child: Text("OK"),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                },
                              )
                            : Container(),

                        widget.userId != null && widget.userId != '1'
                            ? SettingsComponent(
                                title: "Delete Account",
                                subtitle: "Remove all data",
                                icon: Icons.delete_forever_outlined,

                                onTap: () {
                                  Future.delayed(Duration.zero, () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text("Confirm Delete Account"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                                "Are you sure you want to delete your account?"),
                                            Row(
                                              children: <Widget>[
                                                Checkbox(
                                                  value: checkbox ?? false,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      checkbox = value;
                                                    });
                                                  },
                                                ),
                                                Text("Delete local storage"),
                                              ],
                                            ),
                                          ],
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                            child: Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              // Perform delete account and data removal here

                                              try {
                                                final User? user = FirebaseAuth
                                                    .instance.currentUser;

                                                if (user != null) {
                                                  // Delete the user's account from Firebase

                                                  // Delete the user's data in the "users" collection
                                                  await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();

                                                  // Print a message indicating the data was deleted
                                                  print("User data deleted from Firestore");
                                                }

                                                print("Account deleted...");

                                                // Close the dialog and navigate to the onboarding page

                                                Navigator.of(context)
                                                    .pop(); // Close the dialog

                                                if (checkbox ?? false) {
                                                  final box =
                                                      Boxes.getEditprofile();

                                                  final box1 = Boxes.getData();

                                                  final box2 =
                                                      Boxes.getItemBox();

                                                  box.clear(); // Clear all data in the box

                                                  box1.clear();

                                                  box2.clear();
                                                }

                                                Navigator.of(context)
                                                    .pushReplacement(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const OnboardPage(
                                                            id: true),
                                                  ),
                                                );
                                              } catch (e) {
                                                // Handle any errors that occur during account deletion

                                                print(
                                                    "Error deleting account: $e");

                                                // You can show an error message to the user if needed
                                              }
                                            },
                                            child: Text("OK"),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                },
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      //buttom navigaton bar
      bottomNavigationBar: StylishBottomBar(
        //backgroundColor: Colors.white,

        option: AnimatedBarOptions(
          iconSize: 35,
          barAnimation: BarAnimation.fade,
          iconStyle: IconStyle.animated,

          // inkColor: Colors.transparent,
          // opacity: 0.3,
        ),
        items: [
          BottomBarItem(
            icon: const Icon(
              Icons.house,
            ),
            selectedIcon: const Icon(Icons.house_rounded),
            // selectedColor: Colors.teal,
            //backgroundColor: Colors.black,
            selectedColor: Colors.blue,
            backgroundColor: Colors.blue,
            title: const Text('Home'),
            //  badge: const Text('9+'),
            // showBadge: true,
          ),
          BottomBarItem(
            icon: const Icon(Icons.calendar_view_month_rounded),
            selectedIcon: const Icon(Icons.calendar_view_month_outlined),
            selectedColor: Colors.blue,
            backgroundColor: Colors.blue,
            title: const Text('places'),
          ),
          BottomBarItem(
              icon: const Icon(
                Icons.layers_outlined,
              ),
              selectedIcon: const Icon(
                Icons.layers,
              ),
              //backgroundColor: Colors.blue,
              selectedColor: Colors.blue,
              backgroundColor: Colors.blue,
              title: const Text('items')),
          BottomBarItem(
              icon: const Icon(
                Icons.settings_outlined,
              ),
              selectedIcon: const Icon(
                Icons.settings,
              ),
              selectedColor: Colors.blue,
              backgroundColor: Colors.blue,
              title: const Text('Settings')),
        ],
        hasNotch: true,
        fabLocation: StylishBarFabLocation.center,
        currentIndex: selected ?? 0,
        onTap: (index) {
          controller.jumpToPage(index);
          setState(() {
            selected = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              heart = !heart;
            });
          },
          backgroundColor: Colors.white,
          child: InkWell(
            onTap: () {
              // Navigate to the next page here, for example:
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    AddItem(), // Replace 'NextPage' with your destination page
              ));
            },
            child: Icon(
              CupertinoIcons.add_circled_solid,
              color: Colors.blue,
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
