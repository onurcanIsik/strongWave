// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_final_fields

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:strongwave/core/model/mmoModel/mmo_models.dart';

class MMOFetchApi {
  Dio _dio = Dio();
  final _url = "https://www.mmobomb.com/api1/latestnews";
  List<MmoGames> games = [];

  Future<List<MmoGames>?> fetchMMO() async {
    try {
      final response = await _dio.get(_url);

      if (response.statusCode == 200) {
        return games = (response.data as List)
            .map((json) => MmoGames.fromJson(json))
            .toList();
      }
    } catch (err) {
      debugPrint('BIG DATA ERROR $err');
    }

    return null;
  }
}
