import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    final direction = AppState.of(context)!.direction;
    return ActionTypeListener(
      child: GestureDetector(
        onTap: () {
          print('$text');
        },
        onLongPress: () => Slidable.of(context)!.openEndActionPane(),
        child: Container(
          color: color,
          height: direction == Axis.horizontal ? 100 : double.infinity,
          width: direction == Axis.horizontal ? double.infinity : 100,
          child: Center(child: Text(text)),
        ),
      ),
    );
  }
}

class ActionTypeListener extends StatefulWidget {
  const ActionTypeListener({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _ActionTypeListenerState createState() => _ActionTypeListenerState();
}

class _ActionTypeListenerState extends State<ActionTypeListener> {
  ValueNotifier<ActionPaneType>? _actionPaneTypeValueNotifier;

  @override
  void initState() {
    super.initState();
    _actionPaneTypeValueNotifier = Slidable.of(context)?.actionPaneType;
    _actionPaneTypeValueNotifier?.addListener(_onActionPaneTypeChanged);
  }

  @override
  void dispose() {
    _actionPaneTypeValueNotifier?.removeListener(_onActionPaneTypeChanged);
    super.dispose();
  }

  void _onActionPaneTypeChanged() {
    debugPrint('Value is ${_actionPaneTypeValueNotifier?.value}');
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class AppState extends InheritedWidget {
  const AppState({
    Key? key,
    required this.direction,
    required Widget child,
  }) : super(key: key, child: child);

  final Axis direction;

  @override
  bool updateShouldNotify(covariant AppState oldWidget) {
    return direction != oldWidget.direction;
  }

  static AppState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppState>();
  }
}
