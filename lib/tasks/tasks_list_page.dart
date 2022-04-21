import 'package:labels_scanner/tasks/data/tasks_list_state.dart';
import 'package:labels_scanner/tasks/providers/task_list_providers.dart';
import 'package:labels_scanner/tasks/widget/task_edit_bottom_sheet.dart';
import 'package:labels_scanner/tasks/widget/task_tile.dart';
import 'package:labels_scanner/models/classes/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskListPage extends ConsumerStatefulWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskListPageState();
}

class _TaskListPageState extends ConsumerState<TaskListPage> {
  //
  // ########## Lifecycle
  //

  @override
  void initState() {
    super.initState();
    _getTasks();
  }

  //
  // ########## Navigation
  //

  void _presentAddTaskPopup() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return const TaskEditBottomSheet();
        });
  }

  void _presentEditTaskPopup(Task task) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return TaskEditBottomSheet(editedTask: task);
        });
  }

  //
  // ########## Events
  //

  void _getTasks() {
    ref.read(tasksListStateProvider.notifier).getTasks();
  }

  void _toggleTaskCheckbox(String? taskId, bool selected) {
    if (taskId == null) return;
    ref.read(tasksListStateProvider.notifier).toggleTask(taskId, selected);
  }

  void _deleteTask(Task task) {}

  //
  // ########## UI
  //

  Widget _buildTaskTile(Task task) {
    return TaskTile(
        task: task,
        onTap: () => _presentEditTaskPopup(task),
        onToggled: (bool selected) => _toggleTaskCheckbox(task.id, selected));
  }

  Widget _buildTasksList(TaskListState state) {
    return ListView.builder(
        itemCount: state.tasks.length +
            ((state.status == TaskListStatus.loading) ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == state.tasks.length) {
            return const CircularProgressIndicator();
          }
          return _buildTaskTile(state.tasks[index]);
        });
  }

  Widget _buildEmptyList(TaskListState state) {
    return Center(
      child: Column(
        children: [
          const Text("such empty..."),
          if (state.status == TaskListStatus.loading)
            const CircularProgressIndicator()
        ],
      ),
    );
  }

  Widget _buildBody() {
    final TaskListState state = ref.watch(tasksListStateProvider);
    if (state.tasks.isEmpty) return _buildEmptyList(state);
    return _buildTasksList(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _presentAddTaskPopup,
      ),
      appBar: AppBar(
        title: Column(
          children: const [
            Text("Riverpod + StateNotifier + AppWrite"),
            Text("Tasks List"),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.refresh_rounded),
          onPressed: _getTasks,
        ),
      ),
    );
  }
}
