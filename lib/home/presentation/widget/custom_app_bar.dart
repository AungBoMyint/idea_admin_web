import 'package:flutter/material.dart';
import 'package:mmlearning_admin/extension_widget.dart';
import 'package:mmlearning_admin/main.dart';

import '../../../app_icon.dart';
import '../../../constant.dart';
import '../../../core/presentation/responsive_widget.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return ResponsiveWidget(
      mobile: AppBarMobile(textTheme: textTheme),
      tablet: AppBarMobile(textTheme: textTheme),
      desktop: Container(
        color: Colors.blue,
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56);
}

class AppBarMobile extends StatelessWidget {
  const AppBarMobile({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Drawer
        InkWell(
          onTap: () => scaffoldKey.currentState?.openDrawer(),
          child: Image.asset(
            AppIcon.drawer,
            height: 30,
            width: 30,
          ),
        ).withPadding(h: 20, v: 10),
        //Title

        Text(
          "IDEA",
          style: textTheme.displayLarge?.copyWith(
            color: primaryColor,
          ),
        ),

        InkWell(
            onTap: () {},
            child: CircleAvatar(
              backgroundColor: primaryColor,
              radius: 18,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                child: Image.asset(
                  AppIcon.profile,
                  height: 30,
                  width: 30,
                ),
              ),
            )),
        //Profile
      ],
    );
  }
}
