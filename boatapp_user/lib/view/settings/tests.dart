// import 'package:card_flutter/card_flutter.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../global.dart';
// import '../booking/paid_thank_you_screen.dart';
//
// class CardViewScreen extends StatefulWidget {
//   final double price;
//   final String name,email, phone, publicKey, orderId,ownerId;
//
//   const CardViewScreen({super.key,
//    required this.price,
//     required this.name,
//     required this.email,
//     required this.publicKey,
//     required this.phone, required this.orderId,required this.ownerId
//   });
//
//
//
//
//
// @override
// State<CardViewScreen> createState() => _CardViewScreenState();
// }
//
// class _CardViewScreenState extends State<CardViewScreen> {
//   // final Map<String, dynamic> dictionaryMa = {
//   //   "operator": {"publicKey": "pk_test_YhUjg9PNT8oDlKJ1aE2fMRz7"},
//   //   "scope": "Token",
//   //   "order": {
//   //     "description": "Authentication description",
//   //     "currency": "KWD",
//   //     "amount": 1,
//   //     "id": "",
//   //     "reference": "",
//   //   },
//   //   "customer": {
//   //     "id": "",
//   //     "name": [
//   //       {
//   //         "first": "TAP",
//   //         "middle": "",
//   //         "lang": "en",
//   //         "last": "PAYMENTS"
//   //       }
//   //     ],
//   //     "contact": {
//   //       "email": "tap@tap.company",
//   //       "phone": {"countryCode": "+965", "number": "88888888"}
//   //     }
//   //   },
//   // };
//
//
// // The parameters
// //   final Map<String, dynamic> dictionaryMap = {
// //     "features": {
// //       "customerCards": {
// //         "saveCard": true,
// //         "autoSaveCard": true
// //       },
// //       "alternativeCardInputs": {
// //         "cardScanner": true,
// //         "cardNFC": false,
// //       },
// //       "acceptanceBadge": true,
// //     },
// //     "post": const {"url": ""},
// //     "customer": {
// //       "id": "",
// //       "name":  [
// //         {
// //           "first": ,
// //           "middle": "",
// //           "lang": "en",
// //           "last": "PAYMENTS"
// //         }
// //       ],
// //       "editable": true,
// //       "contact": const {
// //         "email": "tap@tap.company",
// //         "phone": {
// //           "countryCode": "+965",
// //           "number": "88888888"
// //         }
// //       },
// //       "nameOnCard": "",
// //     },
// //     "fieldVisibility": {
// //       "card": {
// //         "cardHolder": true
// //       }
// //     },
// //     "merchant": {"id": ""},
// //     "interface": {
// //       "powered": true,
// //       "colorStyle": "colored",
// //       "theme": "light",
// //       "locale": "en",
// //       "edges": "curved",
// //       "cardDirection": "dynamic",
// //       "loader": true
// //     },
// //     "purpose": "Transaction",
// //     "operator": {
// //       "publicKey": "pk_test_YhUjg9PNT8oDlKJ1aE2fMRz7",
// //     },
// //     "scope": "Token",
// //     "order": {
// //       "description": "",
// //       "currency": "SAR",
// //       "amount": 1.0,
// //       "id": "",
// //       "reference": "",
// //       "metadata": const {}
// //     },
// //     "invoice": {"id": ""},
// //     "acceptance": {
// //       "supportedPaymentAuthentications":["3DS"],
// //       "supportedFundSource": ["CREDIT","DEBIT"],
// //       "supportedSchemes": [
// //         "AMERICAN_EXPRESS",
// //         "MADA",
// //         "MASTERCARD",
// //         "VISA",
// //         "OMANNET"
// //       ],
// //     }
// //   };
//   dynamic mCardSDKResponse;
// // This is a stateful variable and will be passed to our widget.
// // Once you make it true, the card sdk will start in the tokenization process.
//   bool generateToken = false;
//
//   @override
//   Widget build(BuildContext context) {
//     print(widget.email);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Payment Screen'),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context,true);
//           },
//           icon: const Icon(
//             CupertinoIcons.back,
//           ),
//         ),
//       ),
//       body: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Add the card widget
//           TapCardViewWidget(
//             sdkConfiguration: {
//       "features": {
//       "customerCards": {
//       "saveCard": true,
//       "autoSaveCard": true
//       },
//       "alternativeCardInputs": {
//       "cardScanner": true,
//       "cardNFC": false,
//       },
//       "acceptanceBadge": true,
//       },
//       "post":  {"url": ""},
//       "customer": {
//       "id": "",
//       "name":  [
//       {
//       "first":widget.name,
//       "middle": "",
//       "lang": "en",
//       "last": ""
//       }
//       ],
//       "editable": true,
//       "contact":  {
//       "email": widget.email,
//       "phone": {
//       "countryCode": "+965",
//       "number": "88888888"
//       }
//       },
//       "nameOnCard": "",
//       },
//       "fieldVisibility": {
//       "card": {
//       "cardHolder": true
//       }
//       },
//       "merchant": {"id": ""},
//       "interface": {
//       "powered": true,
//       "colorStyle": "colored",
//       "theme": "light",
//       "locale": "en",
//       "edges": "curved",
//       "cardDirection": "dynamic",
//       "loader": true
//       },
//       "purpose": "Transaction",
//       "operator": {
//       "publicKey": widget.publicKey,
//       },
//       "scope": "Token",
//       "order": {
//       "description": "",
//       "currency": "USD",
//       "amount": widget.price,
//       "id": "",
//       "reference": "",
//       "metadata": const {}
//       },
//       "invoice": {"id": ""},
//       "acceptance": {
//       "supportedPaymentAuthentications":["3DS"],
//       "supportedFundSource": ["CREDIT","DEBIT"],
//       "supportedSchemes": [
//       "AMERICAN_EXPRESS",
//       "MADA",
//       "MASTERCARD",
//       "VISA",
//       "OMANNET"
//       ],
//       }
//       },
//             /// Will be called once the card is redenred
//             onReady: () {
//               print('onready');
//
//             },
//             /// Will be called once the card is focused
//             onFocus: () {
//               setState(() {
//                 /// defensive coding, to disable tokenization process if the user is editng the card
//                 generateToken = false;
//                 print('onfocus');
//               });
//             },
//             /// Will be called once the token requested is generated
//             onSuccess: (String? success) {
//               print(success);
//               print('onsuccess');
//               FirebaseFirestore.instance.collection('orders').doc(widget.orderId).update(
//                   {
//                     'status': 'Booked',
//                     'cardDetails': success,
//                   }).then((value) async {
//                 String reciverToken = '';
//                 await FirebaseFirestore.instance.collection("Owner").doc(widget.ownerId).get().then((value){
//                   print(value.data());
//                   Map<String,dynamic> data =  value.data() as Map<String,dynamic>;
//                   reciverToken =  data['token'];
//                 });
//                 notificationServices.sendPushMessage(reciverToken, "Customer Paid in Cash", "Booking News");
//
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>  PaidThankYouScreen()));
//               });
//             },
//             /// Will be called once the user enters valid card data
//             onValidInput: (String? validInput) {
//               setState(() {
//                 /// defensive coding, to disable tokenization process if the user is editng the card
//                 generateToken = true;
//
//
//
//               });
//               print(generateToken);
//               print('onvalid');
//             },
//             /// Will be called once the height of the card form changed
//             onHeightChange: (String? heightChange){},
//             /// Will be called once the binlookup for the card is available
//             onBindIdentification: (String? bindIdentification) {},
//             /// Will indicate whether the user activated the save card switch or disabled it
//             onChangeSaveCard: (String? saveCard) {},
//             /// Will be called once there is an error happened
//             onError: (String? error) {
//               print('error');
//
//             },
//             /// Once you want to generate a token, change the state of this var to true
//             generateToken: generateToken,
//           ),
//         ],
//       ),
//     );
//   }
// }