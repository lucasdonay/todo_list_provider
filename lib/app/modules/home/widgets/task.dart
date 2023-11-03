import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensios.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';

class Task extends StatelessWidget {
  final TaskModel model;
  final dateFormat = DateFormat('dd/MM/y');
  Task({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 0.4, color: context.primaryColor),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
          )
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: IntrinsicHeight(
          child: ListTile(
        contentPadding: EdgeInsets.all(8),
        leading: Checkbox(
          activeColor: context.primaryColor,
          value: model.finished,
          onChanged: (value) =>
              context.read<HomeController>().checkOrUncheckTask(model),
        ),
        title: Text(
          model.description,
          style: model.finished
              ? TextStyle(decoration: TextDecoration.lineThrough)
              : null,
        ),
        subtitle: Text(
          dateFormat.format(model.dateTime),
          style: model.finished
              ? TextStyle(decoration: TextDecoration.lineThrough)
              : null,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(width: 1),
        ),
      )),
    );
  }
}
