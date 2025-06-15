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
    on<FetchSortedCampaignsEvents>(fetchSortedCampaignsEvents);
    on<FetchSearchedCampaignsEvent>(fetchSearchedCampaignsEvent);
    on<CreateNewCampaignEvent>(createNewCampaignEvent);
    on<FetchNextPageEvent>(fetchNextPageEvent);
  }

  /*Future<void> fetchCampaignsEvent(
    FetchCampaignsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    try {
      final result = await ApiManager.get(AppReqEndPoint.getCampaigns());
      if (result['status'] == 200) {
        final response = result['data'];
        final Campaigns campaigns = campaignsFromJson(response);
        final List<Data> dataList = campaigns.data;
        logger.d(dataList);
        emit(HomeDataLoadedState(dataList));
      } else {
        emit(HomeErrorState(result['data'].toString()));
      }
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }*/

  Future<void> fetchCampaignsEvent(
    FetchCampaignsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    try {
      final dataList = await _fetchAndParseCampaigns();
      logger.d(dataList);
      emit(HomeDataLoadedState(dataList));
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }

  FutureOr<void> navigateToProfilePageEvent(
    NavigateToProfilePageEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(NavigatingProfilePageState());
  }

  FutureOr<void> fetchSortedCampaignsEvents(
    FetchSortedCampaignsEvents event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    try {
      final dataList = await _fetchAndParseCampaigns(sort: event.sort);
      logger.d(dataList);
      emit(HomeDataLoadedState(dataList));
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }

  FutureOr<void> fetchSearchedCampaignsEvent(
    FetchSearchedCampaignsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    try {
      final dataList = await _fetchAndParseCampaigns(query: event.query);
      logger.d(dataList);
      emit(HomeDataLoadedState(dataList));
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }
  FutureOr<void> fetchNextPageEvent(FetchNextPageEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    try {
      final dataList = await _fetchAndParseCampaigns(page: event.page);
      logger.d(dataList);
      emit(HomeDataLoadedState(dataList));
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }



  Future<List<Data>> _fetchAndParseCampaigns({
    String sort = 'recent',
    String query = '',
    int page = 1,
  }) async {
    final result = await ApiManager.get(
      AppReqEndPoint.getCampaigns(sort: sort, query: query, page: page),
    );

    if (result['status'] == 200) {
      final response = result['data'];
      final Campaigns campaigns = campaignsFromJson(response);
      return campaigns.data;
    } else {
      throw Exception(result['data'].toString());
    }
  }

  FutureOr<void> createNewCampaignEvent(
    CreateNewCampaignEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    try {
      final result = await ApiManager.post(AppReqEndPoint.createCampaign(), {
        "name": event.name,
        "description": event.description,
        "users_id": event.userId,
        "startDate": event.startDate,
        "endDate": event.endDate,
      });
      logger.d(result);
      if (result['status'] == 201 || result['status'] == 200) {
        emit(NewCampaignCreatedState());
        /// FOR RE-FETCHING CAMPAIGNS
        add(FetchCampaignsEvent());
      } else {
        emit(NewCampaignCreationFailedState(result['data'].toString()));
      }
    } catch (e) {
      emit(NewCampaignCreationFailedState(e.toString()));
    }
  }


}

// Future<List<Data>> _fetchAndParseCampaigns({String sort = 'recent', String query = '', int page = 1}) async {
//   final result = await ApiManager.get(
//     AppReqEndPoint.getCampaigns(sort: sort, query: query, page: page),
//   );
//
//   if (result['status'] == 200) {
//     final response = result['data'];
//     final Campaigns campaigns = campaignsFromJson(response);
//     return campaigns.data;
//   } else {
//     throw Exception(result['data'].toString());
//   }
// }
