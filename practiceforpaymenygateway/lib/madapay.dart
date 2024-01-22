// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:moyasar/moyasar.dart';
// import 'package:http/http.dart' as http;

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   Map<String, dynamic>? paymentIntent;

//   final paymentConfig = PaymentConfig(
//     publishableApiKey: 'pk_test_xvVVGsDdKP1maxrPnGbvCEVPzFvVShaiHFPBZpZQ',
//     amount: 25758, // SAR 257.58
//     description: 'nothing',

//     creditCard: CreditCardConfig(
//       saveCard: true,
//       manual: false,
//     ),
//     applePay: ApplePayConfig(
//       merchantId: 'merchant.com.elabdtech.practiceforpaymenygateway',
//       label: 'bike',
//       manual: false,
//     ),
//   );

//   void onPaymentResult(result) {
//     print(result);
//     if (result is PaymentResponse) {
//       switch (result.status) {
//         case PaymentStatus.paid:
//           // handle success.
//           print("Paid");
//           break;
//         case PaymentStatus.failed:
//           // handle failure.
//           print("Failed");
//           break;
//         case PaymentStatus.initiated:
//           // Handle this case.
//           print("Initiated");
//           break;
//         case PaymentStatus.authorized:
//           // Handle this case.
//           print("authorized");
//           break;
//         case PaymentStatus.captured:
//           // Handle this case.
//           print("Captured");
//           break;
//       }
//     }
//   }

//   Future<void> makePayment() async {
//     try {
//       paymentIntent = await createPaymentIntent('10000', 'SAR');

//       // var gpay = const PaymentSheetGooglePay(
//       //   merchantCountryCode: "GB",
//       //   currencyCode: "GBP",
//       //   testEnv: true,
//       //   amount: "10000",
//       //   label: "Bike spare parts",
//       // );

//       // For cards

//       //STEP 2: Initialize Payment Sheet
//       // await Stripe.instance
//       //     .initPaymentSheet(
//       //   paymentSheetParameters: SetupPaymentSheetParameters(
//       //     paymentIntentClientSecret:
//       //         paymentIntent!['client_secret'], //Gotten from payment intent
//       //     style: ThemeMode.light,
//       //     merchantDisplayName: 'Abhi',
//       //   ),
//       // )
//       //     .then((value) {
//       //   displayPaymentSheet();
//       // });

//       await Stripe.instance
//           .confirmPlatformPayPaymentIntent(
//         clientSecret: paymentIntent!['client_secret'],
//         confirmParams: const PlatformPayConfirmParams.googlePay(
//           googlePay: GooglePayParams(
//             testEnv: true,
//             merchantName: 'Example Merchant Name',
//             merchantCountryCode: 'Es',
//             currencyCode: 'SAR',
//           ),
//         ),
//       )
//           .then((value) {
//         print("%%%%%%%%%%%%%%%%%%%%%%%%%%");
//         print(value);
//         Map<String, dynamic> mp = value.toJson();
//         var dp = mp["status"];
//         print(dp);
//         if (dp == "Succeeded") {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text("Payment Successfull"),
//             ),
//           );
//         }
//         print("%%%%%%%%%%%%%%%%%%%%%%%%%%");
//       });

//       //STEP 3: Display Payment sheet
//       // displayPaymentSheet();
//     } catch (err) {
//       print(err);
//     }
//   }

//   displayPaymentSheet() async {
//     try {
//       await Stripe.instance.presentPaymentSheet().then((value) {
//         print("Payment Successfully");
//       });
//     } catch (e) {
//       print('$e');
//     }
//   }

//   Future<void> makeApplePayment() async {
//     try {
//       paymentIntent = await createPaymentIntent('10000', 'SAR');

//       // var gpay = const PaymentSheetGooglePay(
//       //   merchantCountryCode: "GB",
//       //   currencyCode: "GBP",
//       //   testEnv: true,
//       //   amount: "10000",
//       //   label: "Bike spare parts",
//       // );

//       // For cards

//       //STEP 2: Initialize Payment Sheet
//       // await Stripe.instance
//       //     .initPaymentSheet(
//       //   paymentSheetParameters: SetupPaymentSheetParameters(
//       //     paymentIntentClientSecret:
//       //         paymentIntent!['client_secret'], //Gotten from payment intent
//       //     style: ThemeMode.light,
//       //     merchantDisplayName: 'Abhi',
//       //   ),
//       // )
//       //     .then((value) {
//       //   displayPaymentSheet();
//       // });

//       await Stripe.instance
//           .confirmPlatformPayPaymentIntent(
//         clientSecret: paymentIntent!['client_secret'],
//         confirmParams: const PlatformPayConfirmParams.applePay(
//           applePay: ApplePayParams(
//             cartItems: [
//               ApplePayCartSummaryItem.immediate(label: "bike", amount: "25658"),
//             ],
//             merchantCountryCode: 'Es',
//             currencyCode: 'SAR',
//           ),
//         ),
//       )
//           .then((value) {
//         print("%%%%%%%%%%%%%%%%%%%%%%%%%%");
//         print(value);
//         Map<String, dynamic> mp = value.toJson();
//         var dp = mp["status"];
//         print(dp);
//         if (dp == "Succeeded") {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text("Payment Successfull"),
//             ),
//           );
//         }
//         print("%%%%%%%%%%%%%%%%%%%%%%%%%%");
//       });

//       //STEP 3: Display Payment sheet
//       // displayPaymentSheet();
//     } catch (err) {
//       print(err);
//     }
//   }

//   createPaymentIntent(String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': amount,
//         'currency': currency,
//       };

//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         // BEARER (stripe secret key)
//         headers: {
//           'Authorization':
//               'Bearer sk_test_51MgPVSFirPYpsqNH83OvD27sWUmayp3d9GcYTIu77Ou776efkaCcSElWX3D603AOEZbcABkQmrCcLr1xVcyhQw3S00CXE5SpCL',
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: body,
//       );
//       return json.decode(response.body);
//     } catch (err) {
//       throw Exception(err.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Payment"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // link of Apple pay settings
//             //https://docs.moyasar.com/
//             // https://help.moyasar.com/en/article/moyasar-dashboard-apple-pay-certificate-activation-9l6sd5/
//             // https://help.apple.com/xcode/mac/9.3/#/deva43983eb7?sub=dev44ce8ef13
//             Platform.isIOS
//                 ? TextButton(
//                     child: const Text('Apple pay'),
//                     onPressed: () async {
//                       await makeApplePayment();
//                     },
//                   )
//                 : TextButton(
//                     child: const Text('Google pay'),
//                     onPressed: () async {
//                       await makePayment();
//                     },
//                   ),
//             const Text("or"),
//             CreditCard(
//               config: paymentConfig,
//               onPaymentResult: onPaymentResult,
//             ),
//             const Text("or"),
//             MaterialButton(
//               color: Colors.deepPurpleAccent,
//               onPressed: () async {},
//               child: const Text(
//                 "Stc Pay",
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
