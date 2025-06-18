part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class FetchUserCampaignsEvent extends ProfileEvent {
  final String userId;

  FetchUserCampaignsEvent(this.userId);
}

final class DeleteCampaignEvent extends ProfileEvent {
  final String campaignId;
  final String userId;

  DeleteCampaignEvent(this.campaignId, this.userId);
}

final class UpdateCampaignEvent extends ProfileEvent {
  final int campaignId;
  final String userId;
  final String name;
  final String description;
  final String startDate;
  final String endDate;

  UpdateCampaignEvent({
    required this.campaignId,
    required this.userId,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
  });

}

final class LogoutEvent extends ProfileEvent {}