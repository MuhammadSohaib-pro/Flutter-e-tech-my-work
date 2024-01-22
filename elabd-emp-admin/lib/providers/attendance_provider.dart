import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/model/attendance_model.dart';

class AttendanceProvider with ChangeNotifier {
  List<AttendanceModel> _checkInOutList = [];

  List<AttendanceModel> get checkInOutList => _checkInOutList;

  clearCheckInOutList(){
    _checkInOutList.clear();
  }
  setCheckInOutList(List<AttendanceModel> value){
    _checkInOutList.clear();
    _checkInOutList=value;
    notifyListeners();
  }
}
