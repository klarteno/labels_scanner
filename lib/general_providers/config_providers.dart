import 'package:labels_scanner/models/classes/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final configurationProvider = Provider<Configuration>((ref) => Configuration(
    appwriteEndpoint: "http://7980-90-127-37-203.ngrok.io/v1",
    appwriteProjectId: "616d96cf3c63d",
    appwriteDbTasksId: "61715dbfd222c"));
