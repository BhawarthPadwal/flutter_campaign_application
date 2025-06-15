// To parse this JSON data, do
//
//     final userCampaign = userCampaignFromJson(jsonString);

import 'dart:convert';

List<UserCampaign> userCampaignFromJson(String str) => List<UserCampaign>.from(
  json.decode(str).map((x) => UserCampaign.fromJson(x)),
);

String userCampaignToJson(List<UserCampaign> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserCampaign {
  int campaignId;
  String name;
  String description;
  String usersId;
  DateTime startDate;
  DateTime endDate;
  DateTime createdAt;
  DateTime updatedAt;
  Votes votes;

  UserCampaign({
    required this.campaignId,
    required this.name,
    required this.description,
    required this.usersId,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
    required this.votes,
  });

  factory UserCampaign.fromJson(Map<String, dynamic> json) => UserCampaign(
    campaignId: json["campaignId"],
    name: json["name"],
    description: json["description"],
    usersId: json["users_id"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    votes: Votes.fromJson(json["votes"]),
  );

  Map<String, dynamic> toJson() => {
    "campaignId": campaignId,
    "name": name,
    "description": description,
    "users_id": usersId,
    "startDate": startDate.toIso8601String(),
    "endDate": endDate.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "votes": votes.toJson(),
  };
}

class Votes {
  int upvotes;
  int downvotes;
  int total;

  Votes({required this.upvotes, required this.downvotes, required this.total});

  factory Votes.fromJson(Map<String, dynamic> json) => Votes(
    upvotes: json["upvotes"],
    downvotes: json["downvotes"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "upvotes": upvotes,
    "downvotes": downvotes,
    "total": total,
  };
}
