import 'package:campaign_application/apis/api.dart';

class AppReqEndPoint {

  static createUser() {
    return '${AppEnv.getAppEnvironment()}/users';
  }

  static getUserById(String id) {
    return '${AppEnv.getAppEnvironment()}/users/$id'; // add id here
  }

  static getCampaigns() {
    return '${AppEnv.getAppEnvironment()}/campaigns';
  }

}