import 'package:flutter/material.dart';
import 'package:mmlearning_admin/constant.dart';
import 'package:mmlearning_admin/main.dart';
import 'package:mmlearning_admin/model/admin_enrolled_student.dart';
import 'package:mmlearning_admin/model/category.dart';
import 'package:mmlearning_admin/model/course.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class EnrollmentDataSource extends DataGridSource {
  EnrollmentDataSource({required List<AdminEnrolledStudent> courses}) {
    _courses = courses
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'actions', value: ""),
              DataGridCell<String>(
                  columnName: 'student',
                  value:
                      "${e.student.user.firstName} ${e.student.user.lastName}"),
              DataGridCell<String>(columnName: 'course', value: e.course.title),
              DataGridCell<int>(
                  columnName: 'subscribed_count', value: e.subscribedCount),
              DataGridCell<bool>(columnName: 'subscribed', value: e.subscribed),
              DataGridCell<String>(
                  columnName: 'expiration_date', value: e.expirationDate),
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
                onPressed: () {},
                icon: Icon(
                  Icons.edit_document,
                  color: Colors.orange,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
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
}
