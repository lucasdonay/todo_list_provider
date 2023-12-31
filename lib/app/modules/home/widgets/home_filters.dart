import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensios.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/total_tasks_model.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';

import 'todo_card_filter.dart';

class HomeFilters extends StatelessWidget {
  const HomeFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filtros',
          style: context.titleStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TodoCardFilter(
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.filterSelected) ==
                    TaskFilterEnum.today,
                label: 'HOJE',
                taskFilter: TaskFilterEnum.today,
                totalTasksModel:
                    context.select<HomeController, TotalTasksModel?>(
                  (controller) => controller.todayTotalTask,
                ),
              ),
              TodoCardFilter(
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.filterSelected) ==
                    TaskFilterEnum.tomorrow,
                label: 'AMANHÃ',
                taskFilter: TaskFilterEnum.tomorrow,
                totalTasksModel:
                    context.select<HomeController, TotalTasksModel?>(
                  (controller) => controller.tomorrowTotalTask,
                ),
              ),
              TodoCardFilter(
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.filterSelected) ==
                    TaskFilterEnum.week,
                label: 'SEMANA',
                taskFilter: TaskFilterEnum.week,
                totalTasksModel:
                    context.select<HomeController, TotalTasksModel?>(
                  (controller) => controller.weekTotalTask,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
