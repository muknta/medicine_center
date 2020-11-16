import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:medecine_app/data/models/user_model.dart';
import 'package:medecine_app/data/models/patient_model.dart';
import 'package:medecine_app/data/provider/api.dart';

class UserRepository extends GetxService {
  ApiClient _apiClient = Get.find<ApiClient>();
  UserModel userModel;
  PatientModel patientModel;

  Future register(String email, String password1, String password2, String name,
                  String surname, String patronymic, String phone_number,
                  String gender) async { //, DateTime birthday
    Response response = await _apiClient.register(
                  email, password1, password2, name,
                  surname, patronymic, phone_number,
                  gender); //, birthday
    if (response != null) {
      this.patientModel = PatientModel.fromJson(response.data);
      return patientModel;
    }
  }

  Future login(String email, String password) async {
    Response response = await _apiClient.login(email, password);
    if (response != null) {
      this.userModel = UserModel.fromJson(response.data);
      return userModel;
    }
  }

  Future protected() async {
    Response response = await _apiClient.protected();
    print(response.data);
  }
}
