import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:medecine_app/data/models/patient_model.dart';
import 'package:medecine_app/data/repository/user_repository.dart';
import 'package:medecine_app/data/utils/exceptions.dart';

class RegisterController extends GetxController {
  UserRepository _userRepository = Get.find<UserRepository>();

  final String title = 'Register';
  UserModel get userModel => _userRepository.userModel;

  @override
  void onInit() {
    super.onInit();
  }

  Future<UserModel> register(String email, String password1, String password2, String name,
                  String surname, String role, String phone_number,
                  String patronymic, String gender, DateTime birthday) async {
    try {
      UserModel userModel = await _userRepository.register(email, password);
      if (userModel != null) {
        return userModel;
      } else {
        Get.snackbar(
            'Invalid credentials', 'Please enter correct data');
      }
    } on NotAuthorizedException catch (e) {
      print(e.message);
      Get.snackbar('Session expired', 'Login to your account');
    } catch (e) {
      if (e is DioError) {
        Get.snackbar('Error', 'Connection troubles...');
        print('Dio Error: ${e.message}');
      }
      // print(e.message);
    }
  }
}
