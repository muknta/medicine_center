import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medecine_app/modules/hospitals/hospital_controller.dart';
import 'package:medecine_app/routes.dart';
import 'package:medecine_app/ui/appbar/base_appbar.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class HospitalsScreen extends GetView<HospitalsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(),
      body: Column(children: [
        Text(
          "Hospitals",
          style: TextStyle(fontSize: 32),
        ),
        Obx(() => Expanded(
            child: ListView.builder(
              itemCount: controller.hospitals.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: new InkWell(
                        onTap: () => getHospitalDoctors(
                            context, controller.hospitals[index]?.id),

                        //  Get.toNamed(Routes.Doctor),
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
                              ])
                            )
                          )
                        ]))));
              })))
      ]));
  }

  getHospitalDoctors(context, String hospitalId) {
    Get.dialog(Container(
      child: FutureBuilder(
          future: controller.getHospitalDoctors(hospitalId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Hero(
                  tag: 'photo',
                  child: Scaffold(
                    body: ListView.builder(
                      itemCount: snapshot.data.length,
                      padding: EdgeInsets.all(20),
                      itemBuilder: (context, index) {
                        print(
                            'snapshot.data[index] ${snapshot.data[index]}');
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: InkWell(
                            onTap: () => Get.offAndToNamed(
                                Routes.Doctor.replaceFirst(':userId',
                                    snapshot.data[index].id)),
                            borderRadius: BorderRadius.circular(20),
                            child: Column(children: [
                              Text(snapshot.data[index].name +
                                  ' ' +
                                  snapshot.data[index].surname),
                              Text(snapshot.data[index].positing ??
                                  ''),
                              SmoothStarRating(
                                  allowHalfRating: false,
                                  starCount: 5,
                                  rating: num.tryParse(
                                      snapshot.data[index].rating),
                                  size: 40.0,
                                  isReadOnly: true,
                                  color: Colors.green,
                                  borderColor: Colors.green,
                                  spacing: 0.0),
                              //  onTap: ()=>Get.to(Routes.),
                            ]),
                          ));
                        })));
              }
            }
            return Container();
          })));
  }
}
