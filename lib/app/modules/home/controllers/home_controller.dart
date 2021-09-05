import 'package:get/get.dart';
import 'package:rick_and_morty/app/model/result_model.dart';
import 'package:rick_and_morty/app/repositories/episode_repository.dart';
import 'package:rick_and_morty/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final EpisodesRepository episodesRepository = Get.put(EpisodesRepository());
  final url = 'https://rickandmortyapi.com/api/episode';
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  //faz a requisição da lista para o repositório
  Future<List<List<EpisodeModel>>> getEpisodeList() async {
    List<EpisodeModel> list = [];
    errorMessage.value = '';
    try {
      String urlNext = url;
      bool next = true;
      while (next) {
        final apiModel = await episodesRepository.fetchLists(urlNext);

        //adiciona na lista geral dos episódios
        apiModel.results.forEach((element) {
          list.add(element);
        });

        //verifica se existe uma próxima url com novos episódios
        //caso positivo, altera a ulr de requisição e inicia o loop
        if (apiModel.info.next != null) {
          urlNext = apiModel.info.next!;
        } else {
          next = false;
        }
      }

      return splitSeasons(list);
    } catch (e) {
      errorMessage.value = e.toString();
    }
    return [];
  }

  //faz a requisição de um episódio para o repositório
  Future getDetail(int id) async {
    try {
      final detail = await episodesRepository.getEpisodeById(id);
      Get.toNamed(Routes.DETAIL, arguments: detail);
    } catch (e) {
      Get.rawSnackbar(
        title: 'Ops! Parece que algo deu errado.',
        message: 'Verifique sua conexão e tente novamente.',
        duration: Duration(seconds: 5),
      );
    }
  }

  List<List<EpisodeModel>> splitSeasons(List<EpisodeModel> episodes) {
    List<List<EpisodeModel>> listSeasons = [];
    bool next = true;
    int count = 1;
    // percorre a lista de, verifica qual é o numero da temporada e incluí ela na Lista de temporadas
    // sendo que caso o epsódio seja de uma temporada que já existe na lista, esse
    // episodio é adicionado na mesma temporada
    while (next) {
      // parar quando não existir mais igualdade
      final newSeason = episodes
          .where(
              (element) => int.parse(element.episode.substring(1, 3)) == count)
          .toList();
      if (newSeason.isNotEmpty) {
        listSeasons.add(newSeason);
        count++;
      } else
        next = false;
    }
    return listSeasons;
  }
}
