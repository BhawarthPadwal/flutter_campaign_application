part of 'home_bloc.dart';

@immutable
/// base class for non actionable states (i.e actions that causes rebuild of UI)
sealed class HomeState {}

/// Base class for actionable state (i.e actions that does not causes rebuild of UI)
sealed class HomeActionableState extends HomeState {}

final class HomeInitialState extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeDataLoadedState extends HomeState {
  final List<Data> campaigns;
  final bool isPagination;
  HomeDataLoadedState(this.campaigns, {this.isPagination = false});
}

final class HomeErrorState extends HomeState {
  final String errorMessage;
  HomeErrorState(this.errorMessage);
}

final class NavigatingProfilePageState extends HomeActionableState {}

final class NewCampaignCreatedState extends HomeState {}

final class NewCampaignCreationFailedState extends HomeState {
  final String errorMessage;
  NewCampaignCreationFailedState(this.errorMessage);
}

final class VoteAlreadyExistErrorState extends HomeActionableState {
  final String errorMessage;
  VoteAlreadyExistErrorState(this.errorMessage);
}





