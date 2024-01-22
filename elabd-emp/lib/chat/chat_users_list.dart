import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_tms_app/chat/chat_admin.dart';
import 'package:elabd_tms_app/components/custom_text.dart';
import 'package:elabd_tms_app/components/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import 'chat_screen.dart';

class ChatUsersList extends StatefulWidget {
  final UserModel? userData;
  const ChatUsersList({super.key, required this.userData});

  @override
  State<ChatUsersList> createState() => _ChatUsersListState();
}

class _ChatUsersListState extends State<ChatUsersList> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(widget.userData!.id);
    print(widget.userData!.name);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),

              ListTile(
                onTap: ()async{
                  // // it's may be null
                  // // no need of this this is when we check from splash screen etc
                  User? user = FirebaseAuth.instance.currentUser;
                  print(user);
                  DocumentSnapshot userData = await FirebaseFirestore.instance
                      .collection('employees')
                      .doc(user!.uid)
                      .get();
                  UserModel userModel =
                  UserModel.fromJson(userData.data() as Map<String, dynamic>);
                  String name = userModel.name ?? '';
                  String email = userModel.email ?? '';
                  print(" my name is $name");
                  print(" the email is $email");
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatAdmin(userData: userModel)));
                },
                leading: const CustomText(text: 'Chat with Admin',fontSize: 18,fontWeight: FontWeight.w700,),
                trailing: const Icon(Icons.chat_outlined),
              ),

              const SizedBox(
                height: 20,
              ),
              // TextFormField(
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) =>
              //                 SearchScreen(widget.userData!)));
              //   },
              // ),
              TextFieldWidget(controller: searchController, hintText: 'search'),
              // StreamBuilder(
              //     stream: FirebaseFirestore.instance
              //         .collection('employees')
              //         .doc(widget.userData!.id)
              //         .collection('messages')
              //         .snapshots(),
              //     builder: (context, AsyncSnapshot snapshot) {
              //       if (snapshot.hasData) {
              //         if (snapshot.data.docs.length < 1) {
              //           return Center(
              //             child: Text("No Chats Available !"),
              //           );
              //         }
              //         return ListView.builder(
              //             shrinkWrap: true,
              //             itemCount: snapshot.data.docs.length,
              //             itemBuilder: (context, index) {
              //               var friendId = snapshot.data.docs[index].id;
              //               var lastMsg = snapshot.data.docs[index]['last_msg'];
              //               return FutureBuilder(
              //                 future: FirebaseFirestore.instance
              //                     .collection('employees')
              //                     .doc(friendId)
              //                     .get(),
              //                 builder: (context, AsyncSnapshot asyncSnapshot) {
              //                   if (asyncSnapshot.hasData) {
              //                     var friend = asyncSnapshot.data;
              //                     return ListTile(
              //                       leading: ClipRRect(
              //                         borderRadius: BorderRadius.circular(80),
              //                         child: CachedNetworkImage(
              //                           imageUrl: friend['image'],
              //                           placeholder: (conteext, url) =>
              //                               CircularProgressIndicator(),
              //                           errorWidget: (context, url, error) =>
              //                               Icon(
              //                             Icons.error,
              //                           ),
              //                           height: 50,
              //                         ),
              //                       ),
              //                       title: Text(friend['name']),
              //                       subtitle: Container(
              //                         child: Text(
              //                           "$lastMsg",
              //                           style: TextStyle(color: Colors.grey),
              //                           overflow: TextOverflow.ellipsis,
              //                         ),
              //                       ),
              //                       onTap: () {
              //                         Navigator.push(
              //                             context,
              //                             MaterialPageRoute(
              //                                 builder: (context) => ChatScreen(
              //                                     currentUser: widget.userData!,
              //                                     friendId: friend['id'],
              //                                     friendName: friend['name'],
              //                                     friendImage:
              //                                         friend['image'])));
              //                       },
              //                     );
              //                   }
              //                   return LinearProgressIndicator();
              //                 },
              //               );
              //             });
              //       }
              //       return Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     }),

// .where('id',
//                         isNotEqualTo:
//                             widget.userData!.id)
              Expanded(
                child: SingleChildScrollView(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('employees')
                        .where('role', isEqualTo: 'user')
                        .where('id', isNotEqualTo: widget.userData!.id)

                        // Exclude current user
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 50),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Text("No Users Available"),
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var userData = snapshot.data!.docs[index].data()
                                as Map<String, dynamic>;
                            var friendId = snapshot.data!.docs[index].id;
                            var friendName = userData['name'];
                            var friendImage = userData['image'];
                            var email = userData['email'];
                            var lastMsg = userData['last_msg'];
                            var team = userData['team'];

                            return ListTile(
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(friendImage),
                              ),
                              title: Text(friendName),
                              subtitle: Text(
                                lastMsg ??
                                    email, // Display an empty string if lastMsg is null
                                style: const TextStyle(color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                      currentUser: widget.userData!,
                                      friendId: friendId,
                                      friendName: friendName,
                                      friendImage: friendImage,
                                      friendTeam: team,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
