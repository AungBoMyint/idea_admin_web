import 'package:flutter/material.dart';

import 'constant.dart';

extension WidgetExtension on ElevatedButton {
  withDefault({
    double? radius,
    Color? backgroundColor,
    Color? borderColor,
    double? height,
    double? width,
  }) =>
      ElevatedButtonTheme(
          data: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor ?? primaryColor,
                  shape: RoundedRectangleBorder(
                    side: borderColor == null
                        ? BorderSide.none
                        : BorderSide(
                            color: borderColor,
                          ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        radius ?? 20,
                      ),
                    ),
                  ))),
          child: SizedBox(
            height: height,
            width: width,
            child: this,
          ));
}

extension PaddingExtension on Widget {
  withPadding({double h = 20, double v = 20}) => Padding(
        padding: EdgeInsets.symmetric(vertical: v, horizontal: h),
        child: this,
      );
}

extension PaddingExtensionOnly on Widget {
  withPaddingOnly(
          {double left = 0,
          double right = 0,
          double top = 0,
          double bottom = 0}) =>
      Padding(
        padding: EdgeInsets.only(
          left: left,
          right: right,
          top: top,
          bottom: bottom,
        ),
        child: this,
      );
}

extension HorizontalSpace on int {
  h() => SizedBox(
        width: this + 0.0,
      );
}

extension VertocalSpace on int {
  v() => SizedBox(
        height: this + 0.0,
      );
}
