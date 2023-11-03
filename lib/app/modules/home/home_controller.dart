// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/models/total_tasks_model.dart';
import 'package:todo_list_provider/app/models/week_task_model.dart';

import '../../services/tasks/tasks_service.dart';

class HomeController extends DefaultChangeNotifier {
  final TasksService _tasksService;

  var filterSelected = TaskFilterEnum.today;

  TotalTasksModel? todayTotalTask;
  TotalTasksModel? tomorrowTotalTask;
  TotalTasksModel? weekTotalTask;
  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];
  DateTime? initialDateWeek;
  DateTime? selectedDay;

  HomeController({
    required TasksService tasksService,
  }) : _tasksService = tasksService;

  Future<void> loadTotalTasks() async {
    final allTasks = await Future.wait([
      _tasksService.getToday(),
      _tasksService.getTomorrow(),
      _tasksService.getWeek(),
    ]);

    final todayTasks = allTasks[0] as List<TaskModel>;
    final tomorrowTasks = allTasks[1] as List<TaskModel>;
    final weekTasks = allTasks[2] as WeekTaskModel;

    todayTotalTask = TotalTasksModel(
      totalTasks: todayTasks.length,
      totalTaskFinish: todayTasks.where((task) => task.finished).length,
    );

    tomorrowTotalTask = TotalTasksModel(
      totalTasks: tomorrowTasks.length,
      totalTaskFinish: tomorrowTasks.where((task) => task.finished).length,
    );

    weekTotalTask = TotalTasksModel(
      totalTasks: weekTasks.tasks.length,
      totalTaskFinish: weekTasks.tasks.where((task) => task.finished).length,
    );

    notifyListeners();
  }

  Future<void> findTasks({required TaskFilterEnum filter}) async {
    filterSelected = filter;
    showLoading();
    notifyListeners();
    List<TaskModel> tasks;

    switch (filter) {
      case TaskFilterEnum.today:
        tasks = await _tasksService.getToday();
        break;
      case TaskFilterEnum.tomorrow:
        tasks = await _tasksService.getTomorrow();
        break;
      case TaskFilterEnum.week:
        final weekModel = await _tasksService.getWeek();
        initialDateWeek = weekModel.startDate;
        print('START: ${initialDateWeek}');
        tasks = weekModel.tasks;

        break;
    }

    filteredTasks = tasks;
    allTasks = tasks;

    hideLoading();
    notifyListeners();

    if (filter == TaskFilterEnum.week) {
      if (initialDateWeek != null) {
        filterByDay(selectedDay!);
      } else {
        filterByDay(initialDateWeek!);
      }
    } else {
      selectedDay = null;
    }
  }

  void filterByDay(DateTime date) {
    selectedDay = date;
    filteredTasks = allTasks.where((task) {
      return task.dateTime == date;
    }).toList();
    notifyListeners();
  }

  Future<void> refreshPage() async {
    showLoading();
    await findTasks(filter: filterSelected);
    await loadTotalTasks();
    notifyListeners();
    hideLoading();
  }

  Future<void> checkOrUncheckTask(TaskModel task) async {
    showLoadingAndResetState();

    notifyListeners();

    final taskUpdate = task.copyWith(finished: !task.finished);

    await _tasksService.checkOrUncheckTask(taskUpdate);
    refreshPage();
    hideLoading();
  }
}
