import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';

class AddTaskProvider with ChangeNotifier{

  Future<void> addNewTask({
    required context,
    String? taskId,
    String? taskStatus,
    String? taskTitle,
    String? taskPirority,
    String? startDate,
    String? endDate,
    String? taskDetail,
    String? assignedUserId,
    String? selecteUser,
    int? unixTimestamp,

  }) async {
    try {
    SmartDialog.showLoading();
        // var userID = FirebaseAuth.instance.currentUser!.uid;
        await FirebaseFirestore.instance
            .collection('tasks')
            .doc(taskId)
            .set({
          "taskId": taskId,
          "taskStatus": taskStatus,
          "taskTitle": taskTitle,
          "taskPirority": taskPirority,
          "startDate": startDate,
          "endDate": endDate,
          "taskDetail":taskDetail,
          'assignedUserId':assignedUserId,
          'selectedUserName':selecteUser,
          'unixTimestamp':unixTimestamp,
        }).then((value) {
        SmartDialog.dismiss();
        getFlushBar(context, title: 'Successfully Saved',color: primaryColor,isSuccess: true);
      }).onError((error, stackTrace) {
        SmartDialog.dismiss();
        getFlushBar(context, title: error.toString());
      });
    } catch (e) {
      SmartDialog.dismiss();
      getFlushBar(context, title: e.toString());
    }
  }

}