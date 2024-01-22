// ignore_for_file: must_be_immutable

import 'package:event_owner_app/helper/exports.dart';
import 'package:event_owner_app/model/item_model.dart';
import 'package:event_owner_app/screens/kitchen_details/components/item_card.dart';
import 'package:event_owner_app/screens/kitchen_details/kitchen_add_edit_item_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';

class KitchenDetailsView extends StatefulWidget {
  KitchenDetailsView(
      {super.key, required this.restaurantCategory, required this.type});
  String restaurantCategory;
  String type;

  @override
  State<KitchenDetailsView> createState() => _KitchenDetailsViewState();
}

class _KitchenDetailsViewState extends State<KitchenDetailsView>
    with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  // late TabController _tabController;
  String? firstCategory;

  bool iconAndColorFlag = false;
  TextEditingController categoryNameController = TextEditingController();

  List<String> dropdownItemList = ["All"];
  String? selectedCategory;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    // _tabController = TabController(length: 4, vsync: this);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.read<AddEditKitchenProvider>().fetchSomething();
    // });
    Future.delayed(Duration.zero).then((_) {
      context.read<AddEditKitchenProvider>().fetchSomething().then((value) {});
    });
    Future.delayed(Duration.zero).then((_) {
      context.read<AddEditKitchenProvider>().getKitchens().then((value) {});
    });
    super.initState();
  }

  List<ItemModel> itemList = [];
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: ThemeColors.bgColor,
            title: Text(
              AppLocalizations.of(context)!.kitchen.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeColors.black1,
                fontSize: MySize.size16,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              Consumer<AddEditKitchenProvider>(
                builder: (context, p, child) => PopupMenuButton<int>(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Text(
                        AppLocalizations.of(context)!.delete.toString(),
                        style: TextStyle(
                          color: ThemeColors.red,
                          fontSize: MySize.size10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Text(
                        AppLocalizations.of(context)!.edit.toString(),
                        style: TextStyle(
                          color: ThemeColors.black1,
                          fontSize: MySize.size10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                  padding: const EdgeInsets.all(0),
                  onSelected: (value) {
                    if (value == 2) {
                      categoryNameController.text = p.selectedCategry;
                      customAddEditBottomSheet(
                          context: context, process: "Edit");
                    }
                    if (value == 1) {
                      customDeleteDialog(context);
                    }
                  },
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: SizedBox(
                    height: MySize.size36,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("restaurants")
                          .snapshots(),
                      builder: (context, snapshot1) {
                        if (snapshot1.hasData) {
                          String? ref = "";
                          if (snapshot1.data != null) {
                            var data = snapshot1.data!.docs;
                            var id = FirebaseAuth.instance.currentUser!.uid;
                            for (var i = 0; i < data.length; i++) {
                              if (id == data[i].get("ownerId")) {
                                ref = data[i].reference.id;
                              }
                            }
                          }
                          return StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("restaurants")
                                .doc(ref)
                                .collection("kitchens")
                                .snapshots(),
                            builder: (context, snapshot2) {
                              if (snapshot2.hasData) {
                                var data2;
                                if (snapshot2.data != null) {
                                  data2 = snapshot2.data!.docs;
                                  if (data2.isNotEmpty) {
                                    final pr =
                                        Provider.of<AddEditKitchenProvider>(
                                            context,
                                            listen: false);
                                    pr.setCategory(
                                        data2[0].get("categoryName"));
                                    pr.setCategoryReference(
                                        data2[0].reference.id);
                                  }
                                }
                                return data2.isNotEmpty
                                    ? ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) =>
                                            Consumer<AddEditKitchenProvider>(
                                          builder: (context, p, child) =>
                                              TextButton(
                                            onPressed: () {
                                              p.setCategoryNotify(data2[index]
                                                  .get("categoryName"));
                                              p.setNotifyCategoryReference(
                                                  data2[index].reference.id);
                                            },
                                            style: ButtonStyle(
                                              foregroundColor:
                                                  MaterialStatePropertyAll(p
                                                              .selectedCategry ==
                                                          data2[index].get(
                                                              "categoryName")
                                                      ? ThemeColors.mainColor
                                                      : ThemeColors.grey1),
                                            ),
                                            child: Text(
                                                "${data2[index].get("categoryName")}"),
                                          ),
                                        ),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                          width: MySize.size10,
                                        ),
                                        itemCount: data2.length,
                                      )
                                    : const Center(
                                        child: Text("No Category found"),
                                      );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: MySize.size10),
                Consumer<AddEditKitchenProvider>(
                  builder: (context, p, child) => Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("restaurants")
                          .where("ownerId",
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (context, ss) {
                        if (ss.hasData) {
                          var ref;
                          if (ss.data != null) {
                            ref = ss.data!.docs.first.reference.id;
                          }
                          return StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("restaurants")
                                .doc(ref)
                                .collection("kitchenItems")
                                .where("selectedCategoryDoc",
                                    isEqualTo: p.categoryReference)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var data = snapshot.data!.docs;
                                itemList.clear();
                                itemList.addAll(data
                                    .map((e) => ItemModel.fromJson(e.data())));
                                return p.selectedCategry.isNotEmpty ||
                                        itemList.isNotEmpty
                                    ? ListView.builder(
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) =>
                                            InkWell(
                                          onTap: () {
                                            customDetailModalSheet(
                                              context: context,
                                              item: itemList[index],
                                              itemReference: snapshot.data!
                                                  .docs[index].reference.id,
                                            );
                                          },
                                          child: ItemCard(
                                            itemName:
                                                itemList[index].itemName ?? "",
                                            itemImage:
                                                itemList[index].itemImage ?? "",
                                            itemPrice:
                                                itemList[index].itemPrice ?? 0,
                                          ),
                                        ),
                                      )
                                    : const Center(
                                        child: Text("No Item founds"),
                                      );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Consumer<AddEditKitchenProvider>(
            builder: (context, p, child) => FloatingActionBubble(
              items: <Bubble>[
                Bubble(
                  title: AppLocalizations.of(context)!.addItems.toString(),
                  iconColor: Colors.black,
                  bubbleColor: Colors.black,
                  icon: Icons.settings,
                  titleStyle: TextStyle(
                      fontSize: MySize.size10, color: ThemeColors.bgColor),
                  onPress: p.totalCategory.isNotEmpty
                      ? () {
                          _animationController.reverse();
                          setState(() {
                            iconAndColorFlag = !iconAndColorFlag;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const KitchenAddEditItemView(
                                      process: "Add", itemReference: ""),
                            ),
                          );
                        }
                      : () {
                          _animationController.reverse();
                          setState(() {
                            iconAndColorFlag = !iconAndColorFlag;
                          });
                          CommonFunctions.flushBarErrorMessage(
                              "Please Add Categories First", context);
                        },
                ),
                Bubble(
                  title: AppLocalizations.of(context)!.addCategory.toString(),
                  iconColor: Colors.black,
                  bubbleColor: Colors.black,
                  icon: Icons.add,
                  titleStyle: TextStyle(
                      fontSize: MySize.size10, color: ThemeColors.bgColor),
                  onPress: () {
                    _animationController.reverse();
                    setState(() {
                      iconAndColorFlag = !iconAndColorFlag;
                    });
                    categoryNameController.clear();
                    customAddEditBottomSheet(context: context, process: "Add");
                  },
                ),
              ],
              animation: _animation,
              onPress: () => {
                _animationController.isCompleted
                    ? _animationController.reverse()
                    : _animationController.forward(),
                setState(() {
                  iconAndColorFlag = !iconAndColorFlag;
                })
              },
              iconColor: ThemeColors.bgColor,
              iconData: iconAndColorFlag ? Icons.close : Icons.add,
              backGroundColor:
                  iconAndColorFlag ? ThemeColors.black1 : ThemeColors.mainColor,
            ),
          ),
        ),
        Consumer<AddEditKitchenProvider>(
          builder: (context, p, child) =>
              p.showLoader ? const LoaderView() : Container(),
        ),
      ],
    );
  }

  customDeleteDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MySize.size30),
          ),
          child: Container(
            height: MySize.size213,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MySize.size30),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x2B000000),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: Spacing.fromLTRB(
                      MySize.size20, MySize.size15, MySize.size20, 0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          size: MySize.size20,
                          color: ThemeColors.black1,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.warning_amber_rounded,
                  size: MySize.size42,
                  color: ThemeColors.mainColor,
                ),
                SizedBox(height: MySize.size8),
                Text(
                  AppLocalizations.of(context)!.warning.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: MySize.size10),
                Text(
                  AppLocalizations.of(context)!.warningdescrp.toString(),
                  style: TextStyle(
                    color: const Color(0xFF7D7D7D),
                    fontSize: MySize.size12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: MySize.size117,
                  height: MySize.size36,
                  child: CustomButton8(
                    text: AppLocalizations.of(context)!.delete.toString(),
                    radius: MySize.size30,
                    backgroundColor: ThemeColors.mainColor,
                    textColor: ThemeColors.bgColor,
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: MySize.size20),
              ],
            ),
          ),
        );
      },
    );
  }

  customAddEditBottomSheet(
      {required BuildContext context, required String process}) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(MySize.size30),
          topRight: Radius.circular(MySize.size30),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: InkWell(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                decoration: BoxDecoration(
                  color: ThemeColors.bgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(MySize.size30),
                    topRight: Radius.circular(MySize.size30),
                  ),
                ),
                child: Consumer<AddEditKitchenProvider>(
                  builder: (context, p, child) => !p.showLoader
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: Spacing.fromLTRB(
                                  0, MySize.size20, 0, MySize.size30),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  process == "Add"
                                      ? AppLocalizations.of(context)!
                                          .addCategory
                                          .toString()
                                      : AppLocalizations.of(context)!
                                          .editCategory
                                          .toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ThemeColors.black1,
                                    fontSize: MySize.size14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: Spacing.horizontal(MySize.size32),
                              child: CustomTextField13(
                                controller: categoryNameController,
                                hintText: AppLocalizations.of(context)!
                                    .categoryName
                                    .toString(),
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                fillColor: ThemeColors.fillColor,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  return CommonFunctions.validateTextField(
                                      value);
                                },
                              ),
                            ),
                            // Padding(
                            //   padding: Spacing.fromLTRB(MySize.size32, MySize.size10,
                            //       MySize.size32, MySize.size30),
                            //   child: CustomDropdownButton2(
                            //     dropdownItems: dropdownItemList,
                            //     hint: "Select Branch",
                            //     value: selectedCategory,
                            //     onChanged: (value) {
                            //       setState(() {
                            //         selectedCategory = value.toString();
                            //       });
                            //     },
                            //     buttonWidth: double.infinity,
                            //     buttonHeight: 50,
                            //     icon: Icon(
                            //       Icons.keyboard_arrow_down_rounded,
                            //       color: ThemeColors.black1,
                            //       size: MySize.size24,
                            //     ),
                            //     buttonDecoration: BoxDecoration(
                            //       border: Border.all(style: BorderStyle.none),
                            //       color: ThemeColors.fillColor,
                            //       borderRadius: BorderRadius.circular(10),
                            //     ),
                            //     dropdownWidth: (MySize.safeWidth - MySize.size65),
                            //   ),
                            // ),
                            Padding(
                              padding: Spacing.fromLTRB(MySize.size32,
                                  MySize.size20, MySize.size32, MySize.size20),
                              child: CustomButton8(
                                text: process == "Add"
                                    ? AppLocalizations.of(context)!
                                        .add
                                        .toString()
                                    : AppLocalizations.of(context)!
                                        .save
                                        .toString(),
                                onPressed: process == "Add"
                                    ? () {
                                        p
                                            .addNewCategory(
                                                categoryName:
                                                    categoryNameController.text,
                                                restaurantCategory: widget.type,
                                                context: context)
                                            .then((value) {
                                          p.getKitchens();
                                          categoryNameController.clear();
                                        });
                                      }
                                    : () {
                                        p
                                            .editCategory(
                                                categoryName:
                                                    categoryNameController.text,
                                                restaurantCategory: widget.type,
                                                context: context)
                                            .then((value) {
                                          categoryNameController.clear();
                                        });
                                      },
                                backgroundColor: ThemeColors.mainColor,
                                textColor: ThemeColors.bgColor,
                                radius: MySize.size30,
                              ),
                            )
                          ],
                        )
                      : SizedBox(
                          height: MySize.size300,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> customDetailModalSheet({
    required BuildContext context,
    required String itemReference,
    required ItemModel item,
  }) {
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
                  CachedNetworkImage(
                    height: MySize.size270,
                    imageUrl: item.itemImage ?? "",
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0x358B0000),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.image_not_supported_outlined,
                          color: ThemeColors.mainColor,
                          size: 40,
                        ),
                      );
                    },
                    placeholder: (context, url) {
                      return const Center(
                        child: CircularProgressIndicator(strokeWidth: 2.0),
                      );
                    },
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: Spacing.all(MySize.size20),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                            color: ThemeColors.bgColor,
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
                child: Text(
                  item.itemName ?? "",
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: MySize.size10),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Text(
                  item.itemDescription ?? "",
                  style: TextStyle(
                    color: ThemeColors.grey1,
                    fontSize: MySize.size10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: MySize.size20),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "SAR ${item.itemPrice ?? 0}",
                      style: TextStyle(
                        color: ThemeColors.mainColor,
                        fontSize: MySize.size16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star_rate_rounded,
                            color: ThemeColors.yellow, size: MySize.size16),
                        SizedBox(width: MySize.size4),
                        Text(
                          '5.0',
                          style: TextStyle(
                            color: ThemeColors.mainColor,
                            fontSize: MySize.size12,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: MySize.size30),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KitchenAddEditItemView(
                                process: "Edit", itemReference: itemReference),
                          ),
                        );
                      },
                      child: Container(
                        width: MySize.size150,
                        height: MySize.size50,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: ThemeColors.mainColor),
                            borderRadius: BorderRadius.circular(MySize.size30),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x21623C03),
                              blurRadius: 20,
                              offset: Offset(2, 2),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context)!.edit.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeColors.mainColor,
                            fontSize: MySize.size12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: MySize.size20),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: MySize.size150,
                        height: MySize.size50,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: ThemeColors.mainColor),
                            borderRadius: BorderRadius.circular(MySize.size30),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x21623C03),
                              blurRadius: 20,
                              offset: Offset(2, 2),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context)!.delete.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeColors.mainColor,
                            fontSize: MySize.size12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: MySize.size30),
            ],
          ),
        );
      },
    );
  }

// Slidable(
// endActionPane: ActionPane(
// motion: const ScrollMotion(),
// children: [
// SlidableAction(
// onPressed: (context) {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) =>
// const KitchenAddEditItemView(
// process: "Edit"),
// ),
// );
// },
// backgroundColor:const Color(0xff008B48),
// foregroundColor:ThemeColors.bgColor,
// icon: Icons.edit,
// autoClose: true,
// borderRadius:BorderRadius.circular(MySize.size10),),
// SlidableAction(
// onPressed: (context) {
// customDeleteDialog(context);
// },
// backgroundColor:const Color(0xFFE70505),
// foregroundColor:ThemeColors.bgColor,
// borderRadius:BorderRadius.circular(MySize.size10),
// icon: Icons.delete_outlined,
// autoClose: true,
// ),
// ],
// ),
// ),
}
