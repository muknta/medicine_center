import 'package:get/get.dart';
import 'package:medecine_app/data/repository/hospitals_repository.dart';

class HospitalsController extends GetxController {
  HospitalsRepository hospitalsRepository = Get.find<HospitalsRepository>();
  RxList get hospitals => hospitalsRepository.hospitals;

  @override
  void onInit() async {
    super.onInit();
    await hospitalsRepository.getHospitals();
  }

  Future getHospitalDoctors(String hospitalId) async {
    return await hospitalsRepository.getHospitalDoctors(hospitalId);
  }
}
