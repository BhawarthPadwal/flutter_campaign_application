part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class FetchCampaignsEvent extends HomeEvent {}

class NavigateToProfilePageEvent extends HomeEvent {}

class FetchSearchedCampaignsEvent extends HomeEvent {
  final String query;

  FetchSearchedCampaignsEvent(this.query);
}

class FetchSortedCampaignsEvents extends HomeEvent {
  final String sort;

  FetchSortedCampaignsEvents(this.sort);
}

class FetchNextPageEvent extends HomeEvent {
  final page;
  FetchNextPageEvent(this.page);
}

class CreateNewCampaignEvent extends HomeEvent {
  final String name;
  final String description;
  final String userId;
  final String startDate;
  final String endDate;

  CreateNewCampaignEvent({
    required this.name,
    required this.description,
    required this.userId,
    required this.startDate,
    required this.endDate,
  });
}
