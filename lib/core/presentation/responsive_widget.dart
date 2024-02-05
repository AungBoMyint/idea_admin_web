import 'package:flutter/material.dart';

import '../../dimension.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  const ResponsiveWidget({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      if (width <= MOBILE) {
        return mobile;
      } else if (width > MOBILE && width < DESKTOP) {
        return tablet;
      } else {
        return desktop;
      }
    });
  }
}
