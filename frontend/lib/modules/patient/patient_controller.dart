// import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:medecine_app/data/repository/user_repository.dart';
// import 'package:medecine_app/data/utils/exceptions.dart';

class PatientController extends GetxController {
  UserRepository _userRepository = Get.find<UserRepository>();

  final String title = 'Login';
  get userModel => _userRepository.userModel;
  get diseaseHistories => _userRepository.diseaseHistories;

  @override
  void onInit() async {
    super.onInit();
    await _userRepository.getDiseaseHistoryByUserId(userModel?.value?.id);
    // _userRepository.login('test', 'test');
  }

  // Future<UserModel> login(String email, String password) async {
  //   try {
  //     UserModel userModel = await _userRepository.login(email, password);
  //     if (userModel != null) {
  //       return userModel;
  //     } else {
  //       Get.snackbar(
  //           'Invalid credentials', 'Please enter correct email and password');
  //     }
  //   } on NotAuthorizedException catch (e) {
  //     print(e.message);
  //     Get.snackbar('Session expired', 'Login to your account');
  //   } catch (e) {
  //     if (e is DioError) {
  //       Get.snackbar('Error', 'Connection troubles...');
  //       print('Dio Error: ${e.message}');
  //     }
  //     // print(e.message);
  //   }
  // }
}
