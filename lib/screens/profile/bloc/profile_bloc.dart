import 'dart:async';
import 'package:campaign_application/apis/api.dart';
import 'package:bloc/bloc.dart';
import 'package:campaign_application/models/campaigns_by_userid_model.dart';
import 'package:meta/meta.dart';
import 'package:logger/logger.dart';

import '../../../auth_services/auth_service.dart';
import '../../../models/campaigns_model.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  Logger logger = Logger();

  ProfileBloc() : super(ProfileInitialState()) {
    on<FetchUserCampaignsEvent>(fetchUserCampaignsEvent);
    on<DeleteCampaignEvent>(deleteCampaignEvent);
    on<UpdateCampaignEvent>(updateCampaignEvent);
    on<LogoutEvent>(logoutEvent);
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

  FutureOr<void> deleteCampaignEvent(DeleteCampaignEvent event, Emitter<ProfileState> emit) async {
    try {
       final response = await ApiManager.delete(AppReqEndPoint.deleteCampaign(), {
         "userId": event.userId,
         "campaignId": event.campaignId
       });
       logger.d(response);
       if(response['status'] == 200) {
         emit(ProfileDataLoadedState(await fetchAndParseCampaigns(event.userId)));
         emit(CampaignDeletedSuccessState());
       } else {
         emit(CampaignDeletedErrorState(response['data']['message']));
       }
    } catch(e) {
      emit(CampaignDeletedErrorState(e.toString()));
    }
  }

  FutureOr<void> updateCampaignEvent(UpdateCampaignEvent event, Emitter<ProfileState> emit) async {
    try {
      final response = await ApiManager.put(AppReqEndPoint.updateCampaign(), {
        "userId": event.userId,
        "campaignId": event.campaignId,
        "name": event.name,
        "description": event.description,
        "startDate": event.startDate,
        "endDate": event.endDate
      });
      logger.d(response);
      if(response['status'] == 200) {
        emit(ProfileDataLoadedState(await fetchAndParseCampaigns(event.userId)));
        emit(CampaignUpdatedSuccessState());
      } else {
        emit(CampaignUpdatedErrorState(response['data']['message']));
      }
    } catch(e) {
      emit(CampaignUpdatedErrorState(e.toString()));
    }
  }

  FutureOr<void> logoutEvent(LogoutEvent event, Emitter<ProfileState> emit) {
    try {
      AuthService().signOutUser();
      emit(NavigateToLoginPageState());
    } catch(e) {
      emit(LogoutErrorState(e.toString()));
    }
  }
}
