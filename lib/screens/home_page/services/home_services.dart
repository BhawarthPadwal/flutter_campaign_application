import 'package:campaign_application/models/campaigns_model.dart';
import 'package:campaign_application/screens/home_page/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

Widget campaignCard(BuildContext context, Data campaign, HomeBloc homeBloc) {
  return Card(
    elevation: 4,
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            campaign.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            campaign.description,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Start: ${campaign.startDate.toLocal().toString().split(' ')[0]}",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                "End: ${campaign.endDate.toLocal().toString().split(' ')[0]}",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: () {
                    homeBloc.add(
                      VoteCampaignEvent(
                        FirebaseAuth.instance.currentUser!.uid,
                        campaign.campaignId.toString(),
                        true,
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  icon: const Icon(Icons.thumb_up, color: Colors.green),
                  label: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${campaign.votes.upvotes}',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: () {
                    homeBloc.add(
                      VoteCampaignEvent(
                        FirebaseAuth.instance.currentUser!.uid,
                        campaign.campaignId.toString(),
                        false,
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  icon: const Icon(Icons.thumb_down, color: Colors.red),
                  label: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${campaign.votes.downvotes}',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}