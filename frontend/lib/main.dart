import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medecine_app/data/repository/hospitals_repository.dart';
import 'package:medecine_app/data/repository/user_repository.dart';
import 'package:medecine_app/modules/doctor/doctor_bindings.dart';
import 'package:medecine_app/modules/login/login_binding.dart';
import 'package:medecine_app/modules/login/login_screen.dart';
import 'package:medecine_app/modules/register/register_binding.dart';
import 'package:medecine_app/modules/register/register_screen.dart';
import 'package:medecine_app/routes.dart';

import 'data/provider/api.dart';
import 'data/repository/doctors_repository.dart';
import 'modules/doctor/doctor_screen.dart';
import 'modules/hospitals/hospital_bindings.dart';
import 'modules/hospitals/hospitals_screen.dart';
import 'modules/patient/patient_binding.dart';
import 'modules/patient/patient_screen.dart';

void main() {
  initDependencies();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.Login,
      // theme: appThemeData,
      defaultTransition: Transition.fade,
      getPages: [
        GetPage(
          name: Routes.Login,
          page: () => LoginScreen(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: Routes.Register,
          page: () => RegisterScreen(),
          binding: RegisterBinding(),
        ),
        GetPage(
            name: Routes.Patient,
            page: () => PatientScreen(),
            binding: PatientBinding()),
        GetPage(
          name: Routes.Doctor,
          page: () => DoctorScreen(),
          binding: DoctorsBinding(),
        ),
        GetPage(
            name: Routes.Hospitals,
            page: () => HospitalsScreen(),
            binding: HospitalsBinding()),
      ]
    )
  );
}

initDependencies() {
  Get.put(ApiClient());
  Get.put(UserRepository());
  Get.put(HospitalsRepository());
  Get.put(DoctorsRepository());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Medecine app')),
      body: Column(children: <Widget>[Text('Medecine application')])
    );
  }
}
