import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty/app/repositories/episode_repository.dart';

class ClientMock extends Mock implements http.Client {}

main() async {
  final url = 'https://rickandmortyapi.com/api/episode';
  late EpisodesRepository repository;

  setUp(() {
    repository = Get.put(EpisodesRepository());
  });

  test('Retorna um ApiModel', () async {
    final client = http.Client();
    final request = await client.get(Uri.parse(url));
    expect(request.statusCode, HttpStatus.ok);

    final apiModel = await repository.fetchLists(url);

    expect(apiModel.info.pages, isA<int>());
  });

  test('Retorna um Episódio', () async {
    final apiModel = await repository.fetchLists(url);
    final id = apiModel.results.first.id;
    final detail = await repository.getEpisodeById(id);
    expect(detail.name.isNotEmpty, true);
    expect(detail.airDate.isNotEmpty, true);
    expect(detail.episode.isNotEmpty, true);
    expect(detail.id, equals(id));
  });
}
