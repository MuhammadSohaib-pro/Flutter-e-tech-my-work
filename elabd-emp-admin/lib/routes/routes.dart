import 'package:elabd_ems_admin/routes/routes_const.dart';
import 'package:elabd_ems_admin/view/auth/login_view/login_view.dart';
import 'package:elabd_ems_admin/view/generate_salary_view/genrate_salary.dart';
import 'package:elabd_ems_admin/view/generate_salary_view/success_screen.dart';
import 'package:elabd_ems_admin/view/home_view/home_view.dart';
import 'package:elabd_ems_admin/view/manage_employe_view/add_new_employe.dart';
import 'package:elabd_ems_admin/view/manage_employe_view/employe_details.dart';
import 'package:elabd_ems_admin/view/manage_task_view/add_task.dart';
import 'package:elabd_ems_admin/view/manage_task_view/manage_task_view.dart';
import 'package:elabd_ems_admin/view/notifications/notification_view.dart';
import 'package:elabd_ems_admin/view/setting_view/setting_view.dart';
import 'package:elabd_ems_admin/view/splash_view/splash_view.dart';
import '../helper/import_helper.dart';
import '../view/bottom_navigation_bar/bottom_navigation_bar.dart';
import '../view/profile/profile_view.dart';

final Map<String, WidgetBuilder> routes = {
  splash: (context) => const SplashView(),
  login: (context) => LoginView(),
  home: (context) => const HomeView(),
  setting: (context) => const SettingView(),
  // resetPassword: (context) => ResetPassword(),
  profile: (context) => const ProfileView(),
  manageTask: (context) => const ManageTaskView(),
  addTask: (context) => const AddTask(),
  // taskDetail: (context) => const TaskDetail(),
  bottomNavigation: (context) => BottomNavigationBarView(),
  // employeTeam: (context) => EmployeTeam(),
  addnewEmploye: (context) => AddNewEmploye(),
  employeDetail: (context) => const EmployeDetails(),
  // manageEmployeTeam: (context) => ManageEmployeTeam(),
  genrateSalary: (context) => GenrateSalary(),
  notification: (context) => const NotificationView(),
  // leaveRequest: (context) =>  LeaveRequest(),
  success: (context) => const SuccessScreen(),
};
