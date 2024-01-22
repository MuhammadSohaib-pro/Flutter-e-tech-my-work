// ignore_for_file: use_build_context_synchronously
import 'package:event_app/helper/imports.dart';
import 'package:event_app/screens/menu/menu_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    return ScrollableColumn(
      children: [
        AppBar(
          title: Text(
            AppLocalizations.of(context)!.menu.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ThemeColors.black1,
              fontSize: MySize.size16,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        SizedBox(height: MySize.size30),
        Padding(
          padding: Spacing.horizontal(MySize.size32),
          child: InkWell(
            onTap: () {},
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            child: Container(
              width: double.infinity,
              height: MySize.size105,
              decoration: ShapeDecoration(
                color: ThemeColors.mainColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                shadows: const [
                  BoxShadow(
                    color: Color(0x1C000000),
                    blurRadius: 20,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    icWhatsapp,
                    height: MySize.size26,
                    width: MySize.size26,
                  ),
                  SizedBox(height: MySize.size6),
                  Text(
                    AppLocalizations.of(context)!.chatnow.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeColors.bgColor,
                      fontSize: MySize.size14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: MySize.size30),
        Consumer<MenuProvider>(
          builder: (context, p, child) => Padding(
            padding: Spacing.horizontal(MySize.size32),
            child: SettingTile(
              icon: icNotification,
              title: AppLocalizations.of(context)!.getUpdated.toString(),
              subtitle: AppLocalizations.of(context)!.notifications.toString(),
              showBtn: true,
              btnValue: p.notificationFlag,
              onChange: (p0) {
                p.setNotificationFlag(p0);
              },
            ),
          ),
        ),
        SizedBox(height: MySize.size20),
        Padding(
          padding: Spacing.horizontal(MySize.size32),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileView(),
                ),
              );
            },
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            child: SettingTile(
              icon: icPerson,
              title: AppLocalizations.of(context)!.profile.toString(),
              subtitle:
                  AppLocalizations.of(context)!.personalInformation.toString(),
              showBtn: false,
            ),
          ),
        ),
        SizedBox(height: MySize.size20),
        Padding(
          padding: Spacing.horizontal(MySize.size32),
          child: InkWell(
            onTap: () {
              showAdaptiveDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    backgroundColor: Colors.transparent,
                    child: Container(
                      height: MySize.size180,
                      width: MySize.size180,
                      decoration: BoxDecoration(
                          color: ThemeColors.bgColor,
                          borderRadius: BorderRadius.circular(MySize.size30)),
                      child: Consumer<AppLanguage>(
                        builder: (context, provider, child) => Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .selectLanguage
                                  .toString(),
                              style: TextStyle(
                                color: ThemeColors.black1,
                                fontSize: MySize.size14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: MySize.size10),
                            RadioListTile(
                              value: "English",
                              groupValue: provider.groupValue,
                              title: Text(
                                "English",
                                style: TextStyle(
                                  color: ThemeColors.mainColor,
                                  fontSize: MySize.size12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              activeColor: ThemeColors.mainColor,
                              onChanged: (value) {
                                provider.changeGroupValue(value!);
                                provider.changeLanguage(const Locale('en'));
                                Navigator.pop(context);
                              },
                            ),
                            RadioListTile(
                              value: "Arabic",
                              groupValue: provider.groupValue,
                              title: Text(
                                "عربی",
                                style: TextStyle(
                                  color: ThemeColors.mainColor,
                                  fontSize: MySize.size12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              activeColor: ThemeColors.mainColor,
                              onChanged: (value) {
                                provider.changeGroupValue(value!);
                                provider.changeLanguage(const Locale('ar'));
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            child: Consumer<AppLanguage>(
              builder: (context, provider, child) => SettingTile(
                icon: icGlobe,
                title: AppLocalizations.of(context)!.language.toString(),
                subtitle: provider.appLocal == const Locale('ar')
                    ? AppLocalizations.of(context)!.arabic.toString()
                    : AppLocalizations.of(context)!.english.toString(),
                showBtn: false,
              ),
            ),
          ),
        ),
        SizedBox(height: MySize.size20),
        Padding(
          padding: Spacing.horizontal(MySize.size32),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsView(),
                ),
              );
            },
            child: SettingTile(
              icon: icSettingOutlined,
              title: AppLocalizations.of(context)!.settings.toString(),
              subtitle: AppLocalizations.of(context)!.appSettings.toString(),
              showBtn: false,
            ),
          ),
        ),
      ],
    );
  }
}
