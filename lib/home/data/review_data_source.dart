import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/review_bloc.dart';
import 'package:mmlearning_admin/constant.dart';
import 'package:mmlearning_admin/main.dart';
import 'package:mmlearning_admin/model/category.dart';
import 'package:mmlearning_admin/model/course.dart';
import 'package:mmlearning_admin/model/rating.dart';
import 'package:mmlearning_admin/model/review.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../bloc/core_bloc.dart';

class ReviewDataSource extends DataGridSource {
  ReviewDataSource({required List<Review> courses}) {
    _courses = courses
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<Review>(columnName: 'actions', value: e),
              DataGridCell<String>(columnName: 'review', value: e.review),
              DataGridCell<String>(columnName: 'course', value: e.course),
              DataGridCell<String>(columnName: 'student', value: e.student),
            ]))
        .toList();
  }

  List<DataGridRow> _courses = [];

  @override
  List<DataGridRow> get rows => _courses;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    final theme = Theme.of(scaffoldKey.currentContext!);
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      if (dataGridCell.columnName == 'actions') {
        return Row(
          children: [
            IconButton(
                onPressed: () {
                  materialKey.currentContext!
                      .read<CoreBloc>()
                      .add(ChangeDetailPageEvent(
                        detailPage: DetailPage.reviewAdd,
                      ));
                  materialKey.currentContext!
                      .read<ReviewBloc>()
                      .add(ChangeSelectedReview(review: dataGridCell.value));
                },
                icon: const Icon(
                  Icons.edit_document,
                  color: Colors.orange,
                )),
            IconButton(
                onPressed: () {
                  materialKey.currentContext!
                      .read<ReviewBloc>()
                      .add(DeleteReview(id: dataGridCell.value.id));
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
          ],
        );
      }

      return Container(
        height: 100,
        alignment: Alignment.center,
        /* padding: const EdgeInsets., */
        child: Text(
          dataGridCell.value.toString(),
          textAlign: TextAlign.center,
          style: theme.textTheme.displaySmall?.copyWith(
            color: Colors.black,
          ),
        ),
      );
    }).toList());
  }

  @override
  Future<void> handleLoadMoreRows() async {
    final ratingBloc = materialKey.currentContext!.read<ReviewBloc>();
    if (ratingBloc.state.hasMore) {
      await Future.delayed(const Duration(seconds: 5));
      // ignore: use_build_context_synchronously
      ratingBloc.add(GetMoreReview());
      notifyListeners();
    }
  }
}
