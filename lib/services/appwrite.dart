import 'package:appwrite/appwrite.dart';
import 'package:labels_scanner/general_providers/config_providers.dart';
import 'package:labels_scanner/models/classes/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appwriteClientProvider = Provider<Client>((ref) {
  Configuration config = ref.watch(configurationProvider);
  Client client = Client();
  client
      .setEndpoint(config.appwriteEndpoint)
      .setProject(config.appwriteProjectId)
      .setSelfSigned(status: true);
  return client;
});

final appwriteAccountProvider =
    Provider<Account>((ref) => Account(ref.watch(appwriteClientProvider)));

final appwriteDatabaseProvider =
    Provider<Database>((ref) => Database(ref.watch(appwriteClientProvider)));

final appwriteRealtimeProvider =
    Provider<Realtime>((ref) => Realtime(ref.watch(appwriteClientProvider)));
