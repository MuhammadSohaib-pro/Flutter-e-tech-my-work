import 'package:falconsesportsapp/helper/constant.dart';
import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:falconsesportsapp/views/product_details/components/product_size_widget.dart';
import 'package:falconsesportsapp/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              color: ThemeColors.green,
              child: Column(
                children: [
                  SizedBox(
                    height: MySize.size300,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: ThemeColors.mainColor,
                    ),
                    child: Padding(
                      padding: Spacing.horizontal(MySize.size27),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: MySize.size50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 18,
                                height: 2,
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                              ),
                              SizedBox(width: MySize.size5),
                              Container(
                                width: 2,
                                height: 2,
                                decoration: BoxDecoration(
                                  color: Colors.white
                                      .withOpacity(0.4000000059604645),
                                ),
                              ),
                              SizedBox(width: MySize.size5),
                              Container(
                                width: 2,
                                height: 2,
                                decoration: BoxDecoration(
                                  color: Colors.white
                                      .withOpacity(0.4000000059604645),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: MySize.size20),
                          Text(
                            'LIQUID X NARUTO AKATSUKI TSUKUYOMI ITACHI PACKABLE TECH JACKET',
                            style: TextStyle(
                              color: ThemeColors.bgColor,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rate_rounded,
                                color: ThemeColors.green,
                              ),
                              SizedBox(width: MySize.size4),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '5.0/',
                                      style: TextStyle(
                                        color: ThemeColors.bgColor,
                                        fontSize: MySize.size10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '100+',
                                      style: TextStyle(
                                        color: ThemeColors.lightBgColor,
                                        fontSize: MySize.size10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: MySize.size20),
                          Text(
                            'Size',
                            style: TextStyle(
                              color: ThemeColors.bgColor,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: MySize.size20),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ProductSizeWidget(
                                  backgroundColor: ThemeColors.bgLight2Color,
                                  onPressed: () {},
                                  text: 'XXS',
                                ),
                                SizedBox(width: MySize.size10),
                                ProductSizeWidget(
                                  backgroundColor: ThemeColors.bgLight2Color,
                                  onPressed: () {},
                                  text: 'XS',
                                ),
                                SizedBox(width: MySize.size10),
                                ProductSizeWidget(
                                  backgroundColor: ThemeColors.bgLight2Color,
                                  onPressed: () {},
                                  text: 'SM',
                                ),
                                SizedBox(width: MySize.size10),
                                ProductSizeWidget(
                                  backgroundColor: ThemeColors.green,
                                  onPressed: () {},
                                  text: 'MD',
                                ),
                                SizedBox(width: MySize.size10),
                                ProductSizeWidget(
                                  backgroundColor: ThemeColors.bgLight2Color,
                                  onPressed: () {},
                                  text: 'LG',
                                ),
                                SizedBox(width: MySize.size10),
                                ProductSizeWidget(
                                  backgroundColor: ThemeColors.bgLight2Color,
                                  onPressed: () {},
                                  text: 'XL',
                                ),
                                SizedBox(width: MySize.size10),
                                ProductSizeWidget(
                                  backgroundColor: ThemeColors.bgLight2Color,
                                  onPressed: () {},
                                  text: '2XL',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: MySize.size30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Discription',
                                    style: TextStyle(
                                      color: ThemeColors.grey1,
                                      fontSize: MySize.size12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: MySize.size2),
                                  Container(
                                    width: MySize.size58,
                                    height: MySize.size2,
                                    decoration: const BoxDecoration(
                                      color: ThemeColors.green,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Shipping',
                                    style: TextStyle(
                                      color: ThemeColors.grey1,
                                      fontSize: MySize.size12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: MySize.size2),
                                  Container(
                                    width: MySize.size58,
                                    height: MySize.size2,
                                    decoration: const BoxDecoration(
                                      color: ThemeColors.green,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Return Policy',
                                    style: TextStyle(
                                      color: ThemeColors.grey1,
                                      fontSize: MySize.size12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: MySize.size2),
                                  Container(
                                    width: MySize.size58,
                                    height: MySize.size2,
                                    decoration: const BoxDecoration(
                                      color: ThemeColors.green,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: MySize.size20),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      'Custom-made, removable hood, contrast mesh lining, inner removable shoulder straps, and pockets throughout. This adaptive tech jacket is fully equipped and brings all elements of the Akatsuki collection to one iconic piece.\n',
                                  style: TextStyle(
                                    color: ThemeColors.grey1,
                                    fontSize: MySize.size10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '\t100% Cotton Outer\n\t100% Polyester Lining\n\tCustom relaxed fit\n\tRemovable hood\n\tFront, sleeve, and back cargo pockets\n\tContrast mesh lining with screenprint\n\tInner removable and adaptive shoulder straps\n\tEmbroidery on back\n\tTeam Liquid x Naruto trims\n\tImported\n\n',
                                  style: TextStyle(
                                    color: ThemeColors.grey1,
                                    fontSize: MySize.size10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'PREBOOKS: Shipping early to mid 2024 and cannot accept cancelations after order is placed. We reserve the right to cancel any pre-book order due to minimum order quantities.',
                                  style: TextStyle(
                                    color: ThemeColors.grey1,
                                    fontSize: MySize.size10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: MySize.size20),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: Spacing.top(MySize.size45),
              child: SizedBox(
                width: MySize.size330,
                height: MySize.size290,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: MySize.size290,
                            height: MySize.size290,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: const DecorationImage(
                                  image: AssetImage(imgJackets),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: MySize.size36,
                            height: MySize.size36,
                            decoration: const ShapeDecoration(
                              color: ThemeColors.bgColor,
                              shape: OvalBorder(),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x30000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 2),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: ThemeColors.mainColor,
                              size: MySize.size18,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: MySize.size36,
                            height: MySize.size36,
                            decoration: const ShapeDecoration(
                              color: Color(0xFFEB944C),
                              shape: OvalBorder(),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x30000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 2),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: ThemeColors.mainColor,
                              size: MySize.size18,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      persistentFooterButtons: [
        Padding(
          padding: Spacing.horizontal(MySize.size27),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price',
                    style: TextStyle(
                      color: ThemeColors.grey1,
                      fontSize: MySize.size10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: MySize.size3),
                  Text(
                    '\$70',
                    style: TextStyle(
                      color: ThemeColors.green,
                      fontSize: MySize.size22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              FlexibleButton(
                height: MySize.size47,
                width: MySize.size145,
                textSize: MySize.size16,
                backgroundColor: Colors.white.withOpacity(0.10999999940395355),
                textColor: ThemeColors.bgColor,
                text: "Add to Cart",
                weight: FontWeight.w400,
                radius: 30,
                onPressed: () {},
              ),
            ],
          ),
        )
      ],
    );
  }
}
