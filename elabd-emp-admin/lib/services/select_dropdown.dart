import 'package:elabd_ems_admin/helper/import_helper.dart';

class SelectDropdown with ChangeNotifier{
    String? _selectedTeam; // Selected team name
  List<String> _teamNames = [];

  String? get selectedTeam => _selectedTeam;
  List<String> get teamNames => _teamNames;

  void updateTeamNames(List<String> names) {
    _teamNames = names;
    notifyListeners();
  }

  set selectedTeam(String? team) {
    _selectedTeam = team;
    notifyListeners();
  }
}