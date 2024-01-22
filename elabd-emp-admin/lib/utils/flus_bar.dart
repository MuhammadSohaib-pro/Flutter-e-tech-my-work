import '../../helper/import_helper.dart';

getFlushBar(
  BuildContext context, {
  required String title,
  Color? color = redColor,
  bool isSuccess = false,
}) {
  return Flushbar(
    message: title,
    icon: Icon(
      isSuccess ? Icons.check : Icons.info_outline,
      size: 28.0,
      color: isSuccess ? Colors.white : Colors.black,
    ),
    margin: const EdgeInsets.all(8),
    backgroundColor: color!,
    borderRadius: BorderRadius.circular(8),
    duration: const Duration(seconds: 3),
  )..show(context);
}
