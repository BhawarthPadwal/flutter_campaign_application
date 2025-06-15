part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class FetchUserCampaignsEvent extends ProfileEvent {
  String userId = '';
  FetchUserCampaignsEvent(this.userId);
}

