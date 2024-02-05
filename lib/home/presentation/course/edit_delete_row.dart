import 'package:flutter/material.dart';
import 'package:mmlearning_admin/extension_widget.dart';

import '../../../constant.dart';

class EditDeleteTextRow extends StatelessWidget {
  const EditDeleteTextRow({
    super.key,
    required this.data,
    this.hasArrow = true,
    this.isSelected = false,
    this.onDelete,
    this.onEdit,
  });
  final String data;
  final bool hasArrow;
  final bool isSelected;
  final void Function()? onEdit;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Row(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: onEdit,
                icon: Icon(
                  Icons.edit_document,
                  color: Colors.orange,
                )),
            IconButton(
                onPressed: onDelete,
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
          ],
        ),
        10.h(),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          padding: EdgeInsets.all(5),
          child: Text(
            "01",
            style: textTheme.bodySmall?.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        10.h(),
        Text(data),
        10.h(),
        hasArrow
            ? Icon(
                isSelected ? Icons.arrow_drop_down : Icons.arrow_right,
              )
            : 0.h(),
      ],
    );
  }
}
