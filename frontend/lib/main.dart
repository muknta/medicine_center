import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medecine_app/data/repository/user_repository.dart';
import 'package:medecine_app/modules/login/login_binding.dart';
import 'package:medecine_app/modules/login/login_screen.dart';
import 'package:medecine_app/modules/register/register_binding.dart';
import 'package:medecine_app/modules/register/register_screen.dart';
import 'package:medecine_app/routes.dart';

import 'data/provider/api.dart';

void main() {
  initDependencies();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.Register,
      // theme: appThemeData,
      defaultTransition: Transition.fade,
      getPages: [
        GetPage(
          name: Routes.Login,
          page: () => LoginScreen(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: Routes.Register,
          page: () => RegisterScreen(),
          binding: RegisterBinding(),
        ),
      ]
    )
  );
}

initDependencies(){
  Get.put(ApiClient());
  Get.put(UserRepository());
}
        
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medecine app')
      ),
      body: Column(
        children: <Widget>[
          Text('Medecine application')
        ]
      )
    );
  }
}

