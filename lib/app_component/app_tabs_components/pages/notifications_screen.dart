import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:labels_scanner/app_component/app_tabs_components/pages/slidable_lists/providers.dart';
import 'package:labels_scanner/app_component/app_tabs_components/pages/slidable_lists/utils_slidable.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: AppState(
        direction: Axis.horizontal,
        child: MyHomePage(),
      ),
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slidable Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AppState(
        direction: Axis.horizontal,
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  bool alive = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelList = ref.watch(ContainerListState.provider);
    Future.delayed(Duration.zero, () => ref.read(ContainerListState.provider));

    final direction = AppState.of(context)!.direction;
    return Scaffold(
      body: ListView.builder(
        scrollDirection: flipAxis(direction),
        itemCount: modelList.length,
        itemBuilder: (_, index) {
          ValueKey valueKey = ValueKey(modelList[index].id);
          String nameLabel = 'hello ' +
              modelList[index].id.toString() +
              ' ' +
              index.toString();

          return Slidable(
            key: valueKey,
            direction: direction,
            startActionPane: ActionPane(
              motion: const DrawerMotion(),
              dismissible: DismissiblePane(
                onDismissed: () {
                  ref
                      .read(ContainerListState.provider.notifier)
                      .removeItem(valueKey.value);
                },
                closeOnCancel: true,
                confirmDismiss: () async {
                  return await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Are you sure?'),
                            content: const Text('Are you sure to dismiss?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                                child: const Text('Yes'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: const Text('No'),
                              ),
                            ],
                          );
                        },
                      ) ??
                      false;
                },
              ),
              children: const [
                SlideAction(color: Colors.green, icon: Icons.share),
                SlideAction(color: Colors.amber, icon: Icons.delete),
              ],
            ),
            endActionPane: const ActionPane(
              motion: DrawerMotion(),
              children: [
                SlideAction(color: Colors.red, icon: Icons.delete_forever),
                SlideAction(color: Colors.blue, icon: Icons.alarm, flex: 2),
              ],
            ),
            child: Tile(color: Colors.lime, text: nameLabel),
          );
        },
      ),
      floatingActionButton: const RedButton(),
    );
  }
}

class RedButton extends ConsumerWidget {
  const RedButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Bonus: Red button will be notified on changes
    final state = ref.watch(ContainerListState.provider);

    return FloatingActionButton.extended(
      onPressed: () {
        ref.read(ContainerListState.provider.notifier).addItem();
      },
      backgroundColor: Colors.red,
      label: Text('Set all color'),
    );
  }
}
