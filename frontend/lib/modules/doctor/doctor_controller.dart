import 'package:get/get.dart';
import 'package:medecine_app/data/models/doctor_model.dart';
import 'package:medecine_app/data/repository/doctors_repository.dart';

class DoctorController extends GetxController {
  DoctorsRepository doctorsRepository = Get.find<DoctorsRepository>();
  Rx<DoctorModel> userData = DoctorModel().obs;

  @override
  void onInit() async {
    super.onInit();
    await getDoctorById(Get.parameters['userId']);
  }

  Future getDoctorById(String userId) async {
    Rx<DoctorModel> res = await doctorsRepository.getDoctorById(userId);
    if (res != null) {
      userData.value = res.value;
      print(userData.value.email);
      userData.refresh();
      return userData;
    }
  }
}
