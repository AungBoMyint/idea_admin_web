import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/course_bloc.dart';
import 'package:mmlearning_admin/bloc/core_bloc.dart';
import 'package:mmlearning_admin/constant.dart';
import 'package:mmlearning_admin/main.dart';
import 'package:mmlearning_admin/model/course.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CourseDataSource extends DataGridSource {
  CourseDataSource({required List<Course> courses}) {
    _courses = courses
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<Course>(columnName: 'actions', value: e),
              DataGridCell<String>(columnName: 'title', value: e.title),
              DataGridCell<int>(columnName: 'price', value: e.price),
              DataGridCell<int>(
                  columnName: 'students', value: e.enrollStudentsCount),
              DataGridCell<double>(
                  columnName: 'ratings', value: e.averageRatings),
              DataGridCell<int>(columnName: 'reviews', value: e.reviewsCount),
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
                      .read<CourseBloc>()
                      .add(ChangeSelectedCourse(course: dataGridCell.value));
                  materialKey.currentContext!.read<CoreBloc>().add(
                      ChangeDetailPageEvent(detailPage: DetailPage.courseAdd));
                },
                icon: const Icon(
                  Icons.edit_document,
                  color: Colors.orange,
                )),
            IconButton(
                onPressed: () => materialKey.currentContext!
                    .read<CourseBloc>()
                    .add(DeleteCourseEvent(
                        id: (dataGridCell.value as Course).id)),
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
          dataGridCell.columnName == "price"
              ? "${dataGridCell.value}MMK"
              : dataGridCell.value.toString(),
          textAlign: TextAlign.center,
          style: theme.textTheme.displaySmall?.copyWith(
            color: Colors.black,
          ),
        ),
      );
    }).toList());
  }
}
