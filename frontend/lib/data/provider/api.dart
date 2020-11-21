import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import 'package:medecine_app/data/utils/exceptions.dart';

// const String baseUrl = 'http://46.98.246.226/';
// const String baseUrl = 'http://localhost:8000/';
const String baseUrl = 'http://34.89.129.235:80/';
// const String baseUrl = 'http://192.168.1.121:8000/';

enum http_method { GET, POST }

class ApiClient {
  static BaseOptions _baseOptions = BaseOptions(
      baseUrl: baseUrl,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
      connectTimeout: 4000,
      validateStatus: (status) {
        return status < 500;
      });
  final Dio _dio = Dio(_baseOptions);

  String _accessToken;
  String _refreshToken;
  // TODO: get access token from some store
  get accessToken => _accessToken;
  get refreshToken => _refreshToken;

  get authHeaderOptions => Options(headers: <String, String>{
        'Authorization': 'Authorization-Token $accessToken'
      });
  get refreshHeaderOptions => Options(headers: <String, String>{
        'Authorization': 'Authorization-Token $refreshToken'
      });

  Future register(String email, String password1, String password2, String name,
                  String surname, String patronymic, String phone_number, String gender,
                  String profession, String address, DateTime birthday) async {
    String birthdayStr = DateFormat("yyyy-MM-dd").format(birthday);
    // print('birthday and String: $birthday $birthdayStr');

    Response response = await _dio.post(
      '/register',
      data: {
        'email': email, 'password1': password1, 'password2': password2,
        'name': name, 'surname': surname, 'patronymic': patronymic, 
        'phone_number': phone_number, 'gender': gender, 'profession': profession,
        'address': address, 'birthday': birthdayStr,
      },
    );
    print('api.dart: response - ${response}');
    if (response.statusCode == 200) {
      if (response.data["result"] == true) {
        return response;
      }
    }
  }

  Future login(String email, String password) async {
    Response response = await _dio.post(
      '/login',
      data: {'email': email, 'password': password},
    );
    if (response.statusCode == 200) {
      print(response.data);
      if (response.data["result"] == true) {
        final access = response.data['access_token'];
        final refresh = response.data['refresh_token'];
        if (access != null && refresh != null) {
          this._accessToken = access;
          this._refreshToken = refresh;
          return response;
        }
      }
    }
  }

  Future uploadHistoryFile(filePath, historyId) async {
    FormData formdata = FormData.fromMap({
      "file": await MultipartFile.fromFile(filePath, filename: '$historyId'),
    });
    Response response =
        await _dio.post("history/uploadfile/$historyId", data: formdata);
    print(response);
    print(response.data);
    return response;
  }

  Future _authenticatedRequest(path,
      {method = http_method.POST, data = const {}}) async {
    Function request;
    if (method == http_method.GET) {
      request = () => _dio.get(path, options: authHeaderOptions);
    } else if (method == http_method.POST) {
      request = () => _dio.post(path, data: data, options: authHeaderOptions);
    }
    Response response = await request();
    if (response.statusCode == 200) {
      return response;
    }
    // If access token is not fresh
    else if (response.statusCode == 401 || response.statusCode == 422) {
      // Trying to refresh tokens and send request again
      Response response = await refreshTokens();
      if (response.statusCode == 200) {
        return await request();
      } else {
        print('GO TO LOGIN');
        throw NotAuthorizedException();
      }
    }
  }

  Future protected() async {
    return await _authenticatedRequest('/protected',
        data: {}, method: http_method.GET);
  }

  Future refreshTokens() async {
    Response response =
        await _dio.get('/auth/refresh', options: refreshHeaderOptions);
    if (response.statusCode == 200) {
      if (response.data["result"] == true) {
        final access = response.data['access_token'];
        final refresh = response.data['refresh_token'];
        if (access != null && refresh != null) {
          this._accessToken = access;
          this._refreshToken = refresh;
        }
      }
    }
    return response;
  }

  getAllHospitals() async {
    return await _authenticatedRequest('/hospitals', method: http_method.GET);
  }

  getHospitalDoctors(hospitalID) async {
    return await _authenticatedRequest('/hospital/$hospitalID/doctors/',
        method: http_method.GET);
  }

  getAllDoctors() {}

  getDoctorProfile() {}

  getPatientByID(userID) async {
    print('get patient $userID');
    return await _authenticatedRequest('/profile/patient/$userID',
        method: http_method.GET);
  }

  getDoctorByID(userID) async {
    print('get doctor $userID');
    return await _authenticatedRequest('/profile/doctor/$userID',
        method: http_method.GET);
  }

  getDiseaseHistoriesById(String userId) async {
    return await _authenticatedRequest('history/$userId',
        method: http_method.GET);
  }

  downloadHistoryFile(String historyId) async {
    return await _authenticatedRequest('history/download/$historyId',
        method: http_method.GET);
  }
}

main() async {
  final apiClient = ApiClient();
  Response response = await apiClient.login('test', 'test');
  print(response.data);
  response = await apiClient.protected();
  print(response?.data);
  Timer(Duration(seconds: 40), () async => print(await apiClient.protected()));
  Timer(Duration(seconds: 61 + 40),
      () async => print(await apiClient.protected()));
}
