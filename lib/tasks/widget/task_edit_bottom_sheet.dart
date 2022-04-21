import 'package:labels_scanner/tasks/data/task_editing_state.dart';
import 'package:labels_scanner/tasks/notifier/task_editing_notifier.dart';
import 'package:labels_scanner/tasks/providers/task_list_providers.dart';
import 'package:labels_scanner/models/classes/task.dart';
import 'package:labels_scanner/models/enums/task_priority.dart';
import 'package:labels_scanner/models/ui_data/task_priority_ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskEditBottomSheet extends ConsumerStatefulWidget {
  final Task? editedTask;

  const TaskEditBottomSheet({Key? key, this.editedTask}) : super(key: key);

  @override
  _TaskEditBottomSheetState createState() => _TaskEditBottomSheetState();
}

class _TaskEditBottomSheetState extends ConsumerState<TaskEditBottomSheet> {
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _textEditingController = TextEditingController();

  bool _taskIsEdited = false;

  bool _priorityAccordionOpen = false;

  AutoDisposeStateNotifierProvider<TaskEditingNotifier, TaskEditingState>
      get provider => taskEditingProviderFamily(widget.editedTask);

  //
  // ######### Lifecycle
  //

  @override
  void initState() {
    super.initState();

    _taskIsEdited = widget.editedTask != null;

    final Task? initialTask = ref.read(provider).task;

    if (initialTask != null) {
      _textEditingController.text = initialTask.text ?? "";
      _titleEditingController.text = initialTask.title ?? "";
    }
  }

  @override
  void dispose() {
    _titleEditingController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  //
  // ######### UI Events
  //

  void _togglePriorityAccordion() {
    setState(() {
      _priorityAccordionOpen = !_priorityAccordionOpen;
    });
  }

  void _presentReminderDateSelection() async {
    final DateTime? previouslySelectedDate =
        ref.read(provider).task.reminderDate;
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: previouslySelectedDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025));
    if (picked == null) return;
    _setSelectedReminderDate(picked);
  }

  //
  // ######### Events
  //

  void _selectPriority(TaskPriority priority) {
    ref.read(provider.notifier).registerSelectedPriority(priority);
  }

  void _setSelectedReminderDate(DateTime date) {
    ref.read(provider.notifier).registerSelectedReminderDate(date);
  }

  Future<void> _saveTask() async {
    await ref
        .read(provider.notifier)
        .saveTask(_titleEditingController.text, _textEditingController.text);

    TaskEditingStatus status = ref.read(provider).saveStatus;
    if (status == TaskEditingStatus.success) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _deleteTask() async {
    await ref.read(provider.notifier).deleteTask();
    TaskEditingStatus status = ref.read(provider).deleteStatus;
    if (status == TaskEditingStatus.success) {
      Navigator.of(context).pop();
    }
  }

  //
  // ######### UI
  //

  Widget _buildTitleField() {
    return TextField(
      controller: _titleEditingController,
      decoration: const InputDecoration(hintText: "Title"),
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: _textEditingController,
      decoration: const InputDecoration(hintText: "Add a description"),
    );
  }

  Widget _buildPrioritySelector() {
    final TaskPriority selectedPriority =
        ref.watch(provider.select((state) => state.task.priority));
    final TaskPriorityUiElements priorityUiElements =
        TaskPriorityUiElements.priority(selectedPriority);
    return Column(
      children: [
        InkWell(
            onTap: _togglePriorityAccordion,
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: priorityUiElements.color),
                ),
                const Padding(padding: EdgeInsets.only(left: 12)),
                Text(priorityUiElements.title)
              ],
            )),
        (_priorityAccordionOpen)
            ? _buildPrioritySelectorAccordion()
            : Container(),
      ],
    );
  }

  Widget _buildPrioritySelectorAccordion() {
    return Column(
      children: TaskPriority.values.map((priority) {
        final TaskPriorityUiElements priorityUiElements =
            TaskPriorityUiElements.priority(priority);
        return InkWell(
          onTap: () => _selectPriority(priority),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: priorityUiElements.color),
              ),
              const Padding(padding: EdgeInsets.only(left: 12)),
              Text(priorityUiElements.title)
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildReminderDate() {
    DateTime? selectedReminderDate =
        ref.watch(provider.select((state) => state.task.reminderDate));
    return InkWell(
      onTap: _presentReminderDateSelection,
      child: (selectedReminderDate != null)
          ? Text(selectedReminderDate.toString())
          : const Text("Add a reminder date"),
    );
  }

  Widget _buildSaveButton() {
    final status = ref
        .watch(provider.select((TaskEditingState state) => state.saveStatus));
    return ElevatedButton(
      onPressed: _saveTask,
      child: (status == TaskEditingStatus.loading)
          ? const CircularProgressIndicator()
          : const Text("Save"),
    );
  }

  Widget _buildDeleteButton() {
    final status = ref
        .watch(provider.select((TaskEditingState state) => state.deleteStatus));
    return (status == TaskEditingStatus.loading)
        ? const CircularProgressIndicator(
            color: Colors.red,
          )
        : TextButton(
            onPressed: _deleteTask,
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ));
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> sheetWidgetList = [
      _buildTitleField(),
      _buildTextField(),
      _buildPrioritySelector(),
      _buildReminderDate(),
      _buildSaveButton(),
      if (_taskIsEdited) _buildDeleteButton()
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView.separated(
        itemCount: sheetWidgetList.length,
        itemBuilder: (_, index) => sheetWidgetList[index],
        separatorBuilder: (_, __) =>
            const Padding(padding: EdgeInsets.only(bottom: 20)),
      ),
    );
  }
}
