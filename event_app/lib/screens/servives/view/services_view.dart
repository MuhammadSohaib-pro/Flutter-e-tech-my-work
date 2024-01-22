import 'package:event_app/helper/imports.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServicesView extends StatefulWidget {
  const ServicesView({super.key});

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.bgColor,
        title: Text(
          AppLocalizations.of(context)!.services.toString(),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MySize.size10),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
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
                          controller: searchController,
                          fillColor: ThemeColors.bgColor,
                          hintText: AppLocalizations.of(context)!
                              .searchItems
                              .toString(),
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: ThemeColors.mainColor,
                          ),
                          radius: 30,
                          validator: (value) {
                            return CommonFunctions.validateTextField(value);
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: MySize.size7),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ServiceFilterView(),
                          ),
                        );
                      },
                      overlayColor:
                          const MaterialStatePropertyAll(Colors.transparent),
                      child: Container(
                        width: MySize.size55,
                        height: MySize.size55,
                        decoration: const ShapeDecoration(
                          color: ThemeColors.bgColor,
                          shape: CircleBorder(),
                          shadows: [
                            BoxShadow(
                              color: Color(0x0C000000),
                              blurRadius: 20,
                              offset: Offset(2, 2),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(icFilters),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MySize.size20),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Text(
                  AppLocalizations.of(context)!.list.toString(),
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Text(
                  AppLocalizations.of(context)!.categoriesDesc.toString(),
                  style: TextStyle(
                    color: ThemeColors.grey1,
                    fontSize: MySize.size10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: MySize.size25),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => CstmKitchenAndServicesCard(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ServiceRestaurantView(),
                      ),
                    );
                  },
                  name: "Taj Services",
                  image: imgChairs,
                ),
                separatorBuilder: (context, index) =>
                    SizedBox(height: MySize.size15),
                itemCount: 5,
              ),
              SizedBox(height: MySize.size25),
            ],
          ),
        ),
      ),
    );
  }
}
