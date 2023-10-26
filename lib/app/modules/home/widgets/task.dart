import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensios.dart';

class Task extends StatelessWidget {
  const Task({super.key});

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
          onChanged: (bool? value) {},
          value: true,
        ),
        title: Text(
          'DESCRICAO DA TASK',
          style: TextStyle(decoration: TextDecoration.lineThrough),
        ),
        subtitle: Text(
          '26/10/2023',
          style: TextStyle(decoration: TextDecoration.lineThrough),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(width: 1)),
      )),
    );
  }
}
