class AppEnv {

  static const String _baseUrl = 'http://192.168.0.107:5000';

  static String getAppEnvironment() {
    return AppEnv._baseUrl;
  }
}