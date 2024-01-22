import 'package:activityapp/global/colors.dart';
import 'package:activityapp/global/component/custom_buttons.dart';
import 'package:activityapp/global/layout/asset_images.dart';
import 'package:activityapp/global/layout/mySize.dart';
import 'package:activityapp/global/layout/textstyle.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.ticketcolor,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Store',
          style: MyTextStyles.latoTextstyle(15, FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          Center(
            child: TextButton(
              onPressed: () {},
              style: const ButtonStyle(
                overlayColor: MaterialStatePropertyAll(Colors.transparent),
              ),
              child: Text(
                'Skip',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: const Color(0xFF2538E8),
                  fontSize: MySize.size12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MySize.size20),
            Padding(
              padding: Spacing.horizontal(MySize.size32),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 30,
                      child: CustomButton8(
                        text: "Drinks",
                        backgroundColor: const Color(0xFF0D1632),
                        radius: 30,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: MySize.size10),
                    SizedBox(
                      width: 100,
                      height: 30,
                      child: CustomButton8(
                        text: "Food",
                        backgroundColor: Colors.transparent,
                        textColor: Colors.black,
                        radius: 30,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: MySize.size10),
                    SizedBox(
                      width: 100,
                      height: 30,
                      child: CustomButton8(
                        text: "Equipments",
                        backgroundColor: Colors.transparent,
                        textColor: Colors.black,
                        radius: 30,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: MySize.size10),
                    SizedBox(
                      width: 100,
                      height: 30,
                      child: CustomButton8(
                        text: "Other",
                        backgroundColor: Colors.transparent,
                        textColor: Colors.black,
                        radius: 30,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MySize.size30),
            StoreItemWidget(
              image: "",
              name: "Water Bottle- 50ml",
              price: "50",
              onPressed: () async {
                await customDetailModalSheet(context);
              },
            ),
            SizedBox(height: MySize.size10),
            StoreItemWidget(
              image: "",
              name: "Juice- 50ml",
              price: "50",
              quantity: 2,
              onPressed: () async {
                await customDetailModalSheet(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> customDetailModalSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MySize.size270,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: const DecorationImage(
                        image: AssetImage(
                          AssetImages.juiceImage,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: Spacing.all(MySize.size20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: MySize.size15),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Drinks',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MySize.size16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star_rate_rounded,
                                color: AppColors.primaryColor,
                                size: MySize.size16),
                            SizedBox(width: MySize.size4),
                            Text(
                              '5.0/',
                              style: TextStyle(
                                color: AppColors.textColorblack,
                                fontSize: MySize.size12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: MySize.size6),
                            Text(
                              '+100',
                              style: TextStyle(
                                color: AppColors.greyText,
                                fontSize: MySize.size12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Text(
                      "AED: 500",
                      style: TextStyle(
                        color: const Color(0xFF2538E8),
                        fontSize: MySize.size16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MySize.size20),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Text(
                  'About Product',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: MySize.size14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: MySize.size10),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Text(
                  'Mango Juice\nApple Juice\nStrawberry Juice\nBanana Shake',
                  style: TextStyle(
                    color: const Color(0xFF9F9F9F),
                    fontSize: MySize.size10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: MySize.size40),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: CustomButton8(
                  text: "Add to Cart",
                  radius: 30,
                  backgroundColor: AppColors.primaryColor,
                  onPressed: () {},
                ),
              ),
              SizedBox(height: MySize.size30),
            ],
          ),
        );
      },
    );
  }
}

class StoreItemWidget extends StatelessWidget {
  const StoreItemWidget({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    this.quantity,
    required this.onPressed,
  });

  final String image;
  final VoidCallback onPressed;
  final String name;
  final String price;
  final int? quantity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Spacing.horizontal(MySize.size33),
      child: GestureDetector(
        onTap: onPressed,
        child: SizedBox(
          width: double.infinity,
          height: MySize.size90,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MySize.size87,
                      height: MySize.size87,
                      decoration: ShapeDecoration(
                        image: const DecorationImage(
                          image:
                              NetworkImage("https://via.placeholder.com/87x87"),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(width: MySize.size14),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            color: const Color(0xFF0D1632),
                            fontSize: MySize.size14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: MySize.size10),
                        Text(
                          'AED: $price',
                          style: TextStyle(
                            color: const Color(0xFF2538E8),
                            fontSize: MySize.size16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  quantity != null
                      ? Container(
                          width: MySize.size18,
                          height: MySize.size18,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 0.50,
                                color: Color(0xFFAAB1F6),
                              ),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.remove,
                            color: AppColors.primaryColor,
                            size: MySize.size12,
                          ),
                        )
                      : const SizedBox(),
                  quantity != null
                      ? const SizedBox(width: 6)
                      : const SizedBox(),
                  quantity != null
                      ? Text(
                          '$quantity',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MySize.size10,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : const SizedBox(),
                  quantity != null
                      ? const SizedBox(width: 6)
                      : const SizedBox(),
                  Container(
                    width: MySize.size18,
                    height: MySize.size18,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 0.50,
                          color: Color(0xFFAAB1F6),
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.add,
                      color: AppColors.primaryColor,
                      size: MySize.size12,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
