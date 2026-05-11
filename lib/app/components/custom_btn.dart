import 'package:flutter/material.dart';

import '../utils/exports.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.btnText,
    this.onTap,
    this.child,
    this.height,
    this.width,
    this.color,
  });

  final String btnText;
  final Widget? child;
  final double? height;
  final double? width;
  final Color? color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    // bool isDarkMode = BReusableConstants.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? 60,
        decoration: BoxDecoration(
          color: color ?? NAppColor.kPrimaryColor,
          //isDarkMode ? BAppColor.kCardDarkbgColor : BAppColor.kPrimaryColor,
          borderRadius: BorderRadius.circular(NSizes.buttonRadius),
        ),
        child:
            child ??
            Text(
              btnText,
              style: style(color: NAppColor.kbgColor, fontSize: 17),
              textAlign: TextAlign.center,
            ),
      ),
    );
  }
}
