import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensios.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';

class HomeWeekFilter extends StatelessWidget {
  const HomeWeekFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.select<HomeController, bool>(
        (controller) => controller.filterSelected == TaskFilterEnum.week,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'Dia da semana',
            style: context.titleStyle,
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 110,
            child: Selector<HomeController, DateTime>(
                selector: (context, controller) {
              return controller.initialDateWeek ?? DateTime.now();
            }, builder: (context, value, __) {
              return DatePicker(
                value,
                locale: 'pt_BR',
                height: 1,
                onDateChange: (date) => context.read<HomeController>().filterByDay(date),
                initialSelectedDate: value,
                selectionColor: context.primaryColor,
                selectedTextColor: Colors.white,
                daysCount: 7,
                monthTextStyle: TextStyle(fontSize: 10),
                dayTextStyle: TextStyle(fontSize: 15),
                dateTextStyle: TextStyle(fontSize: 15),
              );
            }),
          ),
        ],
      ),
    );
  }
}
