import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensios.dart';
import 'package:todo_list_provider/app/core/ui/todolisticons.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_tasks.dart';

import 'widgets/home_drawer.dart';
import 'widgets/home_filters.dart';
import 'widgets/home_header.dart';
import 'widgets/home_week_filter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFAFBFE),
        elevation: 0,
        iconTheme: IconThemeData(color: context.primaryColor),
        actions: [
          PopupMenuButton(
            icon: Icon(
              TodoListIcons.filter,
              size: 17,
              color: context.primaryColor,
            ),
            itemBuilder: (_) => [
              PopupMenuItem<bool>(
                child: Text('Mostrar tarefas concluidas'),
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.primaryColor,
        onPressed: () {},
        child: Icon(
          Icons.add,
        ),
      ),
      backgroundColor: Color(0xFFFAFBFE),
      drawer: HomeDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.minWidth,
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: IntrinsicHeight(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeHeader(),
                    HomeFilters(),
                    HomeWeekFilter(),
                    HomeTasks(),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                )),
              ),
            ),
          );
        },
      ),
    );
  }
}
