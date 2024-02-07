import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/rating_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/review_bloc.dart';
import 'package:mmlearning_admin/bloc/core_bloc.dart';
import 'package:mmlearning_admin/constant.dart';
import 'package:mmlearning_admin/extension_widget.dart';
import 'package:mmlearning_admin/home/data/review_data_source.dart';
import 'package:mmlearning_admin/home/presentation/home_page.dart';
import 'package:mmlearning_admin/mock.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../app_icon.dart';
import '../../../core/presentation/responsive_builder.dart';
import '../../../enum_class.dart';
import '../../../function.dart';
import '../widget/drawer_mobile.dart';
import '../widget/error_widget.dart';
import '../widget/loading_widget.dart';

class ReviewListPage extends StatelessWidget {
  const ReviewListPage({
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
                                child: TextFormField(
                                  onFieldSubmitted: (v) => context
                                      .read<ReviewBloc>()
                                      .add(SearchReview(value: v)),
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
                                child: TextFormField(
                                  onFieldSubmitted: (v) => context
                                      .read<ReviewBloc>()
                                      .add(SearchReview(value: v)),
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
                            ? const Expanded(child: const SizedBox())
                            : 20.h(),
                        ElevatedButton(
                          onPressed: () {
                            context.read<CoreBloc>().add(ChangeDetailPageEvent(
                                detailPage: DetailPage.reviewAdd));
                            context
                                .read<ReviewBloc>()
                                .add(ChangeSelectedReview());
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ).withDefault(
                          height: 40,
                          radius: 10,
                        ),
                        10.h(),
                        status == SizeStatus.desktop
                            ? GestureDetector(
                                onTapDown: (details) => showProfilePopupMenu(
                                    context, details.globalPosition),
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
                    final reviews =
                        context.select((ReviewBloc bloc) => bloc.state.reviews);
                    final status =
                        context.select((ReviewBloc bloc) => bloc.state.status);
                    if (status == RequestStatus.fetching) {
                      return const LoadingWidget();
                    }
                    if (status == RequestStatus.error) {
                      return const CustomErrorWidget(
                          errorText: "an error occur");
                    }
                    return reviews?.isEmpty == true
                        ? const SizedBox()
                        : Card(
                            child: SfDataGrid(
                              source: ReviewDataSource(courses: reviews ?? []),
                              loadMoreViewBuilder: (BuildContext context,
                                  LoadMoreRows loadMoreRows) {
                                Future<String> loadRows() async {
                                  // Call the loadMoreRows function to call the
                                  // DataGridSource.handleLoadMoreRows method. So, additional
                                  // rows can be added from handleLoadMoreRows method.
                                  await loadMoreRows();
                                  return Future<String>.value('Completed');
                                }

                                return FutureBuilder<String>(
                                    initialData: 'loading',
                                    future: loadRows(),
                                    builder: (context, snapShot) {
                                      if (snapShot.data == 'loading') {
                                        return Container(
                                            height: 60.0,
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                border: BorderDirectional(
                                                    top: BorderSide(
                                                        width: 1.0,
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 0.26)))),
                                            alignment: Alignment.center,
                                            child: CircularProgressIndicator(
                                              color: primaryColor,
                                            ));
                                      } else {
                                        return SizedBox.fromSize(
                                            size: Size.zero);
                                      }
                                    });
                              },
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
                                    columnName: 'review',
                                    width: (width / 4),
                                    label: Container(
                                        padding: EdgeInsets.all(16.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                          'REVIEW',
                                        ))),
                                GridColumn(
                                  columnName: 'course',
                                  width: (width / 4),
                                  label: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      'COURSE',
                                    ),
                                  ),
                                ),
                                GridColumn(
                                  columnName: 'student',
                                  width: (width / 4),
                                  label: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      'STUDENT',
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
