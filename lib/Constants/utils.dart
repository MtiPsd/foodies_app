import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter/material.dart';

dynamic rValue({
  required BuildContext context,
  required dynamic defaultValue,
  dynamic whenSmaller,
  dynamic onDesktop,
}) {
  return ResponsiveValue(
    context,
    defaultValue: defaultValue,
    valueWhen: <Condition>[
      Condition.smallerThan(name: MOBILE, value: whenSmaller),
      Condition.largerThan(name: DESKTOP, value: onDesktop),
    ],
  ).value;
}
