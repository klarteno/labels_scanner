import 'package:copy_with_extension/copy_with_extension.dart';

part 'shared_preferences_data.g.dart';

@CopyWith()
class SharedPreferencesData {
  final String? activeAccountSessionId;

  SharedPreferencesData({this.activeAccountSessionId});
}
