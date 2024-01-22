import 'package:event_app/helper/imports.dart';

class ThankYouView extends StatelessWidget {
  const ThankYouView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MySize.size100,
                width: double.infinity,
              ),
              Image.asset(imgPurchaseCompleted),
              SizedBox(height: MySize.size20),
              Text(
                AppLocalizations.of(context)!.thanks.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeColors.black1,
                  fontSize: MySize.size20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.orderIsPlaced.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeColors.black1,
                  fontSize: MySize.size10,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: MySize.size80),
              SizedBox(
                width: MySize.size190,
                height: MySize.size44,
                child: CustomButton8(
                  backgroundColor: ThemeColors.mainColor,
                  radius: 30,
                  textColor: ThemeColors.bgColor,
                  text: AppLocalizations.of(context)!.trackOrder.toString(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TrackOrderView(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: MySize.size20),
              GestureDetector(
                onTap: () {},
                child: Text(
                  AppLocalizations.of(context)!.returnToHomePage.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
