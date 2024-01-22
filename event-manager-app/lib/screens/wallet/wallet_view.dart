import 'package:event_manager_app/helper/common_functions.dart';
import 'package:event_manager_app/helper/constant.dart';
import 'package:event_manager_app/helper/mySize.dart';
import 'package:event_manager_app/helper/theme_helper.dart';
import 'package:event_manager_app/screens/wallet/withdraw_success_view.dart';
import 'package:event_manager_app/widgets/custom_buttons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:event_manager_app/widgets/custom_textfields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WalletView extends StatefulWidget {
  const WalletView({super.key});

  @override
  State<WalletView> createState() => _WalletViewState();
}

String selectedBtn = "earningHistory";

class _WalletViewState extends State<WalletView> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MySize.size250,
          width: MySize.safeWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imgHomeBg),
              fit: BoxFit.fill,
            ),
            color: ThemeColors.mainColor,
          ),
          child: Padding(
            padding: Spacing.symmetric(horizontal: MySize.size32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MySize.size25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.myWallet.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ThemeColors.bgColor,
                        fontSize: MySize.size16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MySize.size30),
                Text(
                  AppLocalizations.of(context)!.availableBalance.toString(),
                  style: TextStyle(
                    color: const Color(0xFF99A4B3),
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  '\$ 18 420.81',
                  style: TextStyle(
                    color: ThemeColors.bgColor,
                    fontSize: MySize.size32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: MySize.size25),
                CustomButton8(
                  text: AppLocalizations.of(context)!.withdraw.toString(),
                  radius: MySize.size10,
                  backgroundColor:
                      ThemeColors.bgColor.withOpacity(0.23000000417232513),
                  onPressed: () {
                    withdrawAmmountBottomSheet(context);
                  },
                )
              ],
            ),
          ),
        ),
        SizedBox(height: MySize.size20),
        Padding(
          padding: Spacing.horizontal(MySize.size32),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    selectedBtn = "earningHistory";
                  });
                },
                child: Container(
                  width: MySize.size105,
                  height: MySize.size26,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: selectedBtn == "earningHistory"
                        ? ThemeColors.mainColor
                        : Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(MySize.size30),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.earningHistory.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: selectedBtn == "earningHistory"
                          ? Colors.white
                          : ThemeColors.grey4,
                      fontSize: MySize.size10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(width: MySize.size5),
              InkWell(
                onTap: () {
                  setState(() {
                    selectedBtn = "withdrawHistory";
                  });
                },
                child: Container(
                  width: MySize.size110,
                  height: MySize.size26,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: selectedBtn == "withdrawHistory"
                        ? ThemeColors.mainColor
                        : Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(MySize.size30),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.withdrawHistory.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: selectedBtn == "withdrawHistory"
                          ? Colors.white
                          : ThemeColors.grey4,
                      fontSize: MySize.size10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(width: MySize.size5),
              InkWell(
                onTap: () {
                  setState(() {
                    selectedBtn = "myAccount";
                  });
                },
                child: Container(
                  width: MySize.size70,
                  height: MySize.size26,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: selectedBtn == "myAccount"
                        ? ThemeColors.mainColor
                        : Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(MySize.size30),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.account.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: selectedBtn == "myAccount"
                          ? Colors.white
                          : ThemeColors.grey4,
                      fontSize: MySize.size10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: MySize.size20),
        selectedBtn == "earningHistory"
            ? earningHistory(context)
            : selectedBtn == "withdrawHistory"
                ? withdrawHistory(context)
                : account(context),
      ],
    );
  }
}

Widget earningHistory(BuildContext context) {
  return Expanded(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: Spacing.horizontal(MySize.size32),
            child: Text(
              AppLocalizations.of(context)!.totalEarning.toString(),
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
            child: Container(
              width: double.infinity,
              height: MySize.size100,
              decoration: ShapeDecoration(
                color: ThemeColors.black1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(MySize.size10),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x0C191B32),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: MySize.size40,
                      decoration: BoxDecoration(
                          color: ThemeColors.mainColor,
                          borderRadius: BorderRadius.circular(MySize.size10)),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.arrow_circle_left_outlined,
                        color: ThemeColors.bgColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'September 2023',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF99A4B3),
                            fontSize: MySize.size14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '\$ 18 420.81',
                          style: TextStyle(
                            color: ThemeColors.bgColor,
                            fontSize: MySize.size24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: MySize.size40,
                      decoration: BoxDecoration(
                          color: ThemeColors.mainColor,
                          borderRadius: BorderRadius.circular(MySize.size10)),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.arrow_circle_right_outlined,
                        color: ThemeColors.bgColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: MySize.size20),
          Padding(
            padding: Spacing.horizontal(MySize.size32),
            child: Text(
              AppLocalizations.of(context)!.list.toString(),
              style: TextStyle(
                color: ThemeColors.black1,
                fontSize: MySize.size14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: MySize.size10),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => const ReceivedAmountTile(),
            separatorBuilder: (context, index) =>
                SizedBox(height: MySize.size10),
            itemCount: 5,
          ),
        ],
      ),
    ),
  );
}

Widget withdrawHistory(BuildContext context) {
  return Expanded(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: Spacing.horizontal(MySize.size32),
            child: Text(
              AppLocalizations.of(context)!.withdraw.toString(),
              style: TextStyle(
                color: ThemeColors.black1,
                fontSize: MySize.size14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: MySize.size15),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => const WithdrawAmountTile(),
            separatorBuilder: (context, index) => SizedBox(
              height: MySize.size10,
            ),
            itemCount: 8,
          ),
        ],
      ),
    ),
  );
}

Widget account(BuildContext context) {
  return Expanded(
    child: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: Spacing.horizontal(MySize.size32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.myAccounts.toString(),
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                InkWell(
                  onTap: () {
                    addEditBankAccountCard(context, "add");
                  },
                  child: Container(
                    width: MySize.size35,
                    height: MySize.size30,
                    decoration: ShapeDecoration(
                      color: ThemeColors.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(MySize.size5),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x052538E8),
                          blurRadius: 20,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.add,
                      color: ThemeColors.bgColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: MySize.size30),
          BankCard(
            activeCard: true,
            backgroundColor: ThemeColors.mainColor,
            titleColor: const Color(0xFF99A4B3),
            valueColor: ThemeColors.bgColor,
            bankName: "The Saudi Investment Bank",
            bankAccountHolder: "Mr. Wick",
            bankAccountNumber: "81351853813518185",
            bankIBANNumber: "SAU81351853813518185RIYA",
            onPressed: () {
              // setState(() {});
            },
            editOnPressed: () {
              addEditBankAccountCard(context, "edit");
            },
            deleteOnPressed: () {
              deleteBankCardDialog(context);
            },
          ),
          SizedBox(height: MySize.size10),
          BankCard(
            activeCard: false,
            backgroundColor: const Color(0xffdfdfdf),
            titleColor: const Color(0xFF99A4B3),
            valueColor: const Color(0xFF0D1632),
            bankName: "The Saudi Investment Bank",
            bankAccountHolder: "Mr. Wick",
            bankAccountNumber: "81351853813518185",
            bankIBANNumber: "SAU81351853813518185RIYA",
            onPressed: () {
              // setState(() {});
            },
            editOnPressed: () {
              addEditBankAccountCard(context, "edit");
            },
            deleteOnPressed: () {
              deleteBankCardDialog(context);
            },
          ),
          SizedBox(height: MySize.size30),
        ],
      ),
    ),
  );
}

addEditBankAccountCard(BuildContext context, String type) {
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
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          decoration: BoxDecoration(
            color: ThemeColors.bgColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(MySize.size30),
              topRight: Radius.circular(MySize.size30),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: Spacing.fromLTRB(0, MySize.size20, 0, MySize.size20),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      type == "add"
                          ? AppLocalizations.of(context)!.addAccount.toString()
                          : AppLocalizations.of(context)!
                              .editAccount
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
                    controller: TextEditingController(),
                    hintText:
                        AppLocalizations.of(context)!.enterBankName.toString(),
                    title: AppLocalizations.of(context)!.bankName.toString(),
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    fillColor: ThemeColors.fillColor,
                    validator: (value) {
                      return CommonFunctions.validateTextField(value);
                    },
                  ),
                ),
                SizedBox(height: MySize.size8),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: CustomTextField13(
                    controller: TextEditingController(),
                    hintText:
                        AppLocalizations.of(context)!.accountTitle.toString(),
                    title: AppLocalizations.of(context)!.title.toString(),
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    fillColor: ThemeColors.fillColor,
                    validator: (value) {
                      return CommonFunctions.validateTextField(value);
                    },
                  ),
                ),
                SizedBox(height: MySize.size8),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: CustomTextField13(
                    controller: TextEditingController(),
                    hintText:
                        AppLocalizations.of(context)!.accountNumber.toString(),
                    title:
                        AppLocalizations.of(context)!.accountNumber.toString(),
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    fillColor: ThemeColors.fillColor,
                    validator: (value) {
                      return CommonFunctions.validateTextField(value);
                    },
                  ),
                ),
                SizedBox(height: MySize.size8),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: CustomTextField13(
                    controller: TextEditingController(),
                    hintText: AppLocalizations.of(context)!.iBAN.toString(),
                    title: AppLocalizations.of(context)!.iBAN.toString(),
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    fillColor: ThemeColors.fillColor,
                    validator: (value) {
                      return CommonFunctions.validateTextField(value);
                    },
                  ),
                ),
                SizedBox(height: MySize.size30),
                Padding(
                  padding: Spacing.fromLTRB(
                      MySize.size32, 0, MySize.size32, MySize.size20),
                  child: CustomButton8(
                    text: type == "add"
                        ? AppLocalizations.of(context)!.add.toString()
                        : AppLocalizations.of(context)!.save.toString(),
                    onPressed: () {},
                    backgroundColor: ThemeColors.mainColor,
                    textColor: ThemeColors.bgColor,
                    radius: MySize.size30,
                  ),
                ),
                SizedBox(height: MySize.size30),
              ],
            ),
          ),
        ),
      );
    },
  );
}

deleteBankCardDialog(BuildContext context) {
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

withdrawAmmountBottomSheet(BuildContext context) {
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
      return Container(
        decoration: BoxDecoration(
          color: ThemeColors.bgColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(MySize.size30),
            topRight: Radius.circular(MySize.size30),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: Spacing.fromLTRB(0, MySize.size30, 0, MySize.size20),
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(imgWithdrawMoney),
                ),
              ),
              Text(
                'Mr. Wick',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeColors.black1,
                  fontSize: MySize.size16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '432*********4534',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF9F9F9F),
                  fontSize: MySize.size10,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: MySize.size30),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: CustomTextField13(
                  controller: TextEditingController(),
                  hintText:
                      AppLocalizations.of(context)!.enterAmount.toString(),
                  title: AppLocalizations.of(context)!.amount.toString(),
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  fillColor: ThemeColors.fillColor,
                  prefixIcon: Icon(Icons.attach_money_sharp,
                      color: ThemeColors.black1, size: MySize.size26),
                  validator: (value) {
                    return CommonFunctions.validateTextField(value);
                  },
                ),
              ),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  children: [
                    Text(
                      '\$32, 823.12 Available',
                      style: TextStyle(
                        color: const Color(0xFF9F9F9F),
                        fontSize: MySize.size14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MySize.size30),
              Padding(
                padding: Spacing.fromLTRB(
                    MySize.size32, 0, MySize.size32, MySize.size20),
                child: CustomButton8(
                  text: AppLocalizations.of(context)!.withdraw.toString(),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WithdrawSuccessView(),
                      ),
                    );
                  },
                  backgroundColor: ThemeColors.mainColor,
                  textColor: ThemeColors.bgColor,
                  radius: MySize.size30,
                ),
              ),
              SizedBox(height: MySize.size30),
            ],
          ),
        ),
      );
    },
  );
}

class BankCard extends StatelessWidget {
  const BankCard({
    super.key,
    required this.backgroundColor,
    required this.titleColor,
    required this.valueColor,
    required this.bankName,
    required this.bankAccountHolder,
    required this.bankAccountNumber,
    required this.bankIBANNumber,
    required this.activeCard,
    required this.onPressed,
    required this.editOnPressed,
    required this.deleteOnPressed,
  });
  final Color backgroundColor;
  final Color titleColor;
  final Color valueColor;
  final String bankName;
  final String bankAccountHolder;
  final String bankAccountNumber;
  final String bankIBANNumber;
  final bool activeCard;
  final VoidCallback onPressed;
  final VoidCallback editOnPressed;
  final VoidCallback deleteOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Spacing.horizontal(MySize.size32),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          height: MySize.size180,
          decoration: ShapeDecoration(
            color: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MySize.size10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: Spacing.horizontal(MySize.size15),
                    child: Icon(
                      Icons.check_circle_sharp,
                      color:
                          activeCard ? ThemeColors.bgColor : Colors.transparent,
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: editOnPressed,
                        style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.zero),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.edit.toString(),
                          style: TextStyle(
                            color: valueColor,
                            fontSize: MySize.size10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: deleteOnPressed,
                        style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.zero),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.delete.toString(),
                          style: TextStyle(
                            color: valueColor,
                            fontSize: MySize.size10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(width: MySize.size10),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: Spacing.horizontal(MySize.size20),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.bankName.toString(),
                        style: TextStyle(
                          color: titleColor,
                          fontSize: MySize.size10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: '\n$bankName',
                        style: TextStyle(
                          color: valueColor,
                          fontSize: MySize.size10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MySize.size5),
              Padding(
                padding: Spacing.horizontal(MySize.size20),
                child: Row(
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                AppLocalizations.of(context)!.title.toString(),
                            style: TextStyle(
                              color: titleColor,
                              fontSize: MySize.size10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '\n$bankAccountHolder',
                            style: TextStyle(
                              color: valueColor,
                              fontSize: MySize.size10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: MySize.size40),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!
                                .accountNumber
                                .toString(),
                            style: TextStyle(
                              color: titleColor,
                              fontSize: MySize.size10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '\n$bankAccountNumber',
                            style: TextStyle(
                              color: valueColor,
                              fontSize: MySize.size10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: MySize.size15),
              Padding(
                padding: Spacing.horizontal(MySize.size20),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.iBAN.toString(),
                        style: TextStyle(
                          color: titleColor,
                          fontSize: MySize.size10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: '\n$bankIBANNumber',
                        style: TextStyle(
                          color: valueColor,
                          fontSize: MySize.size10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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

class WithdrawAmountTile extends StatelessWidget {
  const WithdrawAmountTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Spacing.horizontal(MySize.size32),
      child: Container(
        width: double.infinity,
        height: MySize.size60,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MySize.size10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0C191B32),
              blurRadius: 10,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          children: [
            SizedBox(width: MySize.size20),
            Icon(
              Icons.arrow_outward_outlined,
              color: ThemeColors.red,
              size: MySize.size30,
            ),
            SizedBox(width: MySize.size8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'September',
                    style: TextStyle(
                      color: const Color(0xFF0D1632),
                      fontSize: MySize.size14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Processing',
                    style: TextStyle(
                      color: ThemeColors.mainColor,
                      fontSize: MySize.size10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '43*************213',
                    style: TextStyle(
                      color: const Color(0xFF9F9F9F),
                      fontSize: MySize.size10,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
            Text(
              '\$100.00',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: ThemeColors.mainColor,
                fontSize: MySize.size14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: MySize.size20),
          ],
        ),
      ),
    );
  }
}

class ReceivedAmountTile extends StatelessWidget {
  const ReceivedAmountTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Spacing.horizontal(MySize.size32),
      child: Container(
        width: MySize.safeWidth,
        height: MySize.size80,
        decoration: ShapeDecoration(
          color: ThemeColors.bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MySize.size10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 4,
              offset: Offset(4, 4),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 20,
              offset: Offset(-4, -4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: MySize.size150,
                  height: MySize.size22,
                  decoration: ShapeDecoration(
                    color: ThemeColors.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(MySize.size5),
                    ),
                  ),
                  child: Padding(
                    padding: Spacing.horizontal(MySize.size6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.orderID.toString(),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: ThemeColors.bgColor,
                            fontSize: MySize.size10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '#3816399163',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: ThemeColors.bgColor,
                            fontSize: MySize.size10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: Spacing.horizontal(MySize.size12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MySize.size45,
                    height: MySize.size45,
                    decoration: const ShapeDecoration(
                      image: DecorationImage(
                        image: AssetImage(imgProfile),
                        fit: BoxFit.fill,
                      ),
                      shape: CircleBorder(),
                    ),
                  ),
                  SizedBox(width: MySize.size8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mr. Wick",
                        style: TextStyle(
                          color: ThemeColors.black1,
                          fontSize: MySize.size14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Today wed 19, 2023",
                        style: TextStyle(
                          color: ThemeColors.black1,
                          fontSize: MySize.size10,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  SvgPicture.asset(
                    icArrowInward,
                    color: ThemeColors.green,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Received: ',
                          style: TextStyle(
                            color: ThemeColors.grey1,
                            fontSize: MySize.size10,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        TextSpan(
                          text: "\n1500.00 SAR",
                          style: TextStyle(
                            color: ThemeColors.mainColor,
                            fontSize: MySize.size10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.right,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
