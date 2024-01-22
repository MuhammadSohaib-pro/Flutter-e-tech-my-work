import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:flutter/material.dart';
import '../model/user_model.dart';
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat'), centerTitle: true,
          // actions: [
          //   // IconButton(onPressed: () {}, icon: const Text('Chat Admin'))
          // ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              ListTile(
                title: const Text('Chat With Admin'),
                trailing: const Icon(Icons.chat),
                onTap: () {},
              ),
              TextFieldWidget(controller: searchController, hintText: 'search user'),
              // StreamBuilder(
              //     stream: FirebaseFirestore.instance
              //         .collection('employees')
              //         .doc(widget.userData!.id)
              //         .collection('messages')
              //         .snapshots(),
              //     builder: (context, AsyncSnapshot snapshot) {
              //       if (snapshot.hasData) {
              //         if (snapshot.data.docs.length < 1) {
              //           return const Center(
              //             child: Text("No Chats Available !"),
              //           );
              //         }
              //         return ListView.builder(
              //             shrinkWrap: true,
              //             itemCount: snapshot.data.docs.length,
              //             itemBuilder: (context, index) {
              //               var friendId = snapshot.data.docs[index].id;
              //               var lastMsg = snapshot.data.docs[index]['last_msg'];
              //               return FutureBuilder<DocumentSnapshot>(
              //                 future: FirebaseFirestore.instance
              //                     .collection('employees')
              //                     .doc(friendId)
              //                     .get(),
              //                 builder: (context,
              //                     AsyncSnapshot<DocumentSnapshot>
              //                         asyncSnapshot) {
              //                   if (asyncSnapshot.connectionState ==
              //                       ConnectionState.waiting) {
              //                     return LinearProgressIndicator();
              //                   } else if (asyncSnapshot.hasError) {
              //                     return Text('Error: ${asyncSnapshot.error}');
              //                   } else if (!asyncSnapshot.hasData ||
              //                       !asyncSnapshot.data!.exists) {
              //                     // Friend's data not found or doesn't exist
              //                     return Text('Friend data not available.');
              //                   }
              //                   var friendData = asyncSnapshot.data!.data()
              //                       as Map<String, dynamic>;
              //                   var friendName = friendData['name'];
              //                   var friendImage = friendData['image'];
              //                   return ListTile(
              //                     leading: CircleAvatar(
              //                       backgroundImage: NetworkImage(friendImage),
              //                       radius: 25,
              //                     ),
              //                     title: Text(friendName),
              //                     subtitle: Text(
              //                       "$lastMsg",
              //                       style: const TextStyle(color: Colors.grey),
              //                       overflow: TextOverflow.ellipsis,
              //                     ),
              //                     onTap: () {
              //                       Navigator.push(
              //                         context,
              //                         MaterialPageRoute(
              //                           builder: (context) => ChatScreen(
              //                             currentUser: widget.userData!,
              //                             friendId: friendId,
              //                             friendName: friendName,
              //                             friendImage: friendImage,
              //                           ),
              //                         ),
              //                       );
              //                     },
              //                   );
              //                 },
              //               );
              //               // FutureBuilder(
              //               //   future: FirebaseFirestore.instance
              //               //       .collection('employees')
              //               //       .doc(friendId)
              //               //       .get(),
              //               //   builder: (context, AsyncSnapshot asyncSnapshot) {
              //               //     if (asyncSnapshot.hasData) {
              //               //       var friend = asyncSnapshot.data;
              //               //       return ListTile(
              //               //         leading: CircleAvatar(
              //               //           backgroundImage:
              //               //               NetworkImage(friend['image']),
              //               //           radius: 25,
              //               //         ),
              //               //         title: Text(friend['name']),
              //               //         subtitle: Text(
              //               //           "$lastMsg",
              //               //           style:
              //               //               const TextStyle(color: Colors.grey),
              //               //           overflow: TextOverflow.ellipsis,
              //               //         ),
              //               //         onTap: () {
              //               //           Navigator.push(
              //               //               context,
              //               //               MaterialPageRoute(
              //               //                   builder: (context) => ChatScreen(
              //               //                       currentUser: widget.userData!,
              //               //                       friendId: friend['id'],
              //               //                       friendName: friend['name'],
              //               //                       friendImage:
              //               //                           friend['image'])));
              //               //         },
              //               //       );
              //               //     }
              //               //     return const LinearProgressIndicator();
              //               //   },
              //               // );
              //             });
              //       }
              //       return const Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     }),

              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('employees')
                      .where('role', isEqualTo: 'user').where('status',isEqualTo: 'Active')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    else if (snapshot.data!.docs.isEmpty) {
                return const Text(
                  'No Employee Foound please',
                );
              }
                     else if (snapshot.hasError) {
                      return const Center(
                        child: Text("Something went wrong"),
                      );
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text("No Users Available"),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var userData = snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;
                        var friendId = snapshot.data!.docs[index].id;
                        var friendName = userData['name'];
                        var friendImage = userData['image'];
                        // var lastMsg = userData['last_msg'];
                        var friendTeam = userData['team'];
                        var role = userData['role'];

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(friendImage),
                            radius: 25,
                          ),
                          title: Text(friendName),
                          subtitle: Text(
                            // lastMsg != null ? "$lastMsg" : friendTeam,
                            role,
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
                                  friendTeam: friendTeam,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
