import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensios.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';

import 'task.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Selector<HomeController, String>(builder: ((context, value, child) {
            return Text(
              value,
              style: context.titleStyle,
            );
          }), selector: (context, controller) {
            return controller.filterSelected.description;
          }),
          Column(
            children: context
                .select<HomeController, List<TaskModel>>(
                  (controller) => controller.filteredTasks,
                )
                .map(
                  (t) => Task(
                    model: t,
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
