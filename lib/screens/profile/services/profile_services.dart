import 'package:campaign_application/screens/profile/widget/update_campaign_dialog.dart';
import 'package:flutter/material.dart';
import 'package:campaign_application/models/campaigns_by_userid_model.dart';
import 'package:campaign_application/screens/profile/bloc/profile_bloc.dart';


void showCampaignBottomSheet({
  required BuildContext context,
  required UserCampaign campaign,
  required ProfileBloc profileBloc,
}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit, color: Colors.blue),
            title: const Text('Edit Campaign'),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (_) => UpdateCampaignDialog(
                  bloc: profileBloc,
                  userId: campaign.usersId,
                  campaignId: campaign.campaignId,
                  initialName: campaign.name,
                  initialDescription: campaign.description,
                  initialStartDate: campaign.startDate.toString().split(' ')[0],
                  initialEndDate: campaign.endDate.toString().split(' ')[0],
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text('Delete Campaign'),
            onTap: () {
              Navigator.pop(context);
              profileBloc.add(
                DeleteCampaignEvent(
                  campaign.campaignId.toString(),
                  campaign.usersId,
                ),
              );
            },
          ),
        ],
      );
    },
  );
}

Widget userCampaignCard(BuildContext context, UserCampaign campaign, ProfileBloc profileBloc) {
  return Card(
    elevation: 4,
    margin: const EdgeInsets.symmetric(
      vertical: 8,
      horizontal: 12,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            campaign.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            campaign.description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Start: ${campaign.startDate.toLocal().toString().split(' ')[0]}",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Text(
                "End: ${campaign.endDate.toLocal().toString().split(' ')[0]}",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Divider(height: 20),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.thumb_up,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${campaign.votes.upvotes}',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.thumb_down,
                    color: Colors.red,
                    size: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${campaign.votes.downvotes}',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}