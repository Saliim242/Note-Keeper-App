import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:page_transition/page_transition.dart';

import 'exports.dart';

final box = GetStorage();

const String kEndpoint = "https://notes-backend-bootcamp.vercel.app/api/v1/";

const String kUserInfo = 'userInfo';
const String kUserToken = 'userToken';
const String kOnboarding = 'onBoarding';

const double kPadding = 16;

// Text Style
TextStyle style({
  required double fontSize,
  String? fontFamily,
  required Color color,
  FontWeight? fontWeight,
  TextDecoration? decoration,
  double? height,
  TextOverflow? overflow,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
    decoration: decoration,
    height: height,
    overflow: overflow,
  );
}

Future<void> showToast({
  required String message,
  Toast? toastLength,
  ToastGravity? gravity,
  Color? backgroundColor,
  Color? textColor,
}) {
  return Fluttertoast.showToast(
    msg: message,

    toastLength: toastLength ?? Toast.LENGTH_LONG,
    gravity: gravity ?? ToastGravity.SNACKBAR,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor ?? NAppColor.kCheckOutInActiveBgColor,
    textColor: textColor ?? NAppColor.kCheckOutActiveTextColor,
    fontSize: 16.0,
  );
}

String formatDate(DateTime? date) {
  if (date == null) return 'No date';

  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  return '${months[date.month - 1]} ${date.day}, ${date.year}';
}

const List<Color> noteColors = [
  Color(0xffff7d27),
  Color(0xff16a085),
  Color(0xff6c5ce7),
  Color(0xff0984e3),
  Color(0xffd63031),
];

void goScreen({
  required BuildContext context,
  required Widget screen,
  PageTransitionType? type,
}) {
  Navigator.push(
    context,
    PageTransition(child: screen, type: type ?? PageTransitionType.fade),
  );
}
