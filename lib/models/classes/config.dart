class Configuration {
  final String appwriteEndpoint;
  final String appwriteProjectId;
  final String appwriteDbTasksId;

  Configuration(
      {required this.appwriteEndpoint,
      required this.appwriteProjectId,
      required this.appwriteDbTasksId});
}
