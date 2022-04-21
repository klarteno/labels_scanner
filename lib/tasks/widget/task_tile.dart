import 'package:labels_scanner/models/classes/task.dart';
import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(
      {Key? key,
      required this.task,
      required this.onToggled,
      required this.onTap})
      : super(key: key);

  final Task task;
  final VoidCallback onTap;
  final ValueChanged<bool> onToggled;

  //
  //
  //

  //
  // ######## UI
  //

  Widget _buildCheckboxPart() {
    return Checkbox(
        value: task.done, onChanged: (selected) => onToggled(selected!));
  }

  Widget _buildDatesPart() {
    return Container();
  }

  Widget _buildTextPart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title ?? "",
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
          if (task.text != null) Text(task.text!)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black54.withAlpha(100),
                blurRadius: 6,
                offset: const Offset(1, 2))
          ]),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            _buildCheckboxPart(),
            Expanded(child: _buildTextPart()),
            _buildDatesPart()
          ],
        ),
      ),
    );
  }
}
