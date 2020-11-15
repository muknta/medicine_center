import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_datetime_formfield/flutter_datetime_formfield.dart';
import 'package:medecine_app/data/models/patient_model.dart';

import 'register_controller.dart';


final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

class RegisterScreen extends GetView<RegisterController> {
  final emailController = TextEditingController();
  final password1Controller = TextEditingController();
  final password2Controller = TextEditingController();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final patronymicController = TextEditingController();
  final phoneController = TextEditingController();
  final genderController = TextEditingController();
  // final DateTime _now = new DateTime.now(); // need to define at initState()
  DateTime _birthday = new DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day
    );


  _getInputTypeByTitle(String title) {
    switch(title) {
      case 'Email': { TextInputType.emailAddress; }
      break;
      case 'Password1': { TextInputType.visiblePassword; }
      break;
      case 'Password2': { TextInputType.visiblePassword; }
      break;
      case 'Name': { TextInputType.name; }
      break;
      case 'Surname': { TextInputType.name; }
      break;
      case 'Patronymic': { TextInputType.name; }
      break;
      case 'Phone Number': { TextInputType.phone; }
      break;
      case 'Gender': { TextInputType.text; }
      break;
      default: { print('Invalid title of widget - ${title}'); }
      break;
    }
  }

  _getControllerByTitle(String title) {
    switch(title) {
      case 'Email': { emailController; }
      break;
      case 'Password1': { password1Controller; }
      break;
      case 'Password2': { password1Controller; }
      break;
      case 'Name': { nameController; }
      break;
      case 'Surname': { surnameController; }
      break;
      case 'Patronymic': { patronymicController; }
      break;
      case 'Phone Number': { phoneController; }
      break;
      case 'Gender': { genderController; }
      break;
      default: { print('Invalid title of widget - ${title}'); }
      break;
    }
  }


  Widget _buildTF(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: _getInputTypeByTitle(title),
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            controller: _getControllerByTitle(title),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter ${title}',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => _register(),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Register',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  // TODO: Add validator
  Future _register() async {
    PatientModel patientModel =
        await controller.register(emailController.text, password1Controller.text, password2Controller.text,
                      nameController.text, surnameController.text, patronymicController.text,
                      phoneController.text, genderController.text, _birthday);
    if (patientModel != null) {
      Get.snackbar('Success', 'Patient account has been created!');
    } else {
      print('Something went wrong on registration');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 500),
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 120.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        _buildTF('Email'),
                        SizedBox(height: 30.0),
                        _buildTF('Password1'),
                        SizedBox(height: 30.0),
                        _buildTF('Password2'),
                        SizedBox(height: 30.0),
                        _buildTF('Name'),
                        SizedBox(height: 30.0),
                        _buildTF('Surname'),
                        SizedBox(height: 30.0),
                        _buildTF('Patronymic'),
                        SizedBox(height: 30.0),
                        _buildTF('Phone Number'),
                        Spacer(),
                        _buildTF('Gender'),
                        Spacer(),
                        DateTimeFormField(
                          initialValue: _birthday,
                          label: "Birthday",
                          validator: (DateTime dateTime) {
                            if (dateTime == null) {
                              return "Date Time Required";
                            }
                            return null;
                          },
                          onSaved: (DateTime dateTime) => _birthday = dateTime,
                        ),
                        _buildRegisterBtn(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
