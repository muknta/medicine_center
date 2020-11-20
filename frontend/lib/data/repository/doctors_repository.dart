import 'package:dio/dio.dart';
import 'package:get/get.dart';
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

  Future getAllHospitalDoctors(hospitalID) async {
    Response response = await _apiClient.getAllHospitalDoctors(hospitalID);
    if (response != null) {
      Map data = response.data;
      if(data["result"]==true){
        
      }
      // this.userModel = UserModel.fromJson(response.data);
      // return userModel;
    }
  }

  getDoctorById(String id) async {
    Response response = await _apiClient.protected();
    print(response.data);
  }
}
