import 'package:campaign_application/apis/api.dart';

class AppReqEndPoint {
  /// GET USERS FROM API
  static createUser() {
    return '${AppEnv.getAppEnvironment()}/users';
  }

  /// GET USER BY ID
  static getUserById(String id) {
    return '${AppEnv.getAppEnvironment()}/users/$id'; // add id here
  }

  /// FOR GETTING CAMPAIGNS FROM API (Same for pagination, searching, sorting)
  static getCampaigns({
    int page = 1,
    int pageSize = 10,
    String sort = 'recent',
    String query = '',
  }) {
    return '${AppEnv.getAppEnvironment()}/campaigns?page=$page&pageSize=$pageSize&sort=$sort&query=$query';
  }

  /// CREATE NEW CAMPAIGN
  static createCampaign() {
    return '${AppEnv.getAppEnvironment()}/campaigns';
  }

  /// GET CAMPAIGNS BY USER ID
  static getCampaignByUserId(String id) {
    return '${AppEnv.getAppEnvironment()}/campaigns/user/$id';
  }
}
