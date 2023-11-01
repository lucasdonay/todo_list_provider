// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/services/tasks/tasks_service.dart';

class TaskCreateController extends DefaultChangeNotifier {
  TasksService _tasksService;

  DateTime? _selectedDate;

  TaskCreateController({
    required TasksService tasksService,
  }) : _tasksService = tasksService;

  set selectedDate(DateTime? selectedDate) {
    resetState();
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

   void save(String description) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      if (_selectedDate != null) {
        await _tasksService.save(_selectedDate!, description);
        success();
      } else {
        setError('Data não selecionada');
      }
    } catch (e, s) {
      print(e);
      print(s);
      setError('Erro ao cadastrar, tente novamente.');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
