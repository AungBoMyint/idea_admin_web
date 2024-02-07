import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/rating_bloc.dart';
import 'package:mmlearning_admin/bloc/core_bloc.dart';
import 'package:mmlearning_admin/constant.dart';
import 'package:mmlearning_admin/main.dart';
import 'package:mmlearning_admin/model/category.dart';
import 'package:mmlearning_admin/model/course.dart';
import 'package:mmlearning_admin/model/rating.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class RatingDataSource extends DataGridSource {
  RatingDataSource({required List<Rating> courses}) {
    _courses = courses
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<Rating>(columnName: 'actions', value: e),
              DataGridCell<double>(columnName: 'rating', value: e.rating),
              DataGridCell<String>(columnName: 'course', value: e.course),
              DataGridCell<String>(
                columnName: 'student',
                value: e.student,
              ),
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
                        detailPage: DetailPage.ratingAdd,
                      ));
                  materialKey.currentContext!
                      .read<RatingBloc>()
                      .add(ChangeSelectedRating(rating: dataGridCell.value));
                },
                icon: const Icon(
                  Icons.edit_document,
                  color: Colors.orange,
                )),
            IconButton(
                onPressed: () {
                  materialKey.currentContext!
                      .read<RatingBloc>()
                      .add(DeleteRating(id: dataGridCell.value.id));
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
          ],
        );
      }

      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
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
    final ratingBloc = materialKey.currentContext!.read<RatingBloc>();
    if (ratingBloc.state.hasMore) {
      await Future.delayed(const Duration(seconds: 5));
      // ignore: use_build_context_synchronously
      ratingBloc.add(GetMoreRating());
      notifyListeners();
    }
  }
}
