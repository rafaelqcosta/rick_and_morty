import 'dart:convert';

import 'package:dio/dio.dart' as dio_;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/app/model/api_model.dart';
import 'package:rick_and_morty/app/model/detail_model.dart';

class EpisodesRepository extends GetxService {
  dio_.Dio dio = dio_.Dio();
  final url = 'https://rickandmortyapi.com/api/episode';
  http.Client client = http.Client();

  EpisodesRepository();

  Future<ApiModel> fetchLists(String url) async {
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      //recebe a lista da api
      return ApiModel.fromMap((jsonDecode(response.body)));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<DetailModel> getEpisodeById(int id) async {
    final response = await client.get(Uri.parse(url + '/$id'));

    if (response.statusCode == 200) {
      //recebe a lista da api
      return DetailModel.fromMap((jsonDecode(response.body)));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
