import 'package:boat_app/utils/image_paths.dart';
import 'package:boat_app/utils/sizes_class.dart';
import 'package:boat_app/view/booking/paid_thank_you_screen.dart';
import 'package:boat_app/view/booking/payment_screen/payment_confirmation_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../global.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';



class PaymentOptions extends StatefulWidget {
  final String orderId;
  final int index;
  final String ownerId;
  const PaymentOptions({super.key,
    required this.orderId,
    required this.index,
    required this.ownerId});

  @override
  State<PaymentOptions> createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  String id = FirebaseAuth.instance.currentUser!.uid;

  String? price ;
  Future<void> fetchPrice() async {
    price = await getOrderPrice(widget.index);
    print(price);

  }

  // TextEditingController paymentController = TextEditingController();
  int selected = 0;
  @override
  void initState() {
    fetchPrice();

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay Option'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Methods',
              style: TextStyle(
                color: Color(0xFFA1A1A1),
                fontSize: 10,
                fontWeight: FontWeight.w400,

              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: GestureDetector(
                    onTap: () async {
                   await getSecretAPIKey('MoyaserTest', 'key').then((value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PaymentConfirmatiomScreen(
                              paymentType: 'apple',
                              orderId: widget.orderId,
                              ownerId: widget.ownerId,
                              apiKey: value, price: price!,
                            ),
                      ),
                    );

                  });

                },
                child: Row(
                  children: [
                    SvgPicture.asset(applePay,height: MySize2.size32,),
                    const SizedBox(width: 20,),
                    const Text(
                      'Apple Pay',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    )

                  ],
                ),
              ),
            ),
            const Divider(),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: GestureDetector(
                onTap: () async {
                   await getSecretAPIKey('MoyaserTest', 'key').then((value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PaymentConfirmatiomScreen(
                              paymentType: 'mada',
                              orderId: widget.orderId,
                              ownerId: widget.ownerId,
                              apiKey: value,
                              price: price!,
                            ),
                      ),
                    );
                  });

                  print(price);
                  // Navigator.pop(context);

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(madaPayPng,height: MySize2.size20,),
                    const SizedBox(width: 18,),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          'Mada Pay',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Pay for your order using the   registered phone number with mada',
                          style: TextStyle(
                            color: Color(0xFFA1A1A1),
                            fontSize: 10,
                            fontWeight: FontWeight.w400,

                          ),
                        )
                      ],
                    )

                  ],
                ),
              ),
            ),
            const Divider(),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: GestureDetector(
                   onTap:  () {
                  // Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Something Went Wrong"),
                      backgroundColor: primaryColor,
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                   Image.asset(stcPayPng,height: MySize2.size32,),
                    const SizedBox(width: 20,),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          'Stc Pay',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                           'Pay for your booking using the   registered phone number with STC Pay',

                          style: TextStyle(
                            color: Color(0xFFA1A1A1),
                            fontSize: 10,
                            fontWeight: FontWeight.w400,

                          ),
                        )
                      ],
                    )

                  ],
                ),
              ),
            ),
            const Divider(),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: GestureDetector(
                onTap: () async {
                  await getSecretAPIKey('MoyaserTest', 'key').then((value){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PaymentConfirmatiomScreen(
                              paymentType: 'visa',
                              orderId: widget.orderId,
                              ownerId: widget.ownerId,
                              apiKey: value, price: price!,

                            ),
                      ),
                    );
                  });

                  // Navigator.pop(context);

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(visaPay,height: MySize2.size32,),
                    const SizedBox(width: 20,),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          'Credit/Debit Card',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Pay via your debit and credit Cards we support Visa & Master Cards',

                          style: TextStyle(
                            color: Color(0xFFA1A1A1),
                            fontSize: 10,
                            fontWeight: FontWeight.w400,

                          ),
                        )
                      ],
                    )

                  ],
                ),
              ),
            ),
            const Divider(),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: GestureDetector(
                onTap: () {
                  FirebaseFirestore.instance
                      .collection('orders')
                      .doc(widget.orderId)
                      .update({
                    'status': 'Booked',
                    'paymentType': 'Cash'
                  }).then(
                          (value) async {
                        String reciverToken = '';
                        await FirebaseFirestore.instance
                            .collection("Owner")
                            .doc(widget.ownerId)
                            .get()
                            .then((value) {
                          if (kDebugMode) {
                            print(value.data());
                          }
                          Map<String, dynamic> data =
                          value.data() as Map<String, dynamic>;
                          reciverToken = data['token'];
                        });
                        notificationServices.sendPushMessage(reciverToken,
                            "Customer Paid in Cash", "Booking News");

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PaidThankYouScreen()));
                      });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(cash,height: MySize2.size32,),
                    const SizedBox(width: 20,),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          'Cash',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Pay in cash when your ride start',

                          style: TextStyle(
                            color: Color(0xFFA1A1A1),
                            fontSize: 10,
                            fontWeight: FontWeight.w400,

                          ),
                        )
                      ],
                    )

                  ],
                ),
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
