part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class FetchCampaignsEvent extends HomeEvent {}

class NavigateToProfilePageEvent extends HomeEvent {}