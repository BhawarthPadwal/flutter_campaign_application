import 'package:campaign_application/screens/authentication/login_page.dart';
import 'package:campaign_application/screens/profile/bloc/profile_bloc.dart';
import 'package:campaign_application/screens/profile/services/profile_services.dart';
import 'package:campaign_application/screens/shimmer_screens/campaign_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth_services/auth_service.dart';
import '../../themes/theme.dart';

class Profile extends StatefulWidget {
  static const String rootName = 'profilePage';

  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileBloc profileBloc = ProfileBloc();

  @override
  void initState() {
    super.initState();
    final userId = FirebaseAuth.instance.currentUser!.uid;
    profileBloc.add(FetchUserCampaignsEvent(userId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      bloc: profileBloc,
      listenWhen: (previous, current) => current is ProfileActionableState,
      buildWhen: (previous, current) => current is! ProfileActionableState,
      listener: (context, state) {
        if (state is CampaignDeletedSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Campaign deleted successfully'),
            ),
          );
        } else if (state is CampaignDeletedErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        } else if (state is CampaignUpdatedSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Campaign updated successfully'),
            ),
          );
        } else if (state is CampaignUpdatedErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
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
            backgroundColor: whiteColor,
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
                            AuthService().signOutUser();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              LoginPage.rootName,
                              (route) => false,
                            );
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
                        color: Colors.grey[100],
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
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  FirebaseAuth.instance.currentUser!.email ??
                                      'No email',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
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
                            return ListView.builder(itemCount: 4,itemBuilder: (context, index) => shimmerCampaignCard());
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
                                    showCampaignBottomSheet(context: context, campaign: campaign, profileBloc: profileBloc);
                                  },
                                  child: userCampaignCard(context, campaign, profileBloc),
                                );
                              },
                            );
                          } else if (state is ProfileDataErrorState) {
                            //return Center(child: Text(state.error));
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
