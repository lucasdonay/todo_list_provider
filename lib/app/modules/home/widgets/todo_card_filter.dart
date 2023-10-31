// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:todo_list_provider/app/core/ui/theme_extensios.dart';
import 'package:todo_list_provider/app/models/total_tasks_model.dart';

import '../../../models/task_filter_enum.dart';

class TodoCardFilter extends StatelessWidget {
  final String label;
  final TaskFilterEnum taskFilter;
  final TotalTasksModel? totalTasksModel;

  bool selected;

  TodoCardFilter({
    Key? key,
    required this.label,
    required this.taskFilter,
    this.totalTasksModel,
    required this.selected,
  }) : super(key: key);

  double _getPercentFinish() {
    final total = totalTasksModel?.totalTasks ?? 0.0;
    final totalFinish = totalTasksModel?.totalTaskFinish ?? 0.1;

    if (total == 0) {
      return 0.0;
    } else {
      final percent = (totalFinish * 100) / total;
      return percent / 100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 120, maxWidth: 150),
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: selected ? context.primaryColor : Colors.white,
        border: Border.all(
          width: 1,
          color: Colors.grey.withOpacity(.8),
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${totalTasksModel?.totalTasks} TASKS',
            style: context.titleStyle.copyWith(
              fontSize: 12,
              color: selected ? Colors.white : Colors.grey,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TweenAnimationBuilder(
            duration: const Duration(seconds: 1),
            tween: Tween(begin: 0.0, end: _getPercentFinish()),
            builder: (context, value, child) {
              return LinearProgressIndicator(
                backgroundColor:
                    selected ? context.primaryColorLight : Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(
                    selected ? Colors.white : context.primaryColor),
                value: value,
              );
            },
          )
        ],
      ),
    );
  }
}
