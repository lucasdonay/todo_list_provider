// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:todo_list_provider/app/core/database/sqlite_connection_factory.dart';
import 'package:todo_list_provider/app/models/task_model.dart';

import './tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;
  TasksRepositoryImpl({
    required SqliteConnectionFactory sqliteConnectionFactory,
  }) : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<void> save(DateTime date, String description) async {
    final conn = await _sqliteConnectionFactory.openConnection();

    await conn.insert('todo', {
      'id': null,
      'descricao': description,
      'data_hora': date.toIso8601String(),
      'finalizado': 0,
    });
  }

  @override
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end) async {
    final startFilter = DateTime(start.year, start.month, start.day);
    final endFilter = DateTime(start.year, start.month, start.day);

    final conn = await _sqliteConnectionFactory.openConnection();

    final result = await conn.rawQuery('''
      select * from todo
      where data_hora betwen ? and ?
      oder by data_hora''', [
      startFilter.toIso8601String(),
      endFilter.toIso8601String(),
    ]);

    return result.map((e) => TaskModel.loadFromDB(e)).toList();
  }
}