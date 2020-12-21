import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:medecine_app/data/models/doctor_model.dart';
import 'package:medecine_app/data/models/schedule_model.dart';
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

  getScheduleByDoctorId(String doctorId) async {
    Response response = await _apiClient.getScheduleByDoctorId(doctorId);
    print(response.data);

    List doctorSchedules = [];
    if (response != null) {
      print('1');
      Map data = response.data;
      if (data["result"] == true) {
        print('2');

        final List scheduleAllData = data['data'];
        print('3: $scheduleAllData length: ${scheduleAllData.length}');

        scheduleAllData.forEach((element) {
          print('element: $element, elementType: ${element.runtimeType}');

          final schedule = ScheduleModel.fromJson(element);
          print('schedule: $schedule');
          doctorSchedules.add(schedule);
        });
        print('4: $doctorSchedules');
      }
    }
    return doctorSchedules;
  }
}
