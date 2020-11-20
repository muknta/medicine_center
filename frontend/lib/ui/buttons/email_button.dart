import 'package:flutter/material.dart';
import 'package:medecine_app/modules/doctor/doctor_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailButton extends StatelessWidget {
  const EmailButton({
    Key key,
    @required this.email,
  }) : super(key: key);

  final String email;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Send email',
      child: IconTile(
          backColor: Color.fromRGBO(144, 202, 249, 1),
          iconButton: IconButton(
              icon: Icon(Icons.email),
              onPressed: () async => await _launchEmailSend(email ?? ''))),
    );
  }

  _launchEmailSend(String email) async {
    final url = Uri(
        scheme: 'mailto',
        path: email,
        queryParameters: {'subject': 'YourHealth'});
    if (await canLaunch(url.toString())) {
      await launch(url.toString());
    } else {
      throw 'Could not launch $url';
    }
  }
}
