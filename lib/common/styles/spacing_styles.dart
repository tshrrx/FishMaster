import 'package:flutter/widgets.dart';
import 'package:fishmaster/utils/constants/sizes.dart';

class FSpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: FSizes.appBarHeight,
    left: FSizes.defaultSpace,
    bottom: FSizes.defaultSpace,
    right: FSizes.defaultSpace,
  );
}
