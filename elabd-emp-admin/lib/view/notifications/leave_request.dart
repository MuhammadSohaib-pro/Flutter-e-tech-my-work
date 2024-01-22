import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/view/notifications/components/leave_request_card.dart';
import '../../model/leave_request_model.dart';

class LeaveRequest extends StatelessWidget {
  const LeaveRequest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: const AppBarWidget(title: 'Leave Requests'),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MySize.size16),
          child: Column(
            children: [
              SizedBox(
                height: MySize.size20,
              ),
              // StreamBuilder<QuerySnapshot>(
              //   stream: FirebaseFirestore.instance
              //       .collection('notifications')
              //       .snapshots(),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return const CircularProgressIndicator(); // Loading indicator
              //     } else if (!snapshot.hasData) {
              //       return const Center(
              //         child: Text("No Notification Found"),
              //       );
              //     } else if (snapshot.hasError) {
              //       return Text('Error: ${snapshot.error}');
              //     } else if (snapshot.hasData) {
              //       List<NotificationModel> notifications =
              //           snapshot.data!.docs.map((doc) {
              //         Map<String, dynamic> data =
              //             doc.data() as Map<String, dynamic>;
              //         return NotificationModel.fromJson(data);
              //       }).toList();
              //       return ListView.separated(
              //         separatorBuilder: (context, index) => SizedBox(
              //           height: MySize.size15,
              //         ),
              //         itemCount: notifications.length,
              //         shrinkWrap: true,
              //         physics: const NeverScrollableScrollPhysics(),
              //         itemBuilder: (context, index) {
              //           debugPrint(snapshot.data!.docs[index].id);
              //           return LeaveRequestCard(
              //             documentId: snapshot.data!.docs[index].id,
              //             date: notifications[index].currentDate,
              //             desc: notifications[index].desc,
              //             image: notifications[index].image,
              //             name: notifications[index].name,
              //             status: notifications[index].status,
              //           );
              //         },
              //       );
              //     } else {
              //       return const Text('No notifications found.');
              //     }
              //   },
              // )

              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('leaveRequests')
                    .where('status', isEqualTo: 'Pending') // Filter by status
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator()); // Loading indicator
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text("No Pending Notification Found"),
                    );
                  } else if (snapshot.data!.docs.isEmpty) {
                    return const Text(
                      'No thing found ',
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    List<LeaveRquestModel> notifications =
                        snapshot.data!.docs.map((doc) {
                      Map<String, dynamic> data =
                          doc.data() as Map<String, dynamic>;
                      return LeaveRquestModel.fromJson(data);
                    }).toList();
                    print(snapshot.data!.docs.first.data());
                    return ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: MySize.size15,
                      ),
                      itemCount: notifications.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        debugPrint(snapshot.data!.docs[index].id);

                        return LeaveRequestCard(
                          documentId: snapshot.data!.docs[index].id,
                          date: notifications[index].currentDate,
                          leaveDate: notifications[index].leaveDate,
                          desc: notifications[index].desc,
                          image: notifications[index].image,
                          name: notifications[index].name,
                          status: notifications[index].status,
                          team: notifications[index].team,
                          currentUserId: notifications[index].userId,
                        );
                      },
                    );
                  } else {
                    return const Text('No notifications found.');
                  }
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
