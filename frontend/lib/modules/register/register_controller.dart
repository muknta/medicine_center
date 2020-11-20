import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:medecine_app/data/models/patient_model.dart';
import 'package:medecine_app/data/repository/user_repository.dart';
import 'package:medecine_app/data/utils/exceptions.dart';

class RegisterController extends GetxController {
  UserRepository _userRepository = Get.find<UserRepository>();

  final String title = 'Register';
  Rx get patientModel => _userRepository.patientModel;

  @override
  void onInit() {
    super.onInit();
  }

  Future register(String email, String password1, String password2, String name,
                  String surname, String patronymic, String phone_number, String gender,
                  String profession, String address, DateTime birthday) async {
    try {
      print('DateTime birthday: ${birthday}');
      PatientModel patientModel = await _userRepository.register(
                  email, password1, password2, name,
                  surname, patronymic, phone_number,
                  gender, profession, address, birthday);
      print('PatientModel patientModel - $patientModel');
      if (patientModel != null) {
        return patientModel;
      } else {
        Get.snackbar(
            'Invalid credentials', 'Please enter correct data');
      }
    } on NotAuthorizedException catch (e) {
      print(e.message);
      Get.snackbar('Session expired', 'Login to your account');
    } on DioError catch (e) {
      Get.snackbar('Error', 'Connection troubles...');
      print('Dio Error: ${e.message}');
    } catch (e) {
      print(e);
    }
  }
}
