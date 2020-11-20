import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:medecine_app/data/models/doctor_model.dart';
import 'package:medecine_app/data/provider/api.dart';

class DoctorsRepository extends GetxService {
  ApiClient _apiClient = Get.find<ApiClient>();
  RxList doctors;

  Future getAllDoctors() async {
    Response response = await _apiClient.getAllDoctors();
    if (response != null) {
      print(response);
      // this.userModel = UserModel.fromJson(response.data);
      // return userModel;
    }
  }

  getDoctorById(String id) async {
    Response response = await _apiClient.getDoctorByID(id);
    print(response.data);
    if (response != null) {
      Map data = response.data;
      print('response data: $data');
      if (data["result"] == true) {
        final Map doctor = data['data'];
        return DoctorModel.fromJson(doctor).obs;
      }
    }
  }
}
