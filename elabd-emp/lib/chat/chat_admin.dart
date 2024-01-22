import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_tms_app/components/text_field_widget.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import 'chat_screen.dart';

class ChatAdmin extends StatefulWidget {
  final UserModel? userData;
  const ChatAdmin({super.key, required this.userData});

  @override
  State<ChatAdmin> createState() => _ChatAdminState();
}

class _ChatAdminState extends State<ChatAdmin> {
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
                        .where('role', isEqualTo: 'Admin')

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
                              title: Text(friendName ?? 'default Name'),
                              subtitle: Text(
                                lastMsg ??
                                    email, // Display an empty string if lastMsg is null
                                style: const TextStyle(color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () {
                                print(widget.userData);
                                print(friendId);
                                print(friendName);
                                print(friendImage);
                                print(team);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                      currentUser: widget.userData!,
                                      friendId: friendId,
                                      friendName: friendName,
                                      friendImage: friendImage,
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
