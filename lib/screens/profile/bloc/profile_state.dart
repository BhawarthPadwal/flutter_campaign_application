part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

sealed class ProfileActionableState extends ProfileState {}

final class ProfileInitialState extends ProfileState {}

final class ProfileDataLoadingState extends ProfileState {}

final class ProfileDataLoadedState extends ProfileState {
  final List<UserCampaign> campaigns;

  ProfileDataLoadedState(this.campaigns);
}

final class ProfileDataErrorState extends ProfileState {
  final String error;

  ProfileDataErrorState(this.error);
}

final class CampaignDeletedSuccessState extends ProfileActionableState {}

final class CampaignDeletedErrorState extends ProfileActionableState {
  final String error;

  CampaignDeletedErrorState(this.error);
}

final class CampaignUpdatedSuccessState extends ProfileActionableState {}

final class CampaignUpdatedErrorState extends ProfileActionableState {
  final String error;

  CampaignUpdatedErrorState(this.error);
}

final class NavigateToLoginPageState extends ProfileActionableState {}

final class LogoutErrorState extends ProfileState {
  final String error;
  LogoutErrorState(this.error);
}
