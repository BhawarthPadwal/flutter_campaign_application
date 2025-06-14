import 'package:campaign_application/screens/home_page/bloc/home_bloc.dart';
import 'package:campaign_application/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../themes/theme.dart';

class HomePage extends StatefulWidget {
  static const String rootName = 'homePage';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    homeBloc.add(FetchCampaignsEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionableState,
      buildWhen: (previous, current) => current is! HomeActionableState,
      listener: (context, state) {
        if (state is NavigatingProfilePageState) {
          Navigator.pushNamed(context, Profile.rootName);
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
                  Row(
                    children: [
                      Text('Campaigns'),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          homeBloc.add(NavigateToProfilePageEvent());
                        },
                        icon: Icon(Icons.person),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: padding10,
                        vertical: padding10,
                      ),
                      child:
                          state is HomeLoadingState
                              ? Center(child: CircularProgressIndicator())
                              : state is HomeDataLoadedState
                              ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.campaigns.length,
                                itemBuilder: (context, index) {
                                  final campaign = state.campaigns[index];
                                  return Card(
                                    child: ListTile(
                                      title: Text(campaign.name),
                                      subtitle: Text(campaign.description),
                                      trailing: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('👍 ${campaign.votes.upvotes}'),
                                          Text(
                                            '👎 ${campaign.votes.downvotes}',
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                              : state is HomeErrorState
                              ? Center(child: Text(state.errorMessage))
                              : Center(child: Text("No campaigns found")),
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
