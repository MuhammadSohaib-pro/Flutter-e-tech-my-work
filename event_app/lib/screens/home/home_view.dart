import 'package:event_app/helper/imports.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Consumer<HomeProvider>(
          builder: (context, provider, child) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MySize.size70),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              '${AppLocalizations.of(context)!.enjoyourExcellent.toString()}\n',
                          style: TextStyle(
                            color: ThemeColors.black1,
                            fontSize: MySize.size16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!
                              .foodAndServices
                              .toString(),
                          style: TextStyle(
                            color: ThemeColors.mainColor,
                            fontSize: MySize.size16,
                            fontWeight: FontWeight.w500,
                            height: MySize.size2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MySize.size16),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Column(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: MySize.size180,
                            autoPlay: true,
                            onPageChanged: (index, reason) {
                              provider.setIndicatorIndex(index);
                            },
                          ),
                          items: [1, 2, 3, 4, 5].map(
                            (i) {
                              return Container(
                                width: MySize.screenWidth,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage(imgHomeSlider),
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: Spacing.fromLTRB(MySize.size19,
                                      MySize.size30, MySize.size19, 0),
                                  child: SizedBox(
                                    width: MySize.size200,
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: AppLocalizations.of(context)!
                                                .ourServicesin
                                                .toString(),
                                            style: const TextStyle(
                                              color: ThemeColors.bgColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '\n${AppLocalizations.of(context)!.reasonable.toString()}',
                                            style: const TextStyle(
                                              color: ThemeColors.bgColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '\n${AppLocalizations.of(context)!.prices.toString()}',
                                            style: const TextStyle(
                                              color: ThemeColors.bgColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                        SizedBox(height: MySize.size35),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < 5; i++)
                              Container(
                                width: provider.indicatorIndex == i ? 35 : 4,
                                height: 4,
                                margin: Spacing.horizontal(MySize.size2),
                                decoration: ShapeDecoration(
                                  color: provider.indicatorIndex == i
                                      ? ThemeColors.mainColor
                                      : ThemeColors.grey1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: MySize.size25),
                      ],
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: MySize.size270,
                        height: MySize.size36,
                        margin: Spacing.bottom(MySize.size52),
                        decoration: ShapeDecoration(
                          color: ThemeColors.bgColor,
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: MySize.size20),
                            const Icon(
                              Icons.location_on_rounded,
                              color: ThemeColors.mainColor,
                            ),
                            SizedBox(width: MySize.size8),
                            Text(
                              'Saudi Arabia, Riyadh',
                              style: TextStyle(
                                color: ThemeColors.black1,
                                fontSize: MySize.size12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: Text(
                    AppLocalizations.of(context)!.ourServices.toString(),
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
                    AppLocalizations.of(context)!
                        .ourServicesDescrption
                        .toString(),
                    style: TextStyle(
                      color: ThemeColors.grey1,
                      fontSize: MySize.size10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: MySize.size30),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: HomeServicesCardWidget(
                          icon: icTruck,
                          title:
                              AppLocalizations.of(context)!.services.toString(),
                          description: AppLocalizations.of(context)!
                              .servicesAndKitchenDescription
                              .toString(),
                          bgImage: imgHomeCardOne,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ServicesView(),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: MySize.size15),
                      Expanded(
                        child: HomeServicesCardWidget(
                          icon: icBellCell,
                          title:
                              AppLocalizations.of(context)!.kitchen.toString(),
                          description: AppLocalizations.of(context)!
                              .servicesAndKitchenDescription
                              .toString(),
                          bgImage: imgHomeCardTwo,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const KitchenView(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          color: ThemeColors.bgColor,
          height: MySize.size60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: SizedBox(
                  height: MySize.size30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartView(),
                            ),
                          );
                        },
                        child: SvgPicture.asset(icShoppingBag),
                      ),
                      Text(
                        AppLocalizations.of(context)!.home.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeColors.black1,
                          fontSize: MySize.size16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotificationView(),
                            ),
                          );
                        },
                        child: SvgPicture.asset(icBell),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class HomeServicesCardWidget extends StatelessWidget {
  const HomeServicesCardWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.bgImage,
    required this.onPressed,
  });
  final String icon;
  final String bgImage;
  final String title;
  final String description;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: MySize.size220,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          image: DecorationImage(
            image: AssetImage(bgImage),
            fit: BoxFit.fill,
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 20,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: Spacing.fromLTRB(0, MySize.size15, 0, MySize.size15),
                child: Center(
                  child: SizedBox(
                    width: MySize.size76,
                    height: MySize.size76,
                    child: SvgPicture.asset(icon),
                  ),
                ),
              ),
              Padding(
                padding: Spacing.horizontal(MySize.size16),
                child: Text(
                  title,
                  style: TextStyle(
                    color: ThemeColors.bgColor,
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: Spacing.horizontal(MySize.size16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        description,
                        maxLines: 5,
                        style: TextStyle(
                          color: ThemeColors.bgColor,
                          fontSize: MySize.size10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: MySize.size68,
                  height: MySize.size25,
                  alignment: Alignment.center,
                  decoration: const ShapeDecoration(
                    color: ThemeColors.bgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_outlined,
                    color: ThemeColors.mainColor,
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
