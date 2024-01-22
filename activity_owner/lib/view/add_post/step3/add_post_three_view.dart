import 'package:activity_owner/helper/constant.dart';
import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:activity_owner/view/add_post/components/custom_circular_bar.dart';
import 'package:activity_owner/view/add_post/components/facilities_tile.dart';
import 'package:activity_owner/view/add_post/step4/add_post_four_view.dart';
import 'package:activity_owner/widgets/custom_buttons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AddPostThreeView extends StatefulWidget {
  const AddPostThreeView({super.key});

  @override
  State<AddPostThreeView> createState() => _AddPostThreeViewState();
}

class _AddPostThreeViewState extends State<AddPostThreeView> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.bgColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.addActivity.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.black1,
            fontSize: MySize.size16,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: Spacing.all(MySize.size10),
            child: CustomCircleProgressIndicator(
                value: "3/3", indicatorValue: 1.0),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MySize.size10),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Text(
                  AppLocalizations.of(context)!.facilities.toString(),
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: MySize.size2),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Text(
                  AppLocalizations.of(context)!.selectFacilities.toString(),
                  style: TextStyle(
                    color: ThemeColors.grey1,
                    fontSize: MySize.size11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: MySize.size15),
              FacilitiesTile(
                checkBoxValue: true,
                onChanged: (value) {},
                icon: icHamburger,
                descrp:
                    'Corem ipsum dolor sit amet, consectetur adipiscing elit.',
              ),
              SizedBox(height: MySize.size20),
              FacilitiesTile(
                checkBoxValue: false,
                onChanged: (value) {},
                icon: icShower,
                descrp:
                    'Corem ipsum dolor sit amet, consectetur adipiscing elit.',
              ),
              SizedBox(height: MySize.size20),
              FacilitiesTile(
                checkBoxValue: true,
                onChanged: (value) {},
                icon: icBed,
                descrp:
                    'Corem ipsum dolor sit amet, consectetur adipiscing elit.',
              ),
              SizedBox(height: MySize.size20),
              FacilitiesTile(
                checkBoxValue: false,
                onChanged: (value) {},
                icon: icWine,
                descrp:
                    'Corem ipsum dolor sit amet, consectetur adipiscing elit.',
              ),
              SizedBox(height: MySize.size20),
              FacilitiesTile(
                checkBoxValue: true,
                onChanged: (value) {},
                icon: icMonitor,
                descrp:
                    'Corem ipsum dolor sit amet, consectetur adipiscing elit.',
              ),
              SizedBox(height: MySize.size80),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Text(
                  AppLocalizations.of(context)!.instructions.toString(),
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Text(
                  'Embark on a tailored experience as you select from our diverse array of activity facilities. Whether you crave the rhythmic thud of a tennis ball on the court, the invigorating laps of a crystal-clear swimming pool, or the strategic buzz of a well-equipped fitness center, our selection caters to every passion. Indulge in the luxury of choice, where each facility is meticulously designed to elevate your experience',
                  style: TextStyle(
                    color: ThemeColors.grey1,
                    fontSize: MySize.size11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: MySize.size100),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton8(
                        text: AppLocalizations.of(context)!.back.toString(),
                        onPressed: () {},
                        radius: MySize.size30,
                        backgroundColor: ThemeColors.fillColor,
                        textColor: ThemeColors.grey1,
                      ),
                    ),
                    SizedBox(width: MySize.size20),
                    Expanded(
                      child: CustomButton8(
                        text: AppLocalizations.of(context)!.finish.toString(),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddPostFourView(),
                            ),
                          );
                        },
                        radius: 30,
                        backgroundColor: ThemeColors.mainColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MySize.size20),
            ],
          ),
        ),
      ),
    );
  }
}
