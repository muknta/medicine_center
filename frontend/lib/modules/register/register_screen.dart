import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

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
  final birthdayController = TextEditingController();

  // final DateTime _now = new DateTime.now(); // need to define at initState()
  DateTime _birthday = new DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day
    );


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
      case 'Birthday': { return TextInputType.datetime; }
      break;
      default: { print('Invalid title of widget - $title'); }
      break;
    }
  }

  _getControllerByTitle(String title) {
    switch(title) {
      case 'Email': { print('got emailController;'); return emailController; }
      break;
      case 'Password1': { print('got password1Controller;'); return password1Controller; }
      break;
      case 'Password2': { print('got password2Controller;'); return password2Controller; }
      break;
      case 'Name': { print('got nameController;'); return nameController; }
      break;
      case 'Surname': { print('got surnameController;'); return surnameController; }
      break;
      case 'Patronymic': { print('got patronymicController;'); return patronymicController; }
      break;
      case 'Phone Number': { print('got phoneController;'); return phoneController; }
      break;
      case 'Gender': { print('got genderController;'); return genderController; }
      break;
      case 'Birthday': { print('got birthdayController;'); return birthdayController; }
      break;
      default: { print('Invalid title of widget - $title'); }
      break;
    }
  }

  String _validateValueByTitle(String value, String title) {
    print('frontend validation: val, tit $value, $title');
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
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: _getInputTypeByTitle(title),
            textInputAction: TextInputAction.next,
            controller: _getControllerByTitle(title),
            validator: (value) => _validateValueByTitle(value, title),
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
        ),
      ],
    );
  }

  // Widget _buildDateTimeTF(String title) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Text(
  //         title,
  //         style: kLabelStyle,
  //       ),
  //       SizedBox(height: 10.0),
  //       Container(
  //         alignment: Alignment.centerLeft,
  //         decoration: kBoxDecorationStyle,
  //         height: 60.0,
  //         child: TextField(
  //           keyboardType: TextInputType.datetime,
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontFamily: 'OpenSans',
  //           ),
  //           decoration: InputDecoration(
  //             border: InputBorder.none,
  //             contentPadding: EdgeInsets.only(top: 14.0),
  //             prefixIcon: Icon(
  //               Icons.email,
  //               color: Colors.white,
  //             ),
  //             hintText: 'Enter ${title}',
  //             hintStyle: kHintTextStyle,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }


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

  Future<void> _register() async {
    print('email ${emailController.text} - ${emailController}, pass1 ${password1Controller.text}, pass2 ${password2Controller.text}, name ${nameController.text}, surname ${surnameController.text}, patro ${patronymicController.text}, phone ${phoneController.text}, gender ${genderController.text}');
    print('birthdayController ${birthdayController.text}');
    PatientModel patientModel =
        await widget.controller.register(emailController.text, password1Controller.text, password2Controller.text,
                      nameController.text, surnameController.text, patronymicController.text,
                      phoneController.text, genderController.text,
                      DateFormat("yyyy-MM-dd").parse(birthdayController.text));
                      // DateFormat("yyyy-MM-dd").format(DateTime.now()));
                      // DateTime.parse(birthdayController.text));
    if (patientModel != null) {
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
          // _buildTextFormField('Email'),
          TextFormField(
            keyboardType: _getInputTypeByTitle('Email'),
            textInputAction: TextInputAction.next,
            controller: _getControllerByTitle('Email'),
            validator: (value) => _validateValueByTitle(value, 'Email'),
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                _getIconByTitle('Email'),
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
          SizedBox(height: 30.0),
          // _buildTextFormField('Password1'),
          TextFormField(
            keyboardType: _getInputTypeByTitle('Password1'),
            textInputAction: TextInputAction.next,
            controller: _getControllerByTitle('Password1'),
            validator: (value) => _validateValueByTitle(value, 'Password1'),
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                _getIconByTitle('Password1'),
                color: Colors.white,
              ),
              hintText: 'Enter your Password1',
              hintStyle: kHintTextStyle,
            ),
          ),
          SizedBox(height: 30.0),
          // _buildTextFormField('Password2'),
          TextFormField(
            keyboardType: _getInputTypeByTitle('Password2'),
            textInputAction: TextInputAction.next,
            controller: _getControllerByTitle('Password2'),
            validator: (value) => _validateValueByTitle(value, 'Password2'),
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                _getIconByTitle('Password2'),
                color: Colors.white,
              ),
              hintText: 'Enter your Password2',
              hintStyle: kHintTextStyle,
            ),
          ),
          SizedBox(height: 30.0),
          // _buildTextFormField('Name'),
          TextFormField(
            keyboardType: _getInputTypeByTitle('Name'),
            textInputAction: TextInputAction.next,
            controller: _getControllerByTitle('Name'),
            validator: (value) => _validateValueByTitle(value, 'Name'),
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                _getIconByTitle('Name'),
                color: Colors.white,
              ),
              hintText: 'Enter your Name',
              hintStyle: kHintTextStyle,
            ),
          ),
          SizedBox(height: 30.0),
          // _buildTextFormField('Surname'),
          TextFormField(
            keyboardType: _getInputTypeByTitle('Surname'),
            textInputAction: TextInputAction.next,
            controller: _getControllerByTitle('Surname'),
            validator: (value) => _validateValueByTitle(value, 'Surname'),
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                _getIconByTitle('Surname'),
                color: Colors.white,
              ),
              hintText: 'Enter your Surname',
              hintStyle: kHintTextStyle,
            ),
          ),
          SizedBox(height: 30.0),
          // _buildTextFormField('Patronymic'),
          TextFormField(
            keyboardType: _getInputTypeByTitle('Patronymic'),
            textInputAction: TextInputAction.next,
            controller: _getControllerByTitle('Patronymic'),
            validator: (value) => _validateValueByTitle(value, 'Patronymic'),
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                _getIconByTitle('Patronymic'),
                color: Colors.white,
              ),
              hintText: 'Enter your Patronymic',
              hintStyle: kHintTextStyle,
            ),
          ),
          SizedBox(height: 30.0),
          // _buildTextFormField('Phone Number'),
          TextFormField(
            keyboardType: _getInputTypeByTitle('Phone Number'),
            // textInputAction: TextInputAction.next,
            controller: _getControllerByTitle('Phone Number'),
            validator: (value) => _validateValueByTitle(value, 'Phone Number'),
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                _getIconByTitle('Phone Number'),
                color: Colors.white,
              ),
              hintText: 'Enter your Phone Number',
              hintStyle: kHintTextStyle,
            ),
          ),
          SizedBox(height: 30.0),
          // _buildTextFormField('Gender'),
          TextFormField(
            keyboardType: _getInputTypeByTitle('Gender'),
            textInputAction: TextInputAction.next,
            controller: _getControllerByTitle('Gender'),
            validator: (value) => _validateValueByTitle(value, 'Gender'),
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                _getIconByTitle('Gender'),
                color: Colors.white,
              ),
              hintText: 'Enter your Gender',
              hintStyle: kHintTextStyle,
            ),
          ),
          SizedBox(height: 30.0),
          // _buildCustomDateTimeFF(),
          _buildBasicDateField('Birthday'),
          
          // _buildTextFormField('Birthday'),
          _buildRegisterBtn(),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 16.0),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       // Validate returns true if the form is valid, or false
          //       // otherwise.
          //       if (_formKey.currentState.validate()) {
          //         Scaffold.of(context)
          //             .showSnackBar(SnackBar(content: Text('success of success')));
          //         _register();
          //       } else {
          //         Scaffold.of(context)
          //             .showSnackBar(SnackBar(content: Text('Invalid Data')));
          //       }
          //     },
          //     child: Text('Submit'),
          //   ),
          // ),
          // RaisedButton(
          //   onPressed: () {
          //     if (_formKey.currentState.validate()) {
          //       Scaffold.of(context)
          //           .showSnackBar(SnackBar(content: Text('success of success')));
          //       _register();
          //     } else {
          //       Scaffold.of(context)
          //           .showSnackBar(SnackBar(content: Text('Invalid Data')));
          //     }
          //   },
          //   padding: EdgeInsets.all(15.0),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(30.0),
          //   ),
          //   color: Colors.white,
          //   child: Text(
          //     'Register',
          //     style: TextStyle(
          //       color: Color(0xFF527DAA),
          //       letterSpacing: 1.5,
          //       fontSize: 18.0,
          //       fontWeight: FontWeight.bold,
          //       fontFamily: 'OpenSans',
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
