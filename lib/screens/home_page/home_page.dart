import 'package:campaign_application/screens/home_page/bloc/home_bloc.dart';
import 'package:campaign_application/screens/profile/profile.dart';
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
  int _currentPage = 1;
  bool _isFetchingMore = false;


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

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 &&
        !_isFetchingMore) {
      _isFetchingMore = true;
      _currentPage++;
      homeBloc.add(FetchNextPageEvent(_currentPage));
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
              backgroundColor: Colors.grey,
              tooltip: 'Add Campaign', // Or your app's primary color
              child: Icon(Icons.add, color: blackColor),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: padding10,
                      vertical: padding10,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Campaigns',
                          style: TextStyle(fontSize: padding20),
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
                            onChanged: (value) {
                              searchQuery = value;
                              homeBloc.add(
                                FetchSearchedCampaignsEvent(searchQuery),
                              );
                            },
                            decoration: InputDecoration(
                              hintText: 'Search campaigns...',
                              prefixIcon: Icon(Icons.search),
                              fillColor: blueGreyColor,
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
                      child: state is HomeLoadingState
                          ? Center(child: CircularProgressIndicator())
                          : state is HomeDataLoadedState
                          ? Builder(
                        builder: (_) {
                          // ✅ Reset pagination flag when data is loaded via pagination
                          if (state.isPagination) {
                            _isFetchingMore = false;
                          }

                          return state.campaigns.isEmpty
                              ? Center(child: Text("No campaigns found"))
                              : ListView.builder(
                            controller: _scrollController,
                            shrinkWrap: true,
                            itemCount: state.campaigns.length,
                            itemBuilder: (context, index) {
                              final campaign = state.campaigns[index];
                              return Card(
                                child: ListTile(
                                  title: Text(campaign.name),
                                  subtitle: Text(campaign.description),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('👍 ${campaign.votes.upvotes}'),
                                      Text('👎 ${campaign.votes.downvotes}'),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )
                          : state is HomeErrorState
                          ? Center(child: Text(state.errorMessage))
                          : Center(child: Text("No campaigns found")),
                    ),
                  ),

                  /*Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: padding10,
                        vertical: padding10,
                      ),
                      child:
                          state is HomeLoadingState
                              ? Center(child: CircularProgressIndicator())
                              : state is HomeDataLoadedState
                              ? state.campaigns.isEmpty
                                  ? Center(child: Text("No campaigns found"))
                                  : ListView.builder(
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
                                              Text(
                                                '👍 ${campaign.votes.upvotes}',
                                              ),
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
                  ),*/
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
