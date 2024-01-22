// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:elabd_ems_admin/model/user_model.dart' as model;
// import '../services/firebase_messeging.dart';
// import '../utils/utils.dart';
// import '../view/chat/chat_screen.dart';

// class UserViewPerson extends StatefulWidget {
//   const UserViewPerson({
//     super.key,
//   });

//   @override
//   State<UserViewPerson> createState() => _UserViewPersonState();
// }

// class _UserViewPersonState extends State<UserViewPerson> {
//   int? isSelected;

//   @override
//   void initState() {
//     super.initState();
//     isSelected = -1;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance
//           .collection('employees')
//           // .orderBy('lastMessageTime', descending: true)
//           .snapshots(),
//       builder: (context,
//           AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         return ListView.builder(
//           physics: const BouncingScrollPhysics(),
//           shrinkWrap: true,
//           itemCount: snapshot.data!.docs.length,
//           itemBuilder: (context, index) {
//             // Avoid the signed-in user in this list
//             if (snapshot.data!.docs[index].id ==
//                 FirebaseAuth.instance.currentUser!.uid) {
//               return const SizedBox.shrink();
//             }
//             return StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseApi.getMessages(
//                     idUser: snapshot.data!.docs[index]["id"],
//                     recieverId: FirebaseAuth.instance.currentUser!.uid),
//                 builder: (context, messegeSnapshot) {
//                   if (messegeSnapshot.connectionState ==
//                       ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   final messages = messegeSnapshot.data!.docs;
//                   final lastMessage = messages.isNotEmpty
//                       ? messages.first['message']
//                       : snapshot.data!.docs[index]['name'];
//                   // there will b a bio for a user whic comes from firebase
//                   // : snapshot.data!.docs[index]['bio'];
//                   final lastMessageTime = messages.isNotEmpty
//                       ? (messages.first['createdAt'] as Timestamp).toDate()
//                       : null;
//                   return Column(
//                     children: [
//                       Padding(
//                         padding:
//                             const EdgeInsets.only(left: 5, bottom: 5, top: 6),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: isSelected == index
//                                 ? Color.fromARGB(255, 229, 237, 242)
//                                 : Colors.transparent,
//                           ),
//                           child: ListTile(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => ChatScreen(
//                                         // callID: "",
//                                         snap: model.UserModel.fromSnapshot(
//                                           snapshot.data!.docs[index],
//                                         ),
//                                       ),
//                                     ));
//                                 setState(
//                                   () {
//                                     isSelected = index;
//                                   },
//                                 );
//                               },
//                               minLeadingWidth: 70,
//                               leading: Container(
//                                 width: 65,
//                                 height: 65,
//                                 padding: const EdgeInsets.all(3),
//                                 decoration: BoxDecoration(
//                                   border:
//                                       Border.all(width: 2, color: Colors.grey),
//                                   shape: BoxShape.circle,
//                                   image: DecorationImage(
//                                     fit: BoxFit.cover,
//                                     image: NetworkImage(
//                                       snapshot.data!.docs[index]['image'],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               title: Text(
//                                 snapshot.data!.docs[index]['name'],
//                                 style: const TextStyle(
//                                     fontSize: 20, fontWeight: FontWeight.w500),
//                                 softWrap: false,
//                                 maxLines: 1,
//                                 overflow: TextOverflow.fade,
//                               ),
//                               subtitle: Text(
//                                 lastMessage,
//                                 style: const TextStyle(
//                                     fontSize: 12,
//                                     overflow: TextOverflow.ellipsis),
//                               ),
//                               trailing: lastMessageTime != null
//                                   ? Text(
//                                       Utils.formatDateTime(lastMessageTime),
//                                       style: const TextStyle(fontSize: 10),
//                                     )
//                                   : const Text(
//                                       '',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           overflow: TextOverflow.ellipsis),
//                                     )),
//                         ),
//                       ),
//                     ],
//                   );
//                 });
//           },
//         );
//       },
//     );
//   }
// }
