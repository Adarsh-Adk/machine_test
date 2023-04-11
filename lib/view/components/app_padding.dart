import 'package:flutter/material.dart';
import 'package:machine_test/model/constants/app_constants.dart';

class AppPadding extends StatelessWidget {
  final double dividedBy;
  final double multipliedBy;
  const AppPadding({Key? key, this.dividedBy = 1, this.multipliedBy = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: AppConstants.defaultPadding * multipliedBy / dividedBy,
    );
  }
}
