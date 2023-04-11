import 'package:flutter/material.dart';

import 'app_color_scheme.dart';
import 'app_constants.dart';

class CustomDecoration {
  static OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderSide:
          const BorderSide(color: AppColorScheme.primaryColor, width: 1.0),
      borderRadius: BorderRadius.circular(AppConstants.cornerRadius));

  static OutlineInputBorder errorBorder = OutlineInputBorder(
      borderSide:
          const BorderSide(color: AppColorScheme.gridErrorColor, width: 1.0),
      borderRadius: BorderRadius.circular(AppConstants.cornerRadius));

  static InputDecoration inputDecoration({required String label}) =>
      InputDecoration(
          counterText: "",
          labelText: label,
          border: outlineInputBorder,
          errorStyle: const TextStyle(color: AppColorScheme.gridErrorColor),
          labelStyle: const TextStyle(color: AppColorScheme.primaryColor),
          errorBorder: errorBorder,
          focusedBorder: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          focusedErrorBorder: outlineInputBorder,
          floatingLabelBehavior: FloatingLabelBehavior.always);
}
