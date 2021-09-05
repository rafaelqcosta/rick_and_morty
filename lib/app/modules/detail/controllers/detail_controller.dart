import 'package:get/get.dart';
import 'package:rick_and_morty/app/model/detail_model.dart';
import 'package:rick_and_morty/app/repositories/episode_repository.dart';

class DetailController extends GetxController {
  EpisodesRepository episodesRepository = Get.find();
  late Rx<DetailModel> detail;
  final errorMessage = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    detail = (Get.arguments as DetailModel).obs;
  }
}
