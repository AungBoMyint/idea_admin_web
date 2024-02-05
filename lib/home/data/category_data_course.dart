import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/category_bloc.dart';
import 'package:mmlearning_admin/bloc/core_bloc.dart';
import 'package:mmlearning_admin/constant.dart';
import 'package:mmlearning_admin/main.dart';
import 'package:mmlearning_admin/model/category.dart';
import 'package:mmlearning_admin/model/course.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CategoryDataSource extends DataGridSource {
  CategoryDataSource({required List<Category> courses}) {
    _courses = courses
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<Category>(columnName: 'actions', value: e),
              DataGridCell<String>(columnName: 'title', value: e.title),
              DataGridCell<String>(columnName: 'image', value: e.image),
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
          key: UniqueKey(),
          children: [
            IconButton(
                onPressed: () {
                  materialKey.currentContext!
                      .read<CategoryBloc>()
                      .add(SetSelectedCategory(
                        category: dataGridCell.value,
                      ));
                  materialKey.currentContext!.read<CoreBloc>().add(
                      ChangeDetailPageEvent(
                          detailPage: DetailPage.categoryAdd));
                },
                icon: const Icon(
                  Icons.edit_document,
                  color: Colors.orange,
                )),
            IconButton(
                onPressed: () => materialKey.currentContext!
                    .read<CategoryBloc>()
                    .add(DeleteCategory(
                        categoryID: (dataGridCell.value as Category).id)),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
          ],
        );
      }
      if (dataGridCell.columnName == 'image') {
        return Image.network(
          dataGridCell.value,
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
