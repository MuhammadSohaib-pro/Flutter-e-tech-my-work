import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_tms_app/components/custom_app_bar.dart';
import 'package:elabd_tms_app/components/custom_button.dart';
import 'package:elabd_tms_app/screens/salary_report/salary_report_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../components/text_field_widget.dart';
import '../../constants/colors.dart';

class BankAccountInfo extends StatefulWidget {
  const BankAccountInfo({super.key});

  @override
  State<BankAccountInfo> createState() => _BankAccountInfoState();
}

class _BankAccountInfoState extends State<BankAccountInfo> {
  dynamic accountTitleController = TextEditingController();
  dynamic accountNoController = TextEditingController();
  dynamic ibanController = TextEditingController();
  dynamic bankNameController = TextEditingController();
  //A map to store data from firebase
  final bankData = {};

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getBankAccountDetailOnPageLoad();
  }

  @override
  void dispose() {
    accountNoController.dispose();
    accountTitleController.dispose();
    ibanController.dispose();
    bankNameController.dispose();
    super.dispose();
  }

//Load Bank details from Firebase and set it to text fields
  Future<void> getBankAccountDetailOnPageLoad() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('employees')
          .where(
            'id',
            isEqualTo: FirebaseAuth.instance.currentUser?.uid,
          )
          .get();

      for (final doc in querySnapshot.docs) {
        bankData['accountTitle'] = doc['accountTitle'];
        bankData['accountNo'] = doc['accountNo'];
        bankData['iban'] = doc['iban'];
        bankData['bankName'] = doc['bankName'];
      }

      //Update data to text fields as value
      setState(() {
        accountTitleController =
            TextEditingController(text: bankData['accountTitle']);
        accountNoController =
            TextEditingController(text: bankData['accountNo']);
        ibanController = TextEditingController(text: bankData['iban']);
        bankNameController = TextEditingController(text: bankData['bankName']);
      });
    } catch (e) {
      print('Error  Why $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Bank Account Information',
        textColor: black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              fieldWidget(
                  title: 'Account Title',
                  controller: accountTitleController,
                  hintText: 'Account Name'),
              fieldWidget(
                  title: 'Account No',
                  controller: accountNoController,
                  textInputType: TextInputType.phone,
                  hintText: 'Account No'),
              fieldWidget(
                  title: 'IBAN', controller: ibanController, hintText: 'IBAN'),
              fieldWidget(
                  title: 'Bank Name',
                  controller: bankNameController,
                  hintText: 'Bank Name'),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: CustomButton(
                    width: MediaQuery.of(context).size.width * 0.8,
                    textColor: white,
                    height: 50,
                    text: 'Update',
                    color: primaryColor,
                    onPressed: () {
                      if (accountTitleController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: 'Account Title is Required');
                      } else if (accountNoController.text.isEmpty) {
                        Fluttertoast.showToast(msg: 'Account No is Required');
                      } else if (ibanController.text.isEmpty) {
                        Fluttertoast.showToast(msg: 'Account IBAN is Required');
                      } else if (bankNameController.text.isEmpty) {
                        Fluttertoast.showToast(msg: 'Bank Name is Required');
                      } else {
                        var id = FirebaseAuth.instance.currentUser!.uid;
                        FirebaseFirestore.instance
                            .collection('employees')
                            .doc(id)
                            .update({
                          'accountTitle':
                              accountTitleController.text.toString(),
                          'accountNo': accountNoController.text.toString(),
                          'iban': ibanController.text.toString(),
                          'bankName': bankNameController.text.toString(),
                        }).then((value) {
                          Fluttertoast.showToast(msg: 'Updated Successfully');
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             const SalaryReportScreen()));
                          Navigator.pop(context, true);
                        }).onError((error, stackTrace) {
                          Fluttertoast.showToast(msg: 'Error $error');
                        });
                      }
                    }),
              )
            ],
          ),
        ),
      )),
    );
  }

  Widget fieldWidget(
      {required String title,
      required TextEditingController controller,
      required String hintText,
      TextInputType textInputType = TextInputType.name}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFieldWidget(
            keyBoadType: textInputType,
            borderRadius: 0,
            controller: controller,
            hintText: hintText),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
