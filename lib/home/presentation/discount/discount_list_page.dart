import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/course_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/discount_bloc.dart';
import 'package:mmlearning_admin/bloc/core_bloc.dart';
import 'package:mmlearning_admin/constant.dart';
import 'package:mmlearning_admin/enum_class.dart';
import 'package:mmlearning_admin/extension_widget.dart';
import 'package:mmlearning_admin/home/data/discount_data_source.dart';
import 'package:mmlearning_admin/home/presentation/home_page.dart';
import 'package:mmlearning_admin/home/presentation/widget/loading_widget.dart';
import 'package:mmlearning_admin/mock.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../app_icon.dart';
import '../../../core/presentation/responsive_builder.dart';
import '../widget/drawer_mobile.dart';
import '../widget/error_widget.dart';

class DiscountListPage extends StatelessWidget {
  const DiscountListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
      ),
    );
    return ResponsiveBuilder(builder: (status) {
      return Row(
        children: [
          status == SizeStatus.desktop
              ? Expanded(
                  child: Drawermobile(textTheme: textTheme),
                )
              : const SizedBox(),
          status == SizeStatus.desktop ? 20.h() : const SizedBox(),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                //Search & Add
                Card(
                  child: SizedBox(
                    height: 40,
                    width:
                        status == SizeStatus.desktop ? size.width * 0.8 : null,
                    child: Row(
                      children: [
                        status == SizeStatus.desktop
                            ? SizedBox(
                                width: size.width * 0.3,
                                child: const TextField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(right: 20),
                                    prefixIcon: Icon(Icons.search),
                                    hintText: "Search",
                                    border: border,
                                    enabledBorder: border,
                                    focusedBorder: border,
                                    disabledBorder: border,
                                  ),
                                ),
                              )
                            : Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(right: 20),
                                    prefixIcon: Icon(Icons.search),
                                    hintText: "Search",
                                    border: border,
                                    enabledBorder: border,
                                    focusedBorder: border,
                                    disabledBorder: border,
                                  ),
                                ),
                              ),
                        status == SizeStatus.desktop
                            ? Expanded(child: const SizedBox())
                            : 20.h(),
                        ElevatedButton(
                          onPressed: () {
                            context.read<CoreBloc>().add(ChangeDetailPageEvent(
                                detailPage: DetailPage.discountAdd));
                            context
                                .read<DiscountBloc>()
                                .add(ChangeSelectedDiscount(disocunt: null));
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ).withDefault(
                          height: 40,
                          radius: 10,
                        ),
                        10.h(),
                        status == SizeStatus.desktop
                            ? InkWell(
                                onTap: () {},
                                child: CircleAvatar(
                                  backgroundColor: primaryColor,
                                  radius: 20,
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.white,
                                    child: Image.asset(
                                      AppIcon.profile,
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                ))
                            : const SizedBox(),
                      ],
                    ),
                  ).withPadding(h: 10, v: 20),
                ),
                20.v(),
                Expanded(
                  child: LayoutBuilder(builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    final discounts = context
                        .select((DiscountBloc bloc) => bloc.state.discounts);
                    final status = context
                        .select((DiscountBloc bloc) => bloc.state.status);
                    if (status == RequestStatus.fetching) {
                      return const LoadingWidget();
                    }
                    if (status == RequestStatus.error) {
                      return const CustomErrorWidget(
                          errorText: "an error occur");
                    }
                    return discounts?.isEmpty == true
                        ? const SizedBox()
                        : Card(
                            child: SfDataGrid(
                              source:
                                  DiscountDataSource(courses: discounts ?? []),
                              columns: <GridColumn>[
                                GridColumn(
                                    columnName: 'actions',
                                    width: 100,
                                    label: Container(
                                        padding: EdgeInsets.all(16.0),
                                        child: Text(
                                          'ACTIONS',
                                        ))),
                                GridColumn(
                                    columnName: 'title',
                                    width: (width / 3),
                                    label: Container(
                                        padding: EdgeInsets.all(16.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                          'TITLE',
                                        ))),
                                GridColumn(
                                  columnName: 'image',
                                  width: (width / 4),
                                  label: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      'IMAGE',
                                    ),
                                  ),
                                ),
                                GridColumn(
                                  columnName: 'percentage',
                                  width: (width / 3),
                                  label: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      'DISCOUNT',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                  }),
                ),
              ],
            ),
          ),
        ],
      );
    }).withPaddingOnly(right: 20);
  }
}
