import 'package:campaign_application/screens/authentication/login_page.dart';
import 'package:campaign_application/screens/profile/bloc/profile_bloc.dart';
import 'package:campaign_application/screens/profile/services/profile_services.dart';
import 'package:campaign_application/screens/shimmer_screens/campaign_card_shimmer.dart';
import 'package:campaign_application/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth_services/auth_service.dart';
import '../../themes/constants.dart';

class Profile extends StatefulWidget {
  static const String rootName = 'profilePage';

  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileBloc profileBloc = ProfileBloc();
  String? userId;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    final authService = AuthService();
    userId = authService.currentUserId;
    userEmail = authService.currentUserEmail;
    if (userId != null) {
      profileBloc.add(FetchUserCampaignsEvent(userId!));
    } else {
      debugPrint('No user logged in. Skipping fetch.');
    }
  }

  @override
  void dispose() {
    profileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      bloc: profileBloc,
      listenWhen: (previous, current) => current is ProfileActionableState,
      buildWhen: (previous, current) => current is! ProfileActionableState,
      listener: (context, state) {
        if (state is CampaignDeletedSuccessState) {
          showSnackbar(context, message: 'Campaign deleted successfully');
        } else if (state is CampaignDeletedErrorState) {
          showSnackbar(context, message: state.error);
        } else if (state is CampaignUpdatedSuccessState) {
          showSnackbar(context, message: 'Campaign updated successfully');
        } else if (state is CampaignUpdatedErrorState) {
          showSnackbar(context, message: state.error);
        } else if (state is NavigateToLoginPageState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            LoginPage.rootName,
            (route) => false,
          );
        } else if (state is LogoutErrorState) {
          showSnackbar(context, message: state.error);
        }
      },
      builder: (context, state) {
        return AnnotatedRegion(
          value: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
          child: Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: padding20,
                      vertical: padding10,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: padding20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            profileBloc.add(LogoutEvent());
                          },
                          icon: Icon(Icons.logout),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: padding20,
                      vertical: padding10,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.blueAccent,
                            child: Icon(
                              Icons.person,
                              size: 32,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Logged in as',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(color: Colors.grey[600]),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  userEmail ?? 'No email',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.verified_user,
                            color: Colors.green,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: padding10,
                        vertical: padding10,
                      ),
                      child: Builder(
                        builder: (_) {
                          if (state is ProfileDataLoadingState) {
                            return ListView.builder(
                              itemCount: 4,
                              itemBuilder:
                                  (context, index) =>
                                      shimmerCampaignCard(context),
                            );
                          } else if (state is ProfileDataLoadedState) {
                            final campaigns = state.campaigns;
                            if (campaigns.isEmpty) {
                              return const Center(
                                child: Text("No campaigns found"),
                              );
                            }
                            return ListView.builder(
                              itemCount: campaigns.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                final campaign = campaigns[index];
                                return GestureDetector(
                                  onTap: () {
                                    showCampaignBottomSheet(
                                      context: context,
                                      campaign: campaign,
                                      profileBloc: profileBloc,
                                    );
                                  },
                                  child: userCampaignCard(
                                    context,
                                    campaign,
                                    profileBloc,
                                  ),
                                );
                              },
                            );
                          } else if (state is ProfileDataErrorState) {
                            return Center(child: Text("No campaigns found"));
                          } else {
                            return const Center(
                              child: Text("No campaigns found"),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
