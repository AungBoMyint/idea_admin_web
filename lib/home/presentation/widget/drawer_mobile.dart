import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmlearning_admin/extension_widget.dart';

import '../../../app_image.dart';
import '../../../bloc/core_bloc.dart';
import '../../../constant.dart';

class Drawermobile extends StatelessWidget {
  const Drawermobile({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          20.v(),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              AppImage.logo,
              width: 100,
              height: 100,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "IDEA",
              style: textTheme.displayLarge?.copyWith(
                color: primaryColor,
              ),
            ),
          ),
          20.v(),
          Expanded(
            child: BlocBuilder<CoreBloc, CoreState>(
              builder: (context, state) {
                return ListView.separated(
                  itemCount: drawerItems.length,
                  separatorBuilder: (context, index) {
                    return 20.v();
                  },
                  itemBuilder: (context, index) {
                    final item = drawerItems[index];
                    return InkWell(
                      onTap: () => context
                          .read<CoreBloc>()
                          .add(ChangePageEvent(page: index)),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: state.page == index
                            ? primaryColor.withOpacity(0.8)
                            : null,
                        child: Row(
                          children: [
                            Image.asset(
                              item["icon"],
                              height: 18,
                              width: 18,
                            ),
                            10.h(),
                            Text(
                              item["name"],
                              style: textTheme.bodyMedium?.copyWith(
                                color:
                                    state.page == index ? Colors.white : null,
                              ),
                            )
                          ],
                        ),
                      ),
                    ).withPadding(h: 20, v: 0);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
