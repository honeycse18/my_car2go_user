import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/*<--------This file contains various components for the app------->*/
class AppComponents {
  static const defaultBorderRadius = Radius.circular(8);
  static const defaultBorder =
      BorderRadius.all(Radius.circular(AppConstants.defaultBorderRadiusValue));
  static String currencySymbol = AppConstants.defaultCurrencySymbol;
  static NumberFormat defaultDecimalNumberFormat =
      NumberFormat.currency(symbol: currencySymbol, decimalDigits: 2);
  static NumberFormat defaultNumberFormat =
      // NumberFormat.currency(locale: 'fn_FN');
      NumberFormat.currency(locale: 'en_US');

  static const BorderRadius dialogBorderRadius =
      BorderRadius.all(Radius.circular(AppConstants.dialogBorderRadiusValue));
  static final DateTime defaultUnsetDateTime =
      DateTime(AppConstants.defaultUnsetDateTimeYear);
  static final apiDateTimeFormat =
      DateFormat(AppConstants.apiDateTimeFormatValue);
  static final apiOnlyDateFormat =
      DateFormat(AppConstants.apiOnlyDateFormatValue);

  static const BorderRadius imageBorderRadius =
      BorderRadius.all(Radius.circular(AppConstants.imageBorderRadiusValue));

  static const BorderRadius smallBorderRadius =
      BorderRadius.all(Radius.circular(AppConstants.smallBorderRadiusValue));
  static final apiOnlyTimeFormat =
      DateFormat(AppConstants.apiOnlyTimeFormatValue);
  static const EdgeInsets dialogTitlePadding = EdgeInsets.fromLTRB(
      AppConstants.dialogHorizontalSpaceValue,
      AppConstants.dialogVerticalSpaceValue,
      AppConstants.dialogHorizontalSpaceValue,
      AppConstants.dialogVerticalSpaceValue);
  static const EdgeInsets dialogContentPadding = EdgeInsets.fromLTRB(
      AppConstants.dialogHorizontalSpaceValue,
      AppConstants.dialogHalfVerticalSpaceValue,
      AppConstants.dialogHorizontalSpaceValue,
      AppConstants.dialogVerticalSpaceValue);
  static const EdgeInsets dialogActionPadding = EdgeInsets.fromLTRB(
      AppConstants.dialogHorizontalSpaceValue,
      AppConstants.dialogVerticalSpaceValue,
      AppConstants.dialogHorizontalSpaceValue,
      AppConstants.dialogVerticalSpaceValue);
  static const EdgeInsets screenHorizontalPadding =
      EdgeInsets.symmetric(horizontal: AppConstants.screenPaddingValue);
  static const OutlineInputBorder textFormFieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: AppColors.fromBorderColor));
}
