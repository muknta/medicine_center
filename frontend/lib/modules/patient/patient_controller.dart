// import 'package:dio/dio.dart';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:medecine_app/data/repository/user_repository.dart';
import 'package:file_picker/file_picker.dart';

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

  uploadFile(String historyId) async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );

    if (result != null) {
      File file = File(result.files.single.path);
      print(file.path);

      Response response =
          await _userRepository.uploadHistoryFile(file.path, historyId);
      if (response.statusCode == 200) {
        if (response.data['result'] == true) {
          Get.snackbar('Success', 'File downloaded');
        } else {
          Get.snackbar('Fail', response.data['description']);
        }
      }
    } else {
      // User canceled the picker
    }
  }

  downloadHistoryFile(String historyId)async{
    await _userRepository.downloadHistoryFile(historyId);

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
