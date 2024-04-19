import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Boat App Privacy Policy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy for Boat App',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance.collection('Docs').doc('Privacy').snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasError){
                      return Icon(Icons.error);
                    }
                    else if(snapshot.hasData){
                      return Text(
                        snapshot.data!['privacy'],

                      );
                    }else if(snapshot.connectionState == ConnectionState.waiting){
                      return CircularProgressIndicator();
                    }
                    return Container();
                  }
              ),





            ],
          ),
        ),
      ),
    );
  }
}
