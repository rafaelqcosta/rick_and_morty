import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty/app/modules/home/controllers/home_controller.dart';

main() {
  late HomeController homeController;

  setUp(() {
    homeController = Get.put(HomeController());
  });

  test('Retorna uma lista Episódios separadas por Temporada', () async {
    final list = await homeController.getEpisodeList();

    expect(list.isNotEmpty, true);
    expect(list.length, greaterThan(0));
    expect(list.first.isBlank, false);
  });
}
