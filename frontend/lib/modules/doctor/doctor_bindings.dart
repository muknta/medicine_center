import 'package:get/get.dart';

import 'doctor_controller.dart';

class DoctorsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DoctorController());
  }
}
