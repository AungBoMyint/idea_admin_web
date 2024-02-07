import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/discount_bloc.dart';
import 'package:mmlearning_admin/bloc/core_bloc.dart';
import 'package:mmlearning_admin/constant.dart';
import 'package:mmlearning_admin/main.dart';
import 'package:mmlearning_admin/model/category.dart';
import 'package:mmlearning_admin/model/course.dart';
import 'package:mmlearning_admin/model/discount.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DiscountDataSource extends DataGridSource {
  DiscountDataSource({required List<Discount> courses}) {
    _courses = courses
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<Discount>(columnName: 'actions', value: e),
              DataGridCell<String>(columnName: 'title', value: e.title),
              DataGridCell<String>(columnName: 'image', value: e.image),
              DataGridCell<int>(
                  columnName: 'percentage', value: e.discountPercentage),
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
                  materialKey.currentContext!.read<CoreBloc>().add(
                      ChangeDetailPageEvent(
                          detailPage: DetailPage.discountAdd));
                  materialKey.currentContext!.read<DiscountBloc>().add(
                      ChangeSelectedDiscount(
                          disocunt: dataGridCell.value as Discount));
                },
                icon: const Icon(
                  Icons.edit_document,
                  color: Colors.orange,
                )),
            IconButton(
                onPressed: () {
                  materialKey.currentContext!
                      .read<DiscountBloc>()
                      .add(DeleteDiscount(id: dataGridCell.value.id));
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
          ],
        );
      }
      if (dataGridCell.columnName == 'image') {
        return Image.network(dataGridCell.value);
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
    final ratingBloc = materialKey.currentContext!.read<DiscountBloc>();
    if (ratingBloc.state.hasMore) {
      await Future.delayed(const Duration(seconds: 5));
      // ignore: use_build_context_synchronously
      ratingBloc.add(GetMoreDiscount());
      notifyListeners();
    }
  }
}
