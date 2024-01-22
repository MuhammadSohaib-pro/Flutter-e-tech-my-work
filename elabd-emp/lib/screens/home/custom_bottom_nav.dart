import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../models/select_index_controller.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({
    super.key,
    required this.selectIndexCtrl,
  });

  final SelectIndexController selectIndexCtrl;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 5.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        height: 35,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(
              () => InkWell(
                onTap: () => selectIndexCtrl.selectedIndex.value = 0,
                child: Icon(
                  Icons.home_outlined,
                  size: 32.sp,
                  color: (selectIndexCtrl.selectedIndex.value == 0)
                      ? const Color(0xff065F14)
                      : const Color(0xffc5c5c5),
                ),
              ),
            ),
            Obx(
              () => InkWell(
                onTap: () => selectIndexCtrl.selectedIndex.value = 1,
                child: Icon(
                  Icons.description,
                  size: 32.sp,
                  color: (selectIndexCtrl.selectedIndex.value == 1)
                      ? const Color(0xff065F14)
                      : const Color(0xffc5c5c5),
                ),
              ),
            ),
            Obx(
              () => InkWell(
                onTap: () => selectIndexCtrl.selectedIndex.value = 2,
                child: Icon(
                  Icons.assignment_ind,
                  size: 32.sp,
                  color: (selectIndexCtrl.selectedIndex.value == 2)
                      ? const Color(0xff065F14)
                      : const Color(0xffc5c5c5),
                ),
              ),
            ),
            Obx(
              () => InkWell(
                onTap: () => selectIndexCtrl.selectedIndex.value = 3,
                child: Icon(
                  Icons.account_circle,
                  size: 32.sp,
                  color: (selectIndexCtrl.selectedIndex.value == 3)
                      ? const Color(0xff065F14)
                      : const Color(0xffc5c5c5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
