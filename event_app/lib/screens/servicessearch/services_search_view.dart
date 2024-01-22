import 'package:event_app/helper/imports.dart';

class ServiceSearchView extends StatelessWidget {
  const ServiceSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.bgColor,
        elevation: 0.0,
        leadingWidth: MySize.size60,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios, color: ThemeColors.black1),
        ),
        title: Text(
          AppLocalizations.of(context)!.search.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.black1,
            fontSize: MySize.size16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MySize.size10),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Container(
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x0C000000),
                        blurRadius: 20,
                        offset: Offset(2, 2),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: CustomTextField13(
                    controller: TextEditingController(),
                    fillColor: ThemeColors.bgColor,
                    hintText: AppLocalizations.of(context)!.searchItems.toString(),
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: ThemeColors.mainColor,
                    ),
                    radius: 30,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.fieldRequired.toString();
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
