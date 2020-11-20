import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:medecine_app/data/models/doctor_model.dart';
import 'package:medecine_app/data/models/hospital_model.dart';
import 'package:medecine_app/data/provider/api.dart';

class HospitalsRepository extends GetxService {
  ApiClient _apiClient = Get.find<ApiClient>();
  RxList hospitals = [].obs;

  Future getHospitals() async {
    Response response = await _apiClient.getAllHospitals();
    print(response.data);
    if (response != null) {
      Map data = response.data;
      if (data != null) {
        if (data["result"]) {
          List hospitalsData = data["data"];
          hospitals.clear();
          for (var hospital in hospitalsData) {
            hospitals.add(HospitalModel.fromJson(hospital));
          }
          return hospitals;
        }
      }
    }
  }

  Future getHospitalDoctors(hospitalID) async {
    Response response = await _apiClient.getHospitalDoctors(hospitalID);
    List hospitalDoctors = [];
    print(response);
    if (response != null) {
      Map data = response.data;
      print('response data: $data');
      if (data["result"] == true) {
        final List allDoctorsData = data['data'];
        for (var doctor in allDoctorsData) {
          hospitalDoctors.add(DoctorModel.fromJson(doctor));
        }
      }
    }
    print('hospitalDoctors: $hospitalDoctors');
    return hospitalDoctors;
  }
}
