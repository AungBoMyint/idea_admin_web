import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/student_bloc.dart';
import 'package:mmlearning_admin/constant.dart';
import 'package:mmlearning_admin/main.dart';
import 'package:mmlearning_admin/model/category.dart';
import 'package:mmlearning_admin/model/course.dart';
import 'package:mmlearning_admin/model/student.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StudentDataSource extends DataGridSource {
  StudentDataSource({required List<Student> courses}) {
    _courses = courses
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<Student>(
                columnName: 'actions',
                value: e,
              ),
              DataGridCell<String>(columnName: 'avatar', value: e.avatar),
              DataGridCell<String>(
                  columnName: 'full_name',
                  value: "${e.user.firstName} ${e.user.lastName}"),
              DataGridCell<String>(columnName: 'email', value: e.user.email),
              DataGridCell<int>(
                  columnName: 'enrolled_courses', value: e.enrolledCourses),
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
        return IconButton(
            onPressed: () {
              materialKey.currentContext!.read<StudentBloc>().add(
                    DeleteStudent(id: dataGridCell.value.id),
                  );
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ));
      }
      if (dataGridCell.columnName == 'avatar') {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 30,
            child: Image.network(dataGridCell.value ?? emptyUser),
          ),
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
