
import 'package:boat_app/custom_widgets/app_button.dart';
import 'package:boat_app/languages/LocaleString.dart';
import 'package:boat_app/provider/loading_provider/loading_provider.dart';
import 'package:boat_app/utils/utils.dart';
// import 'package:boat_app/view/profile/emergency.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:provider/provider.dart';

import '../../../utils/sized_box.dart';
import 'emergency.dart';

class UpdateEmergencyDetails extends StatefulWidget {
  const UpdateEmergencyDetails({super.key});

  @override
   _UpdateEmergencyDetailsState createState() => _UpdateEmergencyDetailsState();
}

class _UpdateEmergencyDetailsState extends State<UpdateEmergencyDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Text editing controllers
  TextEditingController addressController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  final FlutterContactPicker _contactPicker = new FlutterContactPicker();
  List<Contact> _selectedContacts = [];
  List<Map<String, dynamic>> _selectedContacts2 = [];

  void _pickContacts() async {
    Contact? contact;

    try {
     contact = await _contactPicker.selectContact();
    } catch (e) {
      print(e.toString());
    }

    if (contact!.phoneNumbers!.isNotEmpty) {
      final contactData = {
        'name': contact.fullName ?? '',
        'phone': contact.phoneNumbers!.single ?? '',
      };
      setState(() {
         _selectedContacts.add(contact!);
         _selectedContacts2.add(contactData);
      });
    }
  }


  @override
  void dispose() {
    // Dispose of text editing controllers when the widget is disposed
    addressController.dispose();
    bloodGroupController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocale.addEmergencyInformation.getString(context)),
        actions: [
         IconButton(onPressed: (){
           _pickContacts();

         }, icon:  Icon(Icons.add_ic_call),),
       SizedBox(width: 20,) ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocale.address.getString(context),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  hintText: AppLocale.enterYourAddress.getString(context),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),

                ),
              ),
              SizedBox(height: 16.0),
              Text(
                AppLocale.bloodGroup.getString(context),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: bloodGroupController,
                decoration: InputDecoration(
                  hintText:  AppLocale.enterYourBloodGroup.getString(context),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade200)


                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: _selectedContacts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text(index.toString()),
                    title: Text(_selectedContacts[index].fullName ?? ''),
                    subtitle: Text(_selectedContacts[index].phoneNumbers!.single ?? ''),
                    trailing: IconButton(onPressed: (){
                      _selectedContacts2.removeAt(index);
                      _selectedContacts.removeAt(index);
                      setState(() {

                      });

                    }, icon: Icon(Icons.remove),),
                  );
                },
              ),
              SizedBox(height: 16.0),

              Center(child: Consumer<LoadingProvider>(
                builder: (context, value, child){
                  return  AppButton(
                    loading: loadingProvider.loading,
                    onPressed: (){
                      if(addressController.text.isEmpty){
                        Utils.toastMessage(AppLocale.pleaseEnterYourAddress.getString(context));

                      }
                      else if(_selectedContacts2.isEmpty){
                        Utils.toastMessage(AppLocale.pleaseEnterYourAddress.getString(context));
                      }else{
                        loadingProvider.loginLoading(true);
                        FirebaseFirestore.instance.collection('emergencyDetails').doc(FirebaseAuth.instance.currentUser!.uid).set({
                          'address':addressController.text,
                          'bloodGroup':bloodGroupController.text,
                          'contacts': _selectedContacts2,
                          'id': FirebaseAuth.instance.currentUser!.uid,
                          'userType':'User'

                        }).then((value) {
                          loadingProvider.loginLoading(false);

                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Emergency()));
                        }).onError((error, stackTrace) {
                          loadingProvider.loginLoading(false);

                          Utils.toastMessage(error.toString());
                        });
                      }

                    }, text: AppLocale.save.getString(context),width: width(context)* 0.8,);
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}