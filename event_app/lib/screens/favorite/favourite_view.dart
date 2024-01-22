import 'package:event_app/helper/imports.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text(
            AppLocalizations.of(context)!.favorites.toString(),
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
        Expanded(
          child: ListView.separated(
            itemCount: 5,
            separatorBuilder: (context, index) =>
                SizedBox(height: MySize.size10),
            itemBuilder: (context, index) {
              return newFavourite();
            },
          ),
        ),
      ],
    );
  }

  Widget newFavourite() {
    return Padding(
      padding: Spacing.horizontal(MySize.size32),
      child: Container(
        width: double.infinity,
        height: MySize.size71,
        decoration: ShapeDecoration(
          color: ThemeColors.bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x11000000),
              blurRadius: 10,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Padding(
          padding: Spacing.horizontal(MySize.size10),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: MySize.size60,
                      height: MySize.size60,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imgFavoriteFood),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(width: MySize.size16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Mutton's full.",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: ThemeColors.grey2,
                            fontSize: MySize.size14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: MySize.size6),
                        Text(
                          'AED.1500',
                          style: TextStyle(
                            color: ThemeColors.mainColor,
                            fontSize: MySize.size16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: MySize.size30,
                width: MySize.size30,
                alignment: Alignment.center,
                decoration: const ShapeDecoration(
                  shape: CircleBorder(),
                  color: Color(0xFFD5B6B6),
                ),
                child: Icon(
                  Icons.favorite,
                  color: ThemeColors.mainColor,
                  size: MySize.size20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget favoriteContainer() {
    return SizedBox(
      width: MySize.size160,
      height: MySize.size280,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 0, width: double.infinity),
              SizedBox(height: MySize.size110),
              Expanded(
                child: Container(
                  width: MySize.size140,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE3C5C5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
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
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                width: double.infinity,
                height: MySize.size180,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.bottomCenter,
                    image: AssetImage(imgFavoriteFood),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  width: MySize.size140,
                  child: Column(
                    children: [
                      const SizedBox(width: double.infinity),
                      Text(
                        'Full Lamb Mandi',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: ThemeColors.bgColor,
                          fontSize: MySize.size14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: MySize.size10),
                      Text(
                        'Robe.1500',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeColors.bgColor,
                          fontSize: MySize.size16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: MySize.size10),
                      Container(
                        height: MySize.size30,
                        width: MySize.size30,
                        alignment: Alignment.center,
                        decoration: const ShapeDecoration(
                          shape: CircleBorder(),
                          color: Color(0xFFD5B6B6),
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: ThemeColors.mainColor,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
