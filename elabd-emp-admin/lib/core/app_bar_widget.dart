import 'package:elabd_ems_admin/helper/import_helper.dart';

class AppBarWidget extends StatelessWidget implements PreferredSize {
  const AppBarWidget({super.key, required this.title, this.isLeading = true});
  final String title;
  final bool isLeading;
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Padding(
      padding: EdgeInsets.only(
          top: MySize.size30, left: MySize.size10, right: MySize.size10),
      child: Center(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          isLeading
              ? GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    height: MySize.size30,
                    width: MySize.size30,
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Image.asset(
                        AppIcons.appbararrowback,
                        height: MySize.size17,
                        width: MySize.size8,
                      ),
                    ),
                  ),
                )
              : const SizedBox(
                  height: 30,
                  width: 30,
                ),
          Text(
            title,
            style: poppinSemiBold.copyWith(fontSize: MySize.size18),
          ),
          SizedBox(
            height: MySize.size20,
            width: MySize.size20,
          )
        ]),
      ),
    );
  }

  @override
  Widget get child => Container();

  @override
  Size get preferredSize => Size.fromHeight(MySize.size56);
}
