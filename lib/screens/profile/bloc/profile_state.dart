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
