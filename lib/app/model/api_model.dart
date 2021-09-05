import 'package:rick_and_morty/app/model/info_model.dart';
import 'package:rick_and_morty/app/model/result_model.dart';

class ApiModel {
  ApiModel({
    required this.info,
    required this.results,
  });

  InfoModel info;
  List<EpisodeModel> results;

  factory ApiModel.fromMap(Map<String, dynamic> json) => ApiModel(
        info: InfoModel.fromMap(json["info"]),
        results: List<EpisodeModel>.from(
            json["results"].map((x) => EpisodeModel.fromMap(x))),
      );
}
