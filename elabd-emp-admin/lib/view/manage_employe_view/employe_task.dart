import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/view/manage_task_view/components/task_card.dart';
import 'package:intl/intl.dart';

class EmployTask extends StatefulWidget {
  final String? currentUserId;
  const EmployTask({super.key, this.currentUserId});

  @override
  State<EmployTask> createState() => _EmployTaskState();
}

class _EmployTaskState extends State<EmployTask> {
  final ref = FirebaseFirestore.instance.collection('tasks').snapshots();
  final yearController = TextEditingController();
  final monthController = TextEditingController();
  //selection of month year
  List<int> years = [];
  int? selectedYear; // Store the selected year
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  String? selectedMonth;
  int? startOfMonth;
  int? endOfMonth;
  @override
  void initState() {
    super.initState();
    //selection of month year
    int currentYear = DateTime.now().year;
    int startYear = 1990;
    for (int year = currentYear; year >= startYear; year--) {
      years.add(year);
    }
    selectedYear = currentYear;

    selectedMonth = DateFormat('MMMM').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: MySize.size16),
      child: Column(
        children: [
          SizedBox(
            height: MySize.size30,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Expanded(
          //       child: TextFieldWidget(
          //         controller: yearController,
          //         hintText: '2023',
          //         sufixIcon: Padding(
          //           padding: const EdgeInsets.all(16),
          //           child: Image.asset(
          //             AppIcons.calander,
          //             height: 10,
          //             width: 10,
          //           ),
          //         ),
          //       ),
          //     ),
          //     SizedBox(
          //       width: MySize.size50,
          //     ),
          //     Expanded(
          //       child: TextFieldWidget(
          //         controller: monthController,
          //         hintText: 'November',
          //         sufixIcon: Padding(
          //           padding: const EdgeInsets.all(16),
          //           child: Image.asset(
          //             AppIcons.calander,
          //             height: 10,
          //             width: 10,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: MySize.size10, right: MySize.size6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(MySize.size10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: DropdownButton<String>(
                  underline: Container(),

                  value: selectedMonth,
                  // Set the selected month as the value
                  onChanged: (String? month) {
                    setState(() {
                      selectedMonth = month; // Update the selected month
                      convertMonthToUnixTimestamps(month);
                    });
                  },
                  items: [
                    const DropdownMenuItem<String>(
                      value: null,
                      // Set the initial value to null
                      child: Text('Select Month'),
                    ),
                    ...months.map((String month) {
                      return DropdownMenuItem<String>(
                        value: month,
                        child: Text(month),
                      );
                    }).toList(),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: MySize.size10, right: MySize.size6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(MySize.size10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: DropdownButton<int>(
                  underline: Container(),
                  value: selectedYear,
                  // Set the selected year as the value
                  onChanged: (int? year) {
                    setState(() {
                      selectedYear = year; // Update the selected year
                    });
                  },
                  items: [
                    const DropdownMenuItem<int>(
                      value: null,
                      // Set the initial value to null
                      child: Text('Select Year'),
                    ),
                    ...years.map((int year) {
                      return DropdownMenuItem<int>(
                        value: year,
                        child: Text(year.toString()),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(
            height: MySize.size12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                AppIcons.print,
                height: MySize.size14,
                width: MySize.size14,
              ),
              SizedBox(
                width: MySize.size16,
              ),
              Image.asset(
                AppIcons.download,
                height: MySize.size14,
                width: MySize.size14,
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('tasks')
                .where('assignedUserId', isEqualTo: widget.currentUserId)
                .where('unixTimestamp', isGreaterThanOrEqualTo: startOfMonth)
                .where('unixTimestamp', isLessThan: endOfMonth)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text('Error loading tasks');
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Text('No tasks found for the current user');
              } else {
                final tasks = snapshot.data!.docs;

                return Column(
                  children: [
                    SizedBox(
                      height: MySize.size20,
                    ),
                    ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: MySize.size15,
                      ),
                      itemCount: tasks.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final taskData =
                            tasks[index].data() as Map<String, dynamic>;
                        // Create widgets to display task data (e.g., Text, ListTile, etc.)
                        return TaskCard(
                          title: taskData['taskTitle'],
                          status: taskData['taskStatus'],
                        );
                      },
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    ));
  }

  void convertMonthToUnixTimestamps(String? selectedMonth) {
    if (selectedMonth != null) {
      int selectedMonthIndex = months.indexOf(selectedMonth) + 1;
      DateTime startDateTime = DateTime(selectedYear!, selectedMonthIndex);
      DateTime endDateTime =
          startDateTime.add(Duration(days: 32)).subtract(Duration(seconds: 1));

      startOfMonth = startDateTime.millisecondsSinceEpoch ~/ 1000;
      endOfMonth = endDateTime.millisecondsSinceEpoch ~/ 1000;

      // Use startOfMonth and endOfMonth in your Firestore query
      print("Start of month: $startOfMonth");
      print("End of month: $endOfMonth");
    }
  }
}
