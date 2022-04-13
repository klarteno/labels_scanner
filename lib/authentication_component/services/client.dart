import 'package:appwrite/appwrite.dart';

class ApiClient {
  Client get _client {
    Client client = Client();

    client
        .setEndpoint(
            'http://104.248.89.7/v1') //https://demo.appwrite.io/v1 http://192.168.0.31/v1 https://modern-snake-10.loca.lt/v1
        .setProject('6251874517fb9ef84e4a') //almostNetflix2
        .setSelfSigned(status: true);

    return client;
  }

  static Account get account => Account(_instance._client);
  static Database get database => Database(_instance._client);
  static Storage get storage => Storage(_instance._client);

  static final ApiClient _instance = ApiClient._internal();
  ApiClient._internal();
  factory ApiClient() => _instance;
}
