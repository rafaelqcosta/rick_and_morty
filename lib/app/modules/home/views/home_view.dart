import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty/app/model/result_model.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: controller.getEpisodeList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return loading();
          } else if (controller.errorMessage.value != '') {
            return reload();
          }

          final listEpisodes = snapshot.data as List<List<EpisodeModel>>;
          return DefaultTabController(
            initialIndex: 0,
            length: listEpisodes.length,
            child: Scaffold(
              appBar: AppBar(
                title: Text('Rick and Morty'),
                centerTitle: true,
                bottom: TabBar(
                  tabs: listEpisodes
                      .map((List<EpisodeModel> episode) =>
                          Tab(text: episode.first.episode.substring(0, 3)))
                      .toList(),
                ),
              ),
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/backgroud1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: TabBarView(
                  children: episodeListView(listEpisodes),
                ),
              ),
            ),
          );
        });
  }

  //Lista dos epsódios
  List<Widget> episodeListView(List<List<EpisodeModel>> listEpisodes) {
    List<Widget> listView = [];
    listEpisodes.forEach((episodes) {
      listView.add(ListView.builder(
          itemCount: episodes.length,
          itemBuilder: (_, index) {
            return Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withOpacity(0.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 2),
                    ),
                  ]),
              child: ListTile(
                onTap: () {
                  controller.getDetail(episodes[index].id);
                },
                title: Text(
                  episodes[index].name,
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  '${episodes[index].episode} - ${episodes[index].airDate}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }));
    });

    return listView;
  }

  //Apresenta uma tela de Loading
  Widget loading() {
    return Scaffold(
      body: Center(
        child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                image: AssetImage('assets/img/backgroud_reload.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: CircularProgressIndicator()),
      ),
    );
  }

  //Apresenta uma resposta amigável em caso de erro
  Widget reload() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rick and Morty'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Ops! Parece que algo deu errado. ${controller.errorMessage}'),
          ElevatedButton(
            onPressed: controller.getEpisodeList,
            child: Text('Buscar Novamente'),
          )
        ],
      ),
    );
  }
}
