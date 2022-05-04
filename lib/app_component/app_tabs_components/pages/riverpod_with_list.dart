import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RiverpodWithList extends StatelessWidget {
  const RiverpodWithList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PageView(
        children: [
          //_View1(),
          _View2(),
        ],
      ),
    );
  }
}

class _View1 extends ConsumerWidget {
  final List<String> _texts = [];
  final StateProvider<int> _lengthProvider = StateProvider((ref) => 0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final button = IconButton(
      onPressed: () {
        _texts.add("string-${_texts.length + 1}");
        ref.read(_lengthProvider.state).state = _texts.length;
      },
      icon: const Icon(Icons.add),
    );

    final listView = ListView.builder(
      itemCount: ref.watch(_lengthProvider.state).state,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_texts[index] + "/${_texts.length}"),
        );
      },
    );

    return Scaffold(
      body: Column(children: [
        Center(child: button),
        Expanded(child: listView),
      ]),
    );
  }
}

class _View2 extends ConsumerWidget {
  final List<String> _texts = [];
  final StateProvider<int> _lengthProvider = StateProvider((ref) => 0);
  final List<StateProvider<int>> _countProviderList = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final button = IconButton(
      onPressed: () {
        _texts.add("string-${_texts.length + 1}");
        _countProviderList.add(StateProvider((ref) => 0));
        ref.read(_lengthProvider.state).state = _texts.length;
      },
      icon: const Icon(Icons.add),
    );

    final listView = ListView.builder(
      itemCount: ref.watch(_lengthProvider.state).state,
      itemBuilder: (context, index) {
        final text = _texts[index] +
            "/${_texts.length}" +
            "\t${ref.watch(_countProviderList[index].state).state.toString()}";
        return ListTile(
          title: Text(text),
          onTap: () => ref.read(_countProviderList[index].state).state++,
        );
      },
    );

    return Scaffold(
      body: Column(children: [
        Center(child: button),
        Expanded(child: listView),
      ]),
    );
  }
}
