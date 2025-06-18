class AppEnv {

  static const String _baseUrl = 'http://10.0.2.2:5000';

  static String getAppEnvironment() {
    return AppEnv._baseUrl;
  }
}