import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

import 'package:medecine_app/routes.dart';
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
                    child: RegisterForm(controller),
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


class RegisterForm extends StatefulWidget {
  RegisterController controller;
  
  RegisterForm(this.controller);

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final password1Controller = TextEditingController();
  final password2Controller = TextEditingController();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final patronymicController = TextEditingController();
  final phoneController = TextEditingController();
  final genderController = TextEditingController();
  final professionController = TextEditingController();
  final addressController = TextEditingController();
  final birthdayController = TextEditingController();

  _getInputTypeByTitle(String title) {
    switch(title) {
      case 'Email': { return TextInputType.emailAddress; }
      break;
      case 'Password1': { return TextInputType.visiblePassword; }
      break;
      case 'Password2': { return TextInputType.visiblePassword; }
      break;
      case 'Name': { return TextInputType.name; }
      break;
      case 'Surname': { return TextInputType.name; }
      break;
      case 'Patronymic': { return TextInputType.name; }
      break;
      case 'Phone Number': { return TextInputType.phone; }
      break;
      case 'Gender': { return TextInputType.text; }
      break;
      case 'Profession': { return TextInputType.text; }
      break;
      case 'Address': { return TextInputType.text; }
      break;
      case 'Birthday': { return TextInputType.datetime; }
      break;
      default: { print('Invalid title of widget - $title'); return null; }
      break;
    }
  }

  _getControllerByTitle(String title) {
    switch(title) {
      case 'Email': { return emailController; }
      break;
      case 'Password1': { return password1Controller; }
      break;
      case 'Password2': { return password2Controller; }
      break;
      case 'Name': { return nameController; }
      break;
      case 'Surname': { return surnameController; }
      break;
      case 'Patronymic': { return patronymicController; }
      break;
      case 'Phone Number': { return phoneController; }
      break;
      case 'Gender': { return genderController; }
      break;
      case 'Profession': { return professionController; }
      break;
      case 'Address': { return addressController; }
      break;
      case 'Birthday': { return birthdayController; }
      break;
      default: { print('Invalid title of widget - $title'); return null; }
      break;
    }
  }

  String _validateValueByTitle(String value, String title) {
    // print('frontend validation: val, tit $value, $title');
    switch(title) {
      case 'Email': { 
        RegExp regExp = new RegExp(
          r"[a-zA-Z0-9]+@+[a-zA-Z0-9]+\.+[a-zA-Z]{2,5}",
          caseSensitive: true,
          multiLine: false,
        );
        if (!regExp.hasMatch(value)) { return 'Invalid email.'; }
        return null;
      }
      break;
      case 'Password1':
      // TODO: Check for Password2 if equals to Password1
      case 'Password2': {
        final int minLen = 6;
        final int maxLen = 30;

        RegExp regExp = new RegExp(
          "(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9]{$minLen,$maxLen}",
          caseSensitive: true,
          multiLine: false,
        );
        if (!regExp.hasMatch(value)) {
          print(regExp);
          return 'Password must consist of uppercase, lowercase letter, numerical with $minLen-$maxLen chars length.';
        }
        return null;
      }
      break;
      case 'Name':
      case 'Surname':
      case 'Patronymic': {
        RegExp regExp = new RegExp(
          r"[A-Za-z]+",
          caseSensitive: false,
          multiLine: false,
        );
        if (!regExp.hasMatch(value)) {
          return "Name must consist of letters only.";
        }
        return null;
      }
      break;
      case 'Phone Number': {
        try {
          final int minLen = 6;
          final int maxLen = 15;

          RegExp regExp = new RegExp(
            r"\+{1,1}?[0-9]{"+"$minLen,$maxLen}",
            caseSensitive: false,
            multiLine: false,
          );
          if (!regExp.hasMatch(value)) {
            print(regExp);
            return "Phone number begins with '+' and the rest ($minLen-$maxLen chars) consists of numbers.";
          }
          return null;
        } catch(e) {
          print(e);
        }

      }
      break;
      case 'Gender': {
        List<String> genderList = ['male', 'female', 'custom'];
        if (!genderList.contains(value)) {
          return "Choose gender between $genderList";
        }
        return null;
      }
      break;
      case 'Profession':
      case 'Address': {
        return (value == '')
          ? 'Fill this field'
          : null;
      }
      break;
      default: { 
        print('Invalid title of widget - $title, with value - $value');
        return null;
      }
      break;
    }
  }

  _getIconByTitle(String title) {
    switch(title) {
      case 'Email': { return Icons.email; }
      break;
      case 'Password1':
      case 'Password2': { return Icons.vpn_key_rounded; }
      break;
      case 'Name':
      case 'Surname':
      case 'Patronymic': { return Icons.book_outlined; }
      break;
      case 'Phone Number': { return Icons.contact_phone_outlined; }
      break;
      case 'Gender': { return Icons.group_rounded; }
      break;
      case 'Profession': { return Icons.group_rounded; }
      break;
      case 'Address': { return Icons.house; }
      break;
      case 'Birthday': { return Icons.cake_rounded; }
      break;
      default: { print('Invalid title of widget - $title'); }
      break;
    }
  }


  Widget _buildTextFormField(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        TextFormField(
          keyboardType: _getInputTypeByTitle(title),
          textInputAction: TextInputAction.next,
          controller: _getControllerByTitle(title),
          validator: (value) => _validateValueByTitle(value, title),
          obscureText: (title == 'Password2') ? true : false,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              _getIconByTitle(title),
              color: Colors.white,
            ),
            hintText: 'Enter your ${title}',
            hintStyle: kHintTextStyle,
          ),
        ),
      ],
    );
  }


  Widget _buildBasicDateField(String title) {
    final timeFormat = DateFormat("yyyy-MM-dd");
    final textColor = Colors.white;

    return Column(children: <Widget>[
      Align(
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Icon(
                  _getIconByTitle(title),
                  color: textColor,
                ),
              ),
              TextSpan(
                text: ' $title (${timeFormat.pattern})',
              ),
            ],
            style: TextStyle(color: textColor),
          ),
        ),
      ),
      DateTimeField(
        format: timeFormat,
        controller: _getControllerByTitle(title),
        validator: (value) {
          if (value == null) return 'Set your Birthday, please';
        },
        onShowPicker: (context, currentValue) {
          return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(DateTime.now().year));
        },
      ),
    ]);
  }

  Widget _buildRegisterBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Data processing...')));
            _register();
          } else {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Invalid Data')));
          }
        },
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

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          Navigator.pushNamed(context, Routes.Login);
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Log In',
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

  Future<void> _register() async {
    // print('email ${emailController.text} - ${emailController}, pass1 ${password1Controller.text}, pass2 ${password2Controller.text}, name ${nameController.text}, surname ${surnameController.text}, patro ${patronymicController.text}, phone ${phoneController.text}, gender ${genderController.text}');
    // print('birthdayController ${birthdayController.text}');
    Rx patientModel =
        await widget.controller.register(emailController.text, password1Controller.text, password2Controller.text,
                      nameController.text, surnameController.text, patronymicController.text,
                      phoneController.text, genderController.text, professionController.text, addressController.text,
                      DateFormat("yyyy-MM-dd").parse(birthdayController.text));
    if (patientModel != null) {
      Navigator.pushNamed(context, Routes.Login);
      Get.snackbar('Success', 'Patient account has been created!');
    } else {
      print('Something went wrong on registration');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
          _buildTextFormField('Email'),
          SizedBox(height: 30.0),
          _buildTextFormField('Password1'),
          SizedBox(height: 30.0),
          _buildTextFormField('Password2'),
          SizedBox(height: 30.0),
          _buildTextFormField('Name'),
          SizedBox(height: 30.0),
          _buildTextFormField('Surname'),
          SizedBox(height: 30.0),
          _buildTextFormField('Patronymic'),
          SizedBox(height: 30.0),
          _buildTextFormField('Phone Number'),
          SizedBox(height: 30.0),
          _buildTextFormField('Gender'),
          SizedBox(height: 30.0),
          _buildTextFormField('Profession'),
          SizedBox(height: 30.0),
          _buildTextFormField('Address'),
          SizedBox(height: 30.0),
          _buildBasicDateField('Birthday'),
          
          _buildRegisterBtn(),
          _buildLoginBtn(),
        ],
      ),
    );
  }
}
