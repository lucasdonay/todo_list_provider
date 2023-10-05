import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/database/sqlite_adm_connection.dart';
import 'package:todo_list_provider/app/core/ui/todo_list_ui_config.dart';
import 'package:todo_list_provider/app/modules/auth/auth_module.dart';
import 'package:todo_list_provider/app/modules/auth/login/login_controller.dart';
import 'package:todo_list_provider/app/modules/auth/login/login_page.dart';

import 'modules/splash/splash_page.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  var sqliteAdm = SqliteAdmConnection();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(sqliteAdm);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(sqliteAdm);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo list Provider',
      theme: TodoListUiConfig.theme,
      home: SplashPage(),
      initialRoute: '/login',
      routes: {...AuthModule().routers},
    );
  }
}
