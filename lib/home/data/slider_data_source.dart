import 'package:flutter/material.dart' hide Slider;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/slider_bloc.dart';
import 'package:mmlearning_admin/constant.dart';
import 'package:mmlearning_admin/main.dart';
import 'package:mmlearning_admin/model/category.dart';
import 'package:mmlearning_admin/model/course.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../bloc/bloc/category_bloc.dart';
import '../../bloc/core_bloc.dart';
import '../../slider/model/slider.dart';

class SliderDataSource extends DataGridSource {
  SliderDataSource({required List<Slider> courses}) {
    _courses = courses
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<Slider>(columnName: 'actions', value: e),
              DataGridCell<String>(columnName: 'title', value: e.title),
              DataGridCell<String>(columnName: 'image', value: e.image),
              DataGridCell<String>(
                  columnName: 'messenger', value: e.messengerlink?.link ?? ""),
              DataGridCell<String>(
                  columnName: 'facebook', value: e.facebooklink?.link ?? ""),
              DataGridCell<String>(
                  columnName: 'youtube', value: e.youtube?.link ?? ""),
              DataGridCell<String>(
                  columnName: 'courses',
                  value: "${e.courselink?.course?.length}"),
              DataGridCell<String>(
                  columnName: 'blogs', value: "${e.blogs?.length}"),
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
                      .read<SliderBloc>()
                      .add(SetSelectedSlider(
                        slider: dataGridCell.value,
                      ));
                  materialKey.currentContext!.read<CoreBloc>().add(
                      ChangeDetailPageEvent(detailPage: DetailPage.sliderAdd));
                },
                icon: Icon(
                  Icons.edit_document,
                  color: Colors.orange,
                )),
            IconButton(
                onPressed: () => materialKey.currentContext!
                    .read<SliderBloc>()
                    .add(DeleteSlider(
                        sliderID: (dataGridCell.value as Slider).id)),
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
}
