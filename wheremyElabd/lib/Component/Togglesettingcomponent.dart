import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wheremyelabd/View/onboardpage.dart';
import 'package:wheremyelabd/boxes/boxes.dart';


class ToggleSettingsComponent extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Function(bool)? onToggle; // Callback function with a boolean parameter
  final bool initialToggleState; // Initial toggle state
  final String userId;
  ToggleSettingsComponent({
    required this.title,
    required this.userId,
    required this.subtitle,
    required this.icon,
    this.onToggle,
    this.initialToggleState = false, // Provide an initial state (default is off)
    Key? key,
  }) : super(key: key);

  @override
  _ToggleSettingsComponentState createState() => _ToggleSettingsComponentState();
}

class _ToggleSettingsComponentState extends State<ToggleSettingsComponent> {
  bool isToggleOn = false; // Initialize the toggle state

  @override
  void initState() {
    super.initState();
    isToggleOn = widget.initialToggleState; // Initialize with the provided initial state
  }

  void toggleSwitch() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      // await usersCollection.doc(widget.userId).update(jsonData);

      if (user != null &&
          user.providerData.any((userInfo) {
            return userInfo.providerId == 'google.com';
          }) &&
          widget.userId != null &&
          widget.userId != '1') {
        // Check if the toggle is turned on
        if (!isToggleOn) {
          // Toggle the state
          print('if before set state');
          print(isToggleOn);
          setState(() {
            isToggleOn = !isToggleOn; // Toggle the state
          });
          print('if after set state');
          print(isToggleOn);

          if (widget.onToggle != null) {
            widget.onToggle!(isToggleOn); // Callback with the updated state
          }

          // Check if the 'users' collection exists in Firestore
          final firestore = FirebaseFirestore.instance;
          final usersCollection = firestore.collection('users');

          // Check if the user document exists in Firestore
          final userDoc = usersCollection.doc(widget.userId);
          final userDocSnapshot = await userDoc.get();

          // Convert your Hive data to JSON
          final storageData = Boxes.getData().values.map((data) => data.toJson()).toList();
          final itemData = Boxes.getItemBox().values.map((item) => item.toJson()).toList();
          final editProfileData = Boxes.getEditprofile().values.map((profile) => profile.toJson()).toList();

          // Create a JSON object with your Hive data
          final jsonData = {
            'storageData': storageData,
            'itemData': itemData,
            'editProfileData': editProfileData,
          };

          print('firebase');

          if (userDocSnapshot.exists) {
            // User document exists in Firestore, update the fields
            await userDoc.update(jsonData);
            print('Firebase user document updated');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Your Data is Updated.'),
              ),
            );
          } else {
            // User document does not exist in Firestore, show an error message
            print('User document does not exist for updating.');
            // Handle this case as needed, e.g., show an error message.
          }
        } else {
          // Toggle is off, do not save data
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Data saving is only allowed when the toggle is turned on.'),
            ),
          );
          print('else before set state');
          print(isToggleOn);
          setState(() {
            isToggleOn = !isToggleOn;
          });
          print('else after set state');
          print(isToggleOn);
        }
      } else {
        // User is not signed in with Google, show an alert dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('You are not signed in'),
              content: Text('To perform this action, you must be signed in with Google.'),
              actions: <Widget>[
                TextButton(
                  child: Text('Sign In'),
                  onPressed: () {
                    // Navigate to the sign-in page
                    Navigator.of(context).pop(); // Close the dialog
                    // Replace 'YourSignInPage()' with the actual sign-in page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OnboardPage(id:false),),
                    );
                  },
                ),
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            );
          },
        );
      }

    } catch (e) {
      print('Error: $e');
    }
  }







  @override
  Widget build(BuildContext context) {
    return Container(
      width: 363,
      height: 70,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Color(0xFFCBE5E7).withOpacity(0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: toggleSwitch, // Toggle the switch on tap
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    widget.icon,
                    color: Colors.blue,
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.subtitle,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(
                    isToggleOn ? Icons.toggle_on : Icons.toggle_off,
                    color: isToggleOn ? Colors.green : Colors.red,
                    size: 40,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Container(
              width: 365,
              height: 1,
              decoration: const BoxDecoration(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
