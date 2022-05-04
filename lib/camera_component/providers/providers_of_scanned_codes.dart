// The state of our StateNotifier should be immutable.
// We could also use packages like Freezed to help with the implementation.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

// The StateNotifier class that will be passed to our StateNotifierProvider.
// This class should not expose state outside of its "state" property, which means
// no public getters/properties!
// The public methods on this class will be what allow the UI to modify the state.
class BarcodesNotifier extends StateNotifier<List<Barcode>> {
  // We initialize the list of todos to an empty list
  BarcodesNotifier() : super([]);

  // Let's allow the UI to add todos.
  void addBarcode(Barcode barcode) {
    // Since our state is immutable, we are not allowed to do `state.add(todo)`.
    // Instead, we should create a new list of todos which contains the previous
    // items and the new one.
    // Using Dart's spread operator here is helpful!
    state = [...state, barcode];
    // No need to call "notifyListeners" or anything similar. Calling "state ="
    // will automatically rebuild the UI when necessary.
  }

  void resetState() {
    super.state = [];
  }

  // Let's allow removing todos
  void removeBarcode(Barcode barcode) {
    // Again, our state is immutable. So we're making a new list instead of
    // changing the existing list.
    BarcodeValue bars = barcode.value;

    state = [
      for (final code in state)
        if (code.value.rawValue != barcode.value.rawValue) code,
    ];
  }
}

// Finally, we are using StateNotifierProvider to allow the UI to interact with
// our TodosNotifier class.
final barcodesProvider =
    StateNotifierProvider<BarcodesNotifier, List<Barcode>>((ref) {
  return BarcodesNotifier();
});

//List<Barcode> todos = ref.watch(barcodesProvider);
//          ref.read(counterProvider.notifier).state = ref.read(counterProvider.notifier).state + 1;
