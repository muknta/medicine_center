import 'package:get/get.dart';
import 'patient_controller.dart';

class PatientBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PatientController());
  }
}
