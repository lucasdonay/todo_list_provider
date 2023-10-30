import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensios.dart';
import 'package:todo_list_provider/app/modules/tasks/task_create_controller.dart';

class CalendarButton extends StatelessWidget {
  CalendarButton({super.key});

  final dateFormat = DateFormat('dd/MM/y');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var lastDate = DateTime.now();
        lastDate = lastDate.add(Duration(days: 5 * 365));

        final DateTime? selectedDate = await showDatePicker(
          locale: Locale('pt', 'BR'),
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2023),
          lastDate: lastDate,
        );

        context.read<TaskCreateController>().selectedDate = selectedDate;
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Selector<TaskCreateController, DateTime?>(
              selector: (context, controller) => controller.selectedDate,
              builder: (context, selectedDate, child) {
                if (selectedDate != null) {
                  return Icon(
                    Icons.today,
                    color: context.primaryColor,
                    size: 17,
                  );
                } else {
                  return Icon(
                    Icons.today,
                    color: Colors.grey,
                    size: 17,
                  );
                }
              },
            ),
            const SizedBox(
              width: 5,
            ),
            Selector<TaskCreateController, DateTime?>(
              selector: (context, controller) => controller.selectedDate,
              builder: (context, selectedDate, child) {
                if (selectedDate != null) {
                  return Text(
                    dateFormat.format(selectedDate),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: context.primaryColor,
                    ),
                  );
                } else {
                  return Text(
                    'SELECIONA UMA DATA',
                    style: context.titleStyle,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
