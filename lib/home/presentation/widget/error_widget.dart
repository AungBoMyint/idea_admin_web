import 'package:flutter/material.dart';
import 'package:mmlearning_admin/extension_widget.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorText;
  const CustomErrorWidget({super.key, required this.errorText});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: SizedBox(
        height: 270,
        child: Text(
          errorText, //errorText,
          style: textTheme.displayMedium?.copyWith(color: Colors.red),
        ).withPadding(h: 20),
      ),
    );
  }
}
