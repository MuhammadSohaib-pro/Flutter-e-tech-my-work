import 'package:flutter/material.dart';
import 'package:wheremyelabd/Utils/appcolor.dart';
import 'package:wheremyelabd/Utils/textstyle.dart';
import 'package:wheremyelabd/View/homescreen.dart';

import '../Component/custombutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class OnboardPage extends StatefulWidget {
  final bool id;
  const OnboardPage({Key? key, required this.id}) : super(key: key);

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {

  bool _loading = false;

  // create instaance and define method googlesignin
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  //future function for signin with google
  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      setState(() { // processing . Show a circular loading indicator _loading,
        _loading = true;
      });

      //declaring a variable googleSignInAccount and initializing it with the result of the await googleSignIn.signIn() operation.
      final GoogleSignInAccount? googleSignInAccount =
      await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        // if statement checks if googleSignInAccount is not null, meaning that Google sign-in was successful, and a GoogleSignInAccount was obtained.
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential( //
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        //save credentials in user var
        final UserCredential authResult =
        await _auth.signInWithCredential(credential);
        final User? user = authResult.user;

        if (user != null) {
          String userId = user.uid;

          // Create a 'users' collection if it doesn't exist
          final usersCollection = FirebaseFirestore.instance.collection('users');

          // Check if the user's document already exists
          final userDoc = usersCollection.doc(userId);
          final userDocSnapshot = await userDoc.get();

          if (!userDocSnapshot.exists) {
            // User's document does not exist, create it with the user's ID
            await userDoc.set({
              'userId': userId,
            });
          }

          // Display a message and navigate to the home screen
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Signed in with Google: ${user.displayName}'),
            ),
          );

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeScreen(userId: userId),
            ),
          );

          return user;
        } else {  // if failed for internet  reason
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Google sign-in failed. Please try again.'),
            ),
          );
          return null;
        }
      } else {  // if sign in cancel msg will be shown
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Google sign-in canceled.'),
          ),
        );
        return null;
      }
    } catch (e) { //show msg to user if error occurred
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred while signing in.'),
        ),
      );
      return null;
    } finally { // after processing set _loading to false
      setState(() {
        _loading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
          children: [
            SizedBox(height:screenSize.height*0.03),
            Image.asset(
                'assets/onboard.png',
             //   width: screenSize.width * 0.58,
             //   height: screenSize.height * 0.58,
              ),


           // SizedBox(height:screenSize.height*0.04),

            Text(
              'Don\'t forget to find your items with us',
              textAlign: TextAlign.center,
              style:MyTextStyles.maintextstyle(20.0),
            ),

            SizedBox(height: screenSize.height * 0.04),
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child: Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                  textAlign: TextAlign.center,
                  style:MyTextStyles.longtextstyle(16.0),
                ),
              ),
            ),


            SizedBox(height: screenSize.height * 0.040),
            _loading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : CustomButton(
              text: 'Continue with Google',
              textColor: AppColors.mainapptextColor,
              containerColor: Colors.white,
              image: AssetImage('assets/Google Icon.png'),
              onPressed: () {
                // Call signInWithGoogle when the button is pressed
                signInWithGoogle(context);
              },
            ),


            SizedBox(height: screenSize.height * 0.02),

            widget.id != null && widget.id == true
                ? CustomButton(
              text: 'Continue as Guest',
              textColor: Colors.white,
              containerColor: AppColors.buttoncolor,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomeScreen(userId: '1'),
                ));
              },
              // Use AssetImage
            )
                : Container(),

          ],
        ),

    );
  }
}
