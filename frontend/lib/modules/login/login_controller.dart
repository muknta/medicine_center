import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:medecine_app/data/models/user_model.dart';
import 'package:medecine_app/data/repository/user_repository.dart';
import 'package:medecine_app/data/utils/exceptions.dart';

class LoginController extends GetxController {
  UserRepository _userRepository = Get.find<UserRepository>();

  final String title = 'Login';
  Rx get userModel => _userRepository.userModel;

  @override
  void onInit() {
    super.onInit();
    // _userRepository.login('test', 'test');
  }

  Future login(String email, String password) async {
    try {
      var userModel = await _userRepository.login(email, password);
      if (userModel != null) {
        return userModel;
      } else {
        Get.snackbar(
            'Invalid credentials', 'Please enter correct email and password');
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
