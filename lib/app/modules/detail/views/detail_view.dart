import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.detail.value.episode),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/backgroud_reload.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Obx(
              () => Column(
                children: [
                  customListTile(
                    title: 'Nome:',
                    description: controller.detail.value.name,
                  ),
                  customListTile(
                      title: 'Lançamento:',
                      description: controller.detail.value.airDate),
                  customListTile(
                      title: 'Episódio:',
                      description: controller.detail.value.episode),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //customização do ListTile
  Widget customListTile({
    required String title,
    required String description,
  }) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 2),
            ),
          ]),
      child: ListTile(
        title: Text(
          title,
          style: Get.textTheme.subtitle1,
        ),
        subtitle: Text(
          description,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}
