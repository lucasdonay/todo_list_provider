import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensios.dart';

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
          Text(
            'Task\'s de hoje',
            style: context.titleStyle,
          ),
          Column(
            children: [
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
            ],
          )
        ],
      ),
    );
  }
}
