import 'package:event_app/helper/imports.dart';

class KitchenFilterView extends StatefulWidget {
  const KitchenFilterView({super.key});

  @override
  State<KitchenFilterView> createState() => _KitchenFilterViewState();
}

class _KitchenFilterViewState extends State<KitchenFilterView> {
  TextEditingController fromLocationController = TextEditingController();
  TextEditingController toLocationController = TextEditingController();
  TextEditingController fromPriceController = TextEditingController();
  TextEditingController toPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.bgColor,
        title: Text(
          AppLocalizations.of(context)!.filter.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.black1,
            fontSize: MySize.size16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {},
            style: const ButtonStyle(
              overlayColor: MaterialStatePropertyAll(Colors.transparent),
            ),
            child: Text(
              AppLocalizations.of(context)!.clearAll.toString(),
              style: TextStyle(
                color: ThemeColors.mainColor,
                fontSize: MySize.size16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ScrollableColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MySize.size50),
            Padding(
              padding: Spacing.horizontal(MySize.size32),
              child: Text(
                AppLocalizations.of(context)!.categories.toString(),
                style: TextStyle(
                  color: ThemeColors.black1,
                  fontSize: MySize.size14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: MySize.size15),
            Padding(
              padding: Spacing.horizontal(MySize.size32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MySize.size95,
                    height: MySize.size40,
                    child: CustomButton8(
                      text: AppLocalizations.of(context)!.popular.toString(),
                      backgroundColor: ThemeColors.mainColor,
                      radius: 30,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: MySize.size95,
                    height: MySize.size40,
                    child: CustomButton8(
                      text: AppLocalizations.of(context)!.keys.toString(),
                      backgroundColor: ThemeColors.mainColor,
                      radius: 30,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: MySize.size95,
                    height: MySize.size40,
                    child: CustomButton8(
                      text:
                          AppLocalizations.of(context)!.authorities.toString(),
                      backgroundColor: ThemeColors.mainColor,
                      radius: 30,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MySize.size30),
            Padding(
              padding: Spacing.horizontal(MySize.size32),
              child: Text(
                AppLocalizations.of(context)!.rating.toString(),
                style: TextStyle(
                  color: ThemeColors.black1,
                  fontSize: MySize.size14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: MySize.size10),
            Padding(
              padding: Spacing.fromLTRB(MySize.size32, 0, MySize.size32, 0),
              child: RatingBar(
                initialRating: 0,
                direction: Axis.horizontal,
                itemCount: 5,
                itemSize: MySize.size20,
                ratingWidget: RatingWidget(
                  full: const Icon(
                    Icons.star,
                    color: ThemeColors.mainColor,
                  ),
                  half: const Icon(Icons.star, color: ThemeColors.mainColor),
                  empty: const Icon(
                    Icons.star,
                    color: Colors.grey,
                  ),
                ),
                glow: false,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: (rating) {
                  // print(rating);
                },
              ),
            ),
            SizedBox(height: MySize.size30),
            Padding(
              padding: Spacing.horizontal(MySize.size32),
              child: Text(
                AppLocalizations.of(context)!.location.toString(),
                style: TextStyle(
                  color: ThemeColors.black1,
                  fontSize: MySize.size14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: MySize.size12),
            Padding(
              padding: Spacing.horizontal(MySize.size32),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField13(
                      controller: fromLocationController,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      hintText: "0 Km",
                      title: AppLocalizations.of(context)!.from.toString(),
                      fillColor: ThemeColors.fillColor,
                      validator: (value) {
                        return CommonFunctions.validateTextField(value);
                      },
                    ),
                  ),
                  SizedBox(width: MySize.size20),
                  Expanded(
                    child: CustomTextField13(
                      controller: toLocationController,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      hintText: "0 Km",
                      title: AppLocalizations.of(context)!.to.toString(),
                      fillColor: ThemeColors.fillColor,
                      validator: (value) {
                        return CommonFunctions.validateTextField(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MySize.size30),
            Padding(
              padding: Spacing.horizontal(MySize.size32),
              child: Text(
                AppLocalizations.of(context)!.price.toString(),
                style: TextStyle(
                  color: ThemeColors.black1,
                  fontSize: MySize.size14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: MySize.size12),
            Padding(
              padding: Spacing.horizontal(MySize.size32),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField13(
                      controller: fromPriceController,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      hintText: "0",
                      title: AppLocalizations.of(context)!.from.toString(),
                      fillColor: ThemeColors.fillColor,
                      validator: (value) {
                        return CommonFunctions.validateTextField(value);
                      },
                    ),
                  ),
                  SizedBox(width: MySize.size20),
                  Expanded(
                    child: CustomTextField13(
                      controller: toPriceController,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      hintText: "0",
                      title: AppLocalizations.of(context)!.to.toString(),
                      fillColor: ThemeColors.fillColor,
                      validator: (value) {
                        return CommonFunctions.validateTextField(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MySize.size30),
            const Spacer(),
            Padding(
              padding: Spacing.horizontal(MySize.size32),
              child: CustomButton8(
                text: AppLocalizations.of(context)!.apply.toString(),
                backgroundColor: ThemeColors.mainColor,
                radius: 30,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(height: MySize.size30),
          ],
        ),
      ),
    );
  }
}
