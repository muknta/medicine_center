import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:medecine_app/ui/appbar/base_appbar.dart';
import 'package:medecine_app/ui/buttons/call_button.dart';
import 'package:medecine_app/ui/buttons/email_button.dart';
import 'package:medecine_app/ui/drawer/base_drawer.dart';

import 'patient_controller.dart';

class PatientScreen extends GetView<PatientController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(),
      endDrawer: BaseDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildDoctorHeadInfo(context),
              SizedBox(
                height: 26,
              ),
              Text(
                "About",
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Kiyv.",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              Obx(() {
                print(controller.userModel?.value);
                return Row(children: [
                  Text(
                    'Phone number: ${controller.userModel?.value?.phoneNumber ?? 'undefined'}',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  )
                ]);
              }),
              Obx(() {
                print(controller.userModel?.value);
                return Row(children: [
                  Text(
                    'Gender: ${controller.userModel?.value?.gender}',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  )
                ]);
              }),
              SizedBox(
                height: 24,
              ),
              buildAddress(context),
              buildActivityLayout(context),
              SizedBox(
                width: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildActivityLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Activity",
          style: TextStyle(
            color: Color(0xff242424),
            fontSize: 28,
          ),
        ),
        SizedBox(
          height: 22,
        ),

        Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Color(0xFF73AEF5),
            child: new InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => Get.dialog(Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Obx(
                        () => ListView.builder(
                            itemCount: controller.diseaseHistories.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading:
                                    Icon(FlutterIcons.thermometer_alert_mco),
                                title: Text('Diagnosis: ' +
                                    controller
                                        .diseaseHistories[index].value.title),
                                subtitle: Text('Status: ' +
                                    controller
                                        .diseaseHistories[index].value.status),
                              );
                            }),
                      )))),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(144, 202, 249, 1),
                            borderRadius: BorderRadius.circular(16)),
                        child: Icon(Icons.list_alt)),
                    SizedBox(
                      width: 16,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        "Disease History",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    )
                  ],
                ),
              ),
            )),
        // )
      ],
    );
  }

  Row buildAddress(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                // Image.asset("assets/mappin.png"),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(children: [
                      Text(
                        "Address",
                        style: TextStyle(
                            color: Colors.black87.withOpacity(0.7),
                            fontSize: 20),
                      ),
                      Icon(Icons.location_city),
                      SizedBox(
                        width: 15,
                      ),
                    ]),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width - 268,
                        child: Text(
                          "Bulvar Koltsova 19, Kyiv",
                          style: TextStyle(color: Colors.grey),
                        ))
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
//
          ],
        ),
        Image.asset(
          "assets/map.png",
          width: 180,
        )
      ],
    );
  }

  Row buildDoctorHeadInfo(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Icon(
          Icons.account_circle,
          size: 100,
        )),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Obx(() {
                  print(controller.userModel?.value);
                  return Text(
                    '${controller.userModel?.value?.name}',
                    style: TextStyle(fontSize: 24),
                  );
                }),
                Obx(() {
                  print(controller.userModel?.value?.surname);
                  return Text(
                    '${controller.userModel?.value?.name}',
                    style: TextStyle(fontSize: 24),
                  );
                }),
                Obx(() => Text(controller.userModel?.value?.email ?? '',
                    style: TextStyle(fontSize: 18, color: Colors.grey))),
                Obx(() => Text(controller.userModel?.value?.profession ?? '',
                    style: TextStyle(fontSize: 18, color: Colors.grey))),
                SizedBox(
                  height: 40,
                ),
                // SingleChildScrollView(
                //   scrollDirection: Axis.vertical,
                //   child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Obx(() =>
                        EmailButton(email: controller.userModel?.value?.email)),
                    Obx(() => CallButton(
                        phoneNumber: controller?.userModel?.value?.phoneNumber))
                  ],
                ),
                // )
              ],
            ),
          ),
        )
      ],
    );
  }
}
