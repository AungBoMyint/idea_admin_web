import 'package:flutter/material.dart';

import '../../../constant.dart';

class LoadingWidget extends StatelessWidget {
  final Color? color;
  const LoadingWidget({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: Center(
            child: CircularProgressIndicator(
          color: color ?? warmGreen,
        )),
      ),
    );
  }
}
