import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:boat_app/custom_widgets/app_button.dart';
import 'package:boat_app/utils/colors.dart';
import 'package:boat_app/utils/sizes_class.dart';
import 'package:boat_app/view/booking/paid_thank_you_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:moyasar/moyasar.dart';

import '../../../global.dart';


class PaymentConfirmatiomScreen extends StatefulWidget {
  const PaymentConfirmatiomScreen({super.key,
    required this.paymentType,
    required this.orderId,
    required this.ownerId,
    required this.price,
    required this.apiKey});

  final String paymentType, orderId, ownerId;
      final String price;
  final String? apiKey;


  @override
  State<PaymentConfirmatiomScreen> createState() =>
      _PaymentConfirmatiomScreenState();
}

class _PaymentConfirmatiomScreenState extends State<PaymentConfirmatiomScreen> {

  final  paymentConfig = PaymentConfig(
  publishableApiKey:
 'pk_test_KkvvGF1jGWMUSsh1KD1mdWwBrXUyANo7BGZSK7bK',
  amount: 100* 50,//pricee!.toInt()*100, // SAR 257.58
  description: 'Pay for the boat ride',
  applePay: ApplePayConfig(merchantId: 'merchant.com.boatuser', label: 'Boat App', manual: true),
  // creditCard: CreditCardConfig(
  //   saveCard: true,
  //   manual: false,
  // ),
  );


  void onSubmitApplePay(applePay) async {
    print(paymentConfig.applePay);
    print('%%%%%%');
    final source = ApplePayPaymentRequestSource(
        applePay['token'], (paymentConfig.applePay as ApplePayConfig).manual);
    print(source);
    print('%%%%%%');


    final paymentRequest = PaymentRequest(paymentConfig, source);
    print(paymentRequest);
    print('%%%%%3333333333%');



    final result = await Moyasar.pay(
        apiKey: paymentConfig.publishableApiKey,
        paymentRequest: paymentRequest);
    print(result);

    onPaymentResult(result);
  }

  double? pricee;
  Map<String, dynamic>? paymentIntent;
  @override
  void initState() {
    print(widget.price);
    pricee = double.parse(widget.price);
    print(pricee);
    pricee?.toInt();




    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print(widget.apiKey);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: widget.paymentType == "apple"
            ? const Text("Pay with Apple fgf")
            : widget.paymentType == "mada"
                ? const Text("Pay with Mada Card")
                : widget.paymentType == "google"
                    ? const Text("Pay with Google Pay")
                    : const Text("Pay with VISA Card"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              widget.paymentType == "apple" || widget.paymentType == "google"
                  ? Platform.isIOS
                      ?
              Padding(
                padding:  EdgeInsets.all(MySize2 .size15),
                child: ApplePay(
                  config: paymentConfig,
                  // PaymentConfig(
                  //   publishableApiKey:
                  //   widget.apiKey!,
                  //   amount: pricee!.toInt()*100, // SAR 257.58
                  //   description: 'Pay for the boat ride',
                  //   applePay: ApplePayConfig(merchantId: 'merchant.com.boatuser', label: 'Boat App', manual: false),
                  //   // creditCard: CreditCardConfig(
                  //   //   saveCard: true,
                  //   //   manual: false,
                  //   // ),
                  // ),
                  onPaymentResult: onSubmitApplePay,
                ),
              )
              // Padding(
              //             padding: const EdgeInsets.all(25),
              //             child: AppButton(
              //               background: Colors.white,
              //               textColor: primaryColor,
              //               onPressed: () async {
              //                 makeApplePayment();
              //               },
              //               text: "Apple Pay",
              //             ),
              //           )
                      : Padding(
                          padding: const EdgeInsets.all(25),
                          child: AppButton(
                            background: Colors.white,
                            textColor: primaryColor,
                            onPressed: () async {
                              makeGooglePayment();
                            },
                            text: "Google Pay",
                          ),
                        )
                  : const SizedBox(),
              widget.paymentType == "mada" || widget.paymentType == "visa"
                  ? Padding(
                      padding:  EdgeInsets.all(MySize2 .size15),
                      child: CreditCard(
                        config: PaymentConfig(
                          publishableApiKey:
                              widget.apiKey!,
                          amount: pricee!.toInt()*100, // SAR 257.58
                          description: 'Pay for the boat ride',
                          creditCard: CreditCardConfig(
                            saveCard: true,
                            manual: false,
                          ),

                        ),
                        onPaymentResult: onPaymentResult,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  void onPaymentResult(result) {
    print(result);
    if (result is PaymentResponse) {
      switch (result.status) {
        case PaymentStatus.paid:
          // handle success.
          payemntInFirebase('Mada pay');

          print("Paid");
          break;
        case PaymentStatus.failed:
          // handle failure.
          print("Failed");
          break;
        case PaymentStatus.initiated:
          // Handle this case.
          print("Initiated");
          break;
        case PaymentStatus.authorized:
          // Handle this case.
          print("authorized");
          break;
        case PaymentStatus.captured:
          // Handle this case.
          print("Captured");
          break;
        default:
        // Handle this case.
          print("Captured");
          break;

      }
    }
  }

  Future<void> makeGooglePayment() async {
    try {
      paymentIntent = await createPaymentIntent('10000', 'SAR');

      await Stripe.instance
          .confirmPlatformPayPaymentIntent(
        clientSecret: paymentIntent!['client_secret'],
        confirmParams: const PlatformPayConfirmParams.googlePay(
          googlePay: GooglePayParams(
            testEnv: true,
            merchantName: 'Example Merchant Name',
            merchantCountryCode: 'Es',
            currencyCode: 'SAR',
          ),
        ),
      )
          .then((value) {
        print("%%%%%%%%%%%%%%%%%%%%%%%%%%");
        print(value);
        Map<String, dynamic> mp = value.toJson();
        var dp = mp["status"];
        print(dp);
        if (dp == "Succeeded") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Payment Successfull"),
            ),
          );
          payemntInFirebase('Google pay');

        }
        print("%%%%%%%%%%%%%%%%%%%%%%%%%%");
      });

      //STEP 3: Display Payment sheet
      // displayPaymentSheet();
    } catch (err) {
      print(err);
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        print("Payment Successfully");
      });
    } catch (e) {
      print('$e');
    }
  }

  Future<void> makeApplePayment() async {
    try {
      paymentIntent = await createPaymentIntent('10000', 'SAR');

      await Stripe.instance
          .confirmPlatformPayPaymentIntent(
        clientSecret: paymentIntent!['client_secret'],
        confirmParams: const PlatformPayConfirmParams.applePay(
          applePay: ApplePayParams(
            cartItems: [
              ApplePayCartSummaryItem.immediate(label: "bike", amount: "25658"),
            ],
            merchantCountryCode: 'Es',
            currencyCode: 'SAR',
          ),
        ),
      )
          .then((value) {
        print("%%%%%%%%%%%%%%%%%%%%%%%%%%");
        print(value);
        Map<String, dynamic> mp = value.toJson();
        var dp = mp["status"];
        print(dp);
        if (dp == "Succeeded") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Payment Successfull"),
            ),
          );
          payemntInFirebase('Apple pay');
        }
        print("%%%%%%%%%%%%%%%%%%%%%%%%%%");
      });

      //STEP 3: Display Payment sheet
      // displayPaymentSheet();
    } catch (err) {
      print(err);
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        // BEARER (stripe secret key)
        headers: {
          'Authorization':
              'Bearer sk_test_51MgPVSFirPYpsqNH83OvD27sWUmayp3d9GcYTIu77Ou776efkaCcSElWX3D603AOEZbcABkQmrCcLr1xVcyhQw3S00CXE5SpCL',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  void payemntInFirebase(String paymentMethod){
    FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.orderId)
        .update({
      'status': 'Booked',
      'paymentType': paymentMethod
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
              "Customer Paid in $paymentMethod", "Booking News");

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PaidThankYouScreen()));
        });
  }
}
