import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensios.dart';

class TodoListLogo extends StatelessWidget {
  const TodoListLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 200,
        ),
        // ignore: deprecated_member_use
        Text(
          'Todo List',
          style: context.textTheme.titleLarge,
        )
      ],
    );
  }
}
