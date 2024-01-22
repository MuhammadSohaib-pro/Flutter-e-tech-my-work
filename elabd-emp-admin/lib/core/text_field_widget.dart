import 'package:elabd_ems_admin/helper/import_helper.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final bool isObsecure;
  final String? Function(String?)? validator;
  final double borderRadius;
  final TextInputType keyBoadType;
  final bool readOnly;
  final bool filled;
  final Color filledColor;
  final bool isShadow;
  final TextStyle hintTextStyle;
  final bool isDense;
  final double verticalPadding;
  final double horizontalPadding;

  const TextFieldWidget({
    Key? key,
    this.validator,
    this.isDense = false,
    required this.controller,
    required this.hintText,
    this.isObsecure = false,
    this.filled = true,
    this.isShadow = true,
    this.filledColor = whiteColor,
    this.borderRadius = 12,
    this.keyBoadType = TextInputType.text,
    this.readOnly = false,
    this.hintTextStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: lightGrey,
      fontFamily: 'Poppins',
    ),
    this.horizontalPadding = 30,
    this.verticalPadding = 15,
    this.sufixIcon,
    this.prefixIcon,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Container(
      decoration: BoxDecoration(boxShadow: [
        !widget.isShadow
            ? const BoxShadow(
                color: Colors.transparent,
                blurRadius: 0,
                spreadRadius: 0,
              )
            : BoxShadow(
                color: blackColor.withOpacity(0.15),
                blurRadius: 10,
                spreadRadius: 0,
                offset: const Offset(-1, -1))
      ]),
      child: TextFormField(
        style:
            poppinMedium.copyWith(fontSize: MySize.size14, color: blackColor),
        controller: widget.controller,
        validator: widget.validator,
        keyboardType: widget.keyBoadType,
        maxLines: 1,
        readOnly: widget.readOnly,
        obscureText: widget.isObsecure,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: widget.verticalPadding, horizontal:widget.horizontalPadding),
            fillColor: widget.filledColor,
            filled: widget.filled,
            hintText: widget.hintText,
            hintStyle: widget.hintTextStyle,
            isDense: widget.isDense,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(widget.borderRadius)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide.none),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.sufixIcon),
      ),
    );
  }
}
