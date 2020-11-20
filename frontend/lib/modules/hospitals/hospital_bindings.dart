import 'package:get/get.dart';

import 'hospital_controller.dart';

class HospitalsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HospitalsController());
  }
}
