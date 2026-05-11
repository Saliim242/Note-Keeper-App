import 'package:flutter/material.dart';

import '../utils/exports.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Search notes here...',
        hintStyle: style(
          fontSize: NSizes.fontSizeSm,
          color: NAppColor.kTextStyleColorGray,
        ),
        prefixIcon: const Icon(Icons.search_rounded),
        filled: true,
        fillColor: NAppColor.kbgColor2,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: NSizes.md + 4,
          vertical: NSizes.md + 4,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(NSizes.cardRadiusMd),
          borderSide: const BorderSide(color: NAppColor.borderSecondary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(NSizes.cardRadiusMd),
          borderSide: BorderSide(color: NAppColor.kPrimaryColor, width: 1.4),
        ),
      ),
    );
  }
}
