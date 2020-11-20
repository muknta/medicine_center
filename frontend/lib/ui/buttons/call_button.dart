import 'package:flutter/material.dart';
import 'package:medecine_app/modules/doctor/doctor_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class CallButton extends StatelessWidget {
  const CallButton({
    Key key,
    @required this.phoneNumber,
  }) : super(key: key);

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
        message: 'Call phone',
        child: IconTile(
            backColor: Color.fromRGBO(144, 202, 249, 1),
            iconButton: IconButton(
                icon: Icon(Icons.phone),
                onPressed: () async => _launchCallPhone(phoneNumber ?? ''))));
  }

  _launchCallPhone(String phone) async {
    final url = Uri(scheme: 'tel', path: phone);
    if (await canLaunch(url.toString())) {
      await launch(url.toString());
    } else {
      throw 'Could not launch $url';
    }
  }
}
