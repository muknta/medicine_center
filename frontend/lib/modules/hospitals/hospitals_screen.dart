import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medecine_app/modules/hospitals/hospital_controller.dart';
import 'package:medecine_app/routes.dart';
import 'package:medecine_app/ui/appbar/base_appbar.dart';

class HospitalsScreen extends GetView<HospitalsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(),
        body: Obx(() => ListView.builder(
            itemCount: controller.hospitals.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.all(10),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: new InkWell(
                          onTap: () => Get.toNamed(Routes.Doctor),
                          child: Row(children: [
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Image.asset(
                                  'assets/hospital3.jpg',
                                  height: 220,
                                  width: 150,
                                )),
                            Expanded(
                                child: Container(
                                    child: Column(children: [
                              Text(
                                controller.hospitals[index]?.name,
                                overflow: TextOverflow.visible,
                              ),
                              Text(
                                controller.hospitals[index]?.address,
                                overflow: TextOverflow.visible,
                              )
                            ])))
                          ]))));
            })));
  }
}
