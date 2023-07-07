// To parse this JSON data, do
//
//     final valoEvent = valoEventFromJson(jsonString);

import 'dart:convert';

class ValoEvent {
  int status;
  List<Datum> data;

  ValoEvent({
    required this.status,
    required this.data,
  });

  factory ValoEvent.fromRawJson(String str) =>
      ValoEvent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ValoEvent.fromJson(Map<String, dynamic> json) => ValoEvent(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String uuid;
  String displayName;
  String shortDisplayName;
  DateTime startTime;
  DateTime endTime;
  String assetPath;

  Datum({
    required this.uuid,
    required this.displayName,
    required this.shortDisplayName,
    required this.startTime,
    required this.endTime,
    required this.assetPath,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        uuid: json["uuid"],
        displayName: json["displayName"],
        shortDisplayName: json["shortDisplayName"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        assetPath: json["assetPath"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "displayName": displayName,
        "shortDisplayName": shortDisplayName,
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
        "assetPath": assetPath,
      };
}
