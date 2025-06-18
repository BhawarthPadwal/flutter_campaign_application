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
  List<Data> _allCampaigns = [];
  int _currentPage = 1;
  String _mode = 'default'; // 'default', 'search', 'sort'
  String _query = '';
  String _sort = 'recent';

  HomeBloc() : super(HomeInitialState()) {
    on<FetchCampaignsEvent>(fetchCampaignsEvent);
    on<NavigateToProfilePageEvent>(navigateToProfilePageEvent);
    on<FetchSortedCampaignsEvents>(fetchSortedCampaignsEvents);
    on<FetchSearchedCampaignsEvent>(fetchSearchedCampaignsEvent);
    on<CreateNewCampaignEvent>(createNewCampaignEvent);
    on<FetchNextPageEvent>(fetchNextPageEvent);
    on<VoteCampaignEvent>(voteCampaignEvent);
  }

  Future<void> fetchCampaignsEvent(
    FetchCampaignsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    _mode = 'default';
    _query = '';
    _sort = 'recent';
    _currentPage = 1;
    _allCampaigns.clear();

    try {
      final result = await _fetchAndParseCampaigns(page: _currentPage);
      _allCampaigns = result['data'];
      emit(HomeDataLoadedState(List.from(_allCampaigns), totalPages: result['totalPages'], currentPage: _currentPage));
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

  Future<void> fetchSortedCampaignsEvents(
    FetchSortedCampaignsEvents event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    _mode = 'sort';
    _sort = event.sort;
    _currentPage = 1;
    _allCampaigns.clear();

    try {
      final result = await _fetchAndParseCampaigns(sort: _sort, page: _currentPage);
      _allCampaigns = result['data'];
      emit(HomeDataLoadedState(List.from(_allCampaigns), totalPages: result['totalPages'], currentPage: _currentPage));

    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }

  Future<void> fetchSearchedCampaignsEvent(
    FetchSearchedCampaignsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    _mode = 'search';
    _query = event.query;
    _currentPage = 1;
    _allCampaigns.clear();

    try {
      final result = await _fetchAndParseCampaigns(query: _query, page: _currentPage);
      _allCampaigns = result['data'];
      emit(HomeDataLoadedState(List.from(_allCampaigns), totalPages: result['totalPages'], currentPage: _currentPage));

    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }

  FutureOr<void> fetchNextPageEvent(
      FetchNextPageEvent event,
      Emitter<HomeState> emit,
      ) async {
    logger.i('Fetching next page ${event.page} with mode: $_mode, sort: $_sort, query: $_query');

    try {
      Map<String, dynamic> result;

      if (_mode == 'sort') {
        result = await _fetchAndParseCampaigns(sort: _sort, page: event.page);
      } else if (_mode == 'search') {
        result = await _fetchAndParseCampaigns(query: _query, page: event.page);
      } else {
        result = await _fetchAndParseCampaigns(page: event.page);
      }
      final newData = result['data'];
      final totalPages = result['totalPages'];
      logger.i('Fetched ${newData.length} new campaigns. Total Pages: $totalPages');
      // Fix: Update current page
      _currentPage = event.page;

      if (state is HomeDataLoadedState) {
        final currentState = state as HomeDataLoadedState;
        final updatedList = List<Data>.from(currentState.campaigns)..addAll(newData);
        emit(HomeDataLoadedState(updatedList, isPagination: true, totalPages: totalPages, currentPage: _currentPage));
      } else {
        emit(HomeDataLoadedState(newData, totalPages: totalPages, currentPage: _currentPage));
      }
    } catch (e) {
      logger.e('Error fetching next page: $e');
      emit(HomeErrorState(e.toString()));
    }
  }


  Future<Map<String, dynamic>> _fetchAndParseCampaigns({
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
      return {
        'data': campaigns.data,
        'totalPages': campaigns.totalPages, // <- from your model
      };
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

  FutureOr<void> voteCampaignEvent(
    VoteCampaignEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final result = await ApiManager.post(AppReqEndPoint.createVote(), {
        "campaignId": event.campaignId,
        "userId": event.userId,
        "vote": event.isUpvote ? "upvote" : "downvote",
      });
      if (result['status'] == 201 || result['status'] == 200) {
        add(FetchCampaignsEvent());
      } else {
        logger.e(result['data']);
        emit(VoteAlreadyExistErrorState(result['data'].toString()));
      }
    } catch (e) {
      logger.e(e);
      emit(VoteAlreadyExistErrorState(e.toString()));
    }
  }
}