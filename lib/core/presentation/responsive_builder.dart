import 'package:flutter/material.dart';

import '../../dimension.dart';

enum SizeStatus { mobile, tablet, desktop }

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(SizeStatus status) builder;
  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      if (width <= MOBILE) {
        return builder(SizeStatus.mobile);
      } else if (width > MOBILE && width < DESKTOP) {
        return builder(SizeStatus.tablet);
      } else {
        return builder(SizeStatus.desktop);
      }
    });
  }
}
