// To parse this JSON data, do
//
//     final campaigns = campaignsFromJson(jsonString);

import 'dart:convert';

Campaigns campaignsFromJson(String str) => Campaigns.fromJson(json.decode(str));

String campaignsToJson(Campaigns data) => json.encode(data.toJson());

class Campaigns {
  List<Data> data;
  int total;
  int page;
  int pageSize;
  int totalPages;

  Campaigns({
    required this.data,
    required this.total,
    required this.page,
    required this.pageSize,
    required this.totalPages,
  });

  factory Campaigns.fromJson(Map<String, dynamic> json) => Campaigns(
    data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    total: json["total"],
    page: json["page"],
    pageSize: json["pageSize"],
    totalPages: json["totalPages"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "total": total,
    "page": page,
    "pageSize": pageSize,
    "totalPages": totalPages,
  };
}

class Data {
  int campaignId;
  String name;
  String description;
  String usersId;
  DateTime startDate;
  DateTime endDate;
  DateTime createdAt;
  DateTime updatedAt;
  Votes votes;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
