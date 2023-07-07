// ignore_for_file: prefer_final_fields, unused_field

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:strongwave/core/model/valorant/valorant_events_model.dart';

class ValorantEventApi {
  Dio _dio = Dio();
  final String _url = "https://valorant-api.com/v1/events";
  List<Datum> maList = [];

  Future<List<Datum>?> fetchEvent() async {
    try {
      final response = await _dio.get(_url);
      if (response.statusCode == 200) {
        final jsonData = response.data as Map<String, dynamic>;
        final jsonList = jsonData['data'] as List<dynamic>;
        maList = jsonList.map((json) => Datum.fromJson(json)).toList();
        return maList;
      }
    } catch (err) {
      debugPrint("HATA: $err");
    }
    return null;
  }
}
