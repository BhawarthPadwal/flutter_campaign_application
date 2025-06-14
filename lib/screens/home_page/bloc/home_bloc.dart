import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:campaign_application/models/campaigns_model.dart';
import 'package:meta/meta.dart';
import 'package:logger/logger.dart';
import '../../../apis/api_manager.dart';
import '../../../apis/app_req.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  Logger logger = Logger();
  HomeBloc() : super(HomeInitialState()) {
    on<FetchCampaignsEvent>(fetchCampaignsEvent);
    on<NavigateToProfilePageEvent>(navigateToProfilePageEvent);
  }

  Future<void> fetchCampaignsEvent(
    FetchCampaignsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    try {
      final result = await ApiManager.get(AppReqEndPoint.getCampaigns());

      if (result['status'] == 200) {
        final response = result['data'];
        logger.d(response);
        logger.i(response.runtimeType);
        final Campaigns campaigns = campaignsFromJson(response);
        logger.d(campaigns);
        final List<Data> dataList = campaigns.data;
        logger.d(dataList);
        emit(HomeDataLoadedState(dataList));
      } else {
        emit(HomeErrorState(result['data'].toString()));
      }
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }

  FutureOr<void> navigateToProfilePageEvent(NavigateToProfilePageEvent event, Emitter<HomeState> emit) {
    emit(NavigatingProfilePageState());
  }
}
