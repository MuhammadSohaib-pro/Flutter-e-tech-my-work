import 'package:elabd_ems_admin/helper/import_helper.dart';

class MultiLineTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final int maxLines;
  const MultiLineTextFieldWidget(
      {super.key, required this.controller, required this.maxLines});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return TextFormField(
      style: poppineRegular.copyWith(fontSize: MySize.size12),
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
          filled: true,
          contentPadding: EdgeInsets.all(MySize.size10),
          fillColor: const Color(0xffF6F6F6),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(MySize.size8))),
    );
  }
}
