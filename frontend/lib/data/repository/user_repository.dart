import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:medecine_app/data/models/user_model.dart';
import 'package:medecine_app/data/models/disease_history_model.dart';
import 'package:medecine_app/data/models/doctor_model.dart';
import 'package:medecine_app/data/models/patient_model.dart';
import 'package:medecine_app/data/provider/api.dart';

class UserRepository extends GetxService {
  ApiClient _apiClient = Get.find<ApiClient>();
  Rx userModel;
  RxList diseaseHistories = [].obs;
  Rx patientModel;

  Future register(String email, String password1, String password2, String name,
                  String surname, String patronymic, String phone_number, String gender,
                  String profession, String address, DateTime birthday) async {
    Response response = await _apiClient.register(
                  email, password1, password2, name,
                  surname, patronymic, phone_number,
                  gender, profession, address, birthday);
    if (response != null) {
      this.patientModel = PatientModel.fromJson(response.data).obs;
      return patientModel;
    }
  }

  Future login(String email, String password) async {
    Response response = await _apiClient.login(email, password);
    if (response != null) {
      Map data = response.data;
      final String role = data['role'];
      final userID = data['user_id'];

      var model;
      if (role == "patient") {
        response = await _apiClient.getPatientByID(userID);
        data = response.data['data'];
        print(data);
        model = PatientModel.fromJson(data).obs;
      } else if (role == 'doctor') {
        response = await _apiClient.getDoctorByID(userID);
        data = response.data['data'];
        print(data);
        model = DoctorModel.fromJson(data).obs;
      }
      if (model != null) {
        this.userModel = model;
        return userModel;
      }
    }
  }

  Future uploadHistoryFile(filePath, historyId) async {
    return await _apiClient.uploadHistoryFile(filePath, historyId);
  }

  Future downloadHistoryFile(String historyId) async {
    Response response = await _apiClient.downloadHistoryFile(historyId);
    print(response.data);
    return response;
  }

  Future getDiseaseHistoryByUserId(String userId) async {
    Response response = await _apiClient.getDiseaseHistoriesById(userId);
    if (response != null) {
      print(response.data);
      Map data = response.data;
      print(data);
      if (data['result'] == true) {
        response = await _apiClient.getPatientByID(userId);
        List historiesData = data['data'];
        print(data);
        diseaseHistories.clear();
        for (Map history in historiesData) {
          diseaseHistories.add(DiseaseHistoryModel.fromJson(history).obs);
        }
        return diseaseHistories;
      }
    }
  }

  Future protected() async {
    Response response = await _apiClient.protected();
    print(response.data);
  }
}
