import 'dart:async';
import 'package:campaign_application/apis/api.dart';
import 'package:bloc/bloc.dart';
import 'package:campaign_application/models/campaigns_by_userid_model.dart';
import 'package:meta/meta.dart';
import 'package:logger/logger.dart';

import '../../../models/campaigns_model.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  Logger logger = Logger();

  ProfileBloc() : super(ProfileInitialState()) {
    on<FetchUserCampaignsEvent>(fetchUserCampaignsEvent);
  }

  Future<List<UserCampaign>> fetchAndParseCampaigns(String id) async {
    final List<dynamic> result = await ApiManager.getList(
      AppReqEndPoint.getCampaignByUserId(id),
    );
    final campaigns = result.map((e) => UserCampaign.fromJson(e)).toList();
    return campaigns;
  }

  FutureOr<void> fetchUserCampaignsEvent(
    FetchUserCampaignsEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileDataLoadingState());
    Future.delayed(const Duration(seconds: 2));
    try {
      final dataList = await fetchAndParseCampaigns(event.userId);
      logger.d(dataList);
      emit(ProfileDataLoadedState(dataList));
    } catch (e) {
      emit(ProfileDataErrorState(e.toString()));
    }
  }
}
