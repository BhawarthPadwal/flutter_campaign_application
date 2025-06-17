import 'dart:async';

import 'package:campaign_application/screens/home_page/bloc/home_bloc.dart';
import 'package:campaign_application/screens/home_page/services/home_services.dart';
import 'package:campaign_application/screens/profile/profile.dart';
import 'package:campaign_application/screens/shimmer_screens/campaign_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../themes/theme.dart';
import '../home_page/widget/campaign_dialog.dart';

class HomePage extends StatefulWidget {
  static const String rootName = 'homePage';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc homeBloc = HomeBloc();
  String searchQuery = '';
  late ScrollController _scrollController;
  bool _isFetchingMore = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    homeBloc.add(FetchCampaignsEvent());

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      homeBloc.add(FetchSearchedCampaignsEvent(query));
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200 &&
        !_isFetchingMore &&
        homeBloc.state is HomeDataLoadedState) {
      final currentState = homeBloc.state as HomeDataLoadedState;
      final nextPage = currentState.currentPage + 1;

      if (nextPage <= currentState.totalPages) { /// Check if there are more pages to fetch
        _isFetchingMore = true;
        homeBloc.add(FetchNextPageEvent(nextPage));
      }
    }
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
        } else if (state is VoteAlreadyExistErrorState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
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
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (_) => CampaignDialog(
                        homeBloc,
                        FirebaseAuth.instance.currentUser!.uid,
                      ),
                );
              },
              backgroundColor: blueGreyColor,
              // Matches your UI theme
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16), // Soft rounded FAB
              ),
              tooltip: 'Add Campaign',
              // Or your app's primary color
              child: Icon(Icons.add, color: whiteColor),
            ),
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
                          'Campaigns',
                          style: TextStyle(
                            fontSize: padding20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            homeBloc.add(NavigateToProfilePageEvent());
                          },
                          icon: Icon(Icons.person),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: padding10,
                      vertical: padding5,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.825,
                          child: TextField(
                            onChanged: _onSearchChanged,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              hintText: 'Search campaigns...',
                              prefixIcon: Icon(Icons.search),
                              fillColor: blueGreyColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide
                                        .none, // <- this removes underline
                              ),
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(10),
                              // ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 16,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            child: PopupMenuButton<String>(
                              icon: Image.asset(
                                'assets/icons/ic_filter.png',
                                width: padding25,
                                height: padding25,
                              ),
                              onSelected: (String selectedSort) {
                                homeBloc.add(
                                  FetchSortedCampaignsEvents(selectedSort),
                                );
                              },
                              itemBuilder:
                                  (BuildContext context) =>
                                      <PopupMenuEntry<String>>[
                                        const PopupMenuItem<String>(
                                          value: 'recent',
                                          child: Text('Recent'),
                                        ),
                                        const PopupMenuItem<String>(
                                          value: 'top-rated',
                                          child: Text('Top Rated'),
                                        ),
                                        const PopupMenuItem<String>(
                                          value: 'a-z',
                                          child: Text('A-Z'),
                                        ),
                                      ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: padding10,
                        vertical: padding10,
                      ),
                      child:
                          state is HomeLoadingState
                              ? ListView.builder(itemCount: 6, itemBuilder: (context, index) => shimmerCampaignCard())
                              : state is HomeDataLoadedState
                              ? Builder(
                                builder: (_) {
                                  if (state.isPagination) { /// Reset pagination flag when data is loaded via pagination
                                    _isFetchingMore = false;
                                  }
                                  return state.campaigns.isEmpty
                                      ? Center(
                                        child: Text("No campaigns found"),
                                      )
                                      : RefreshIndicator(
                                        onRefresh: () {
                                          homeBloc.add(FetchCampaignsEvent());
                                          return Future.delayed(
                                            Duration(seconds: 1),
                                          );
                                        },
                                        child: ListView.builder(
                                          controller: _scrollController,
                                          itemCount: state.campaigns.length + 1,
                                          itemBuilder: (context, index) {
                                            if (index <
                                                state.campaigns.length) {
                                              final campaign =
                                                  state.campaigns[index];
                                              return campaignCard(context, campaign, homeBloc);
                                            } else {
                                              return state.currentPage < state.totalPages
                                                  ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          16.0,
                                                        ),
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(color: Colors.grey[300]),
                                                    ),
                                                  )
                                                  : SizedBox.shrink();
                                            }
                                          },
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
