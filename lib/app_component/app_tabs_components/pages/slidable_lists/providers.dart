import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Model {
  final String id;
  final Color color;
  final String name;

  Model(this.id, this.color, this.name);
}

class ContainerListState extends StateNotifier<List<Model>> {
  ContainerListState() : super(const []);

  static final provider =
      StateNotifierProvider<ContainerListState, List<Model>>((ref) {
    return ContainerListState();
  });

  //static const _uuid = Uuid();

  void setAllColor(Color color) {
    state = state.map((model) => Model(model.id, color, model.name)).toList();
  }

  void setModelColor(Model model, Color color) {
    final id = model.id;
    state = state.map((model) {
      return model.id == id ? Model(id, color, model.name) : model;
    }).toList();
  }

  void addItem() {
    // TODO: Replace state.length with your unique ID
    var key = UniqueKey();
    //  print('code ' + key.toString());
    state = [...state, Model(key.toString(), Colors.lightBlue, "name")];
  }

  void removeItem(String id) {
    state.removeWhere((element) => element.id == id);
  }
}
