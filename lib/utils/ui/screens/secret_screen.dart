import 'package:flutter/material.dart';
import 'package:email_launcher/email_launcher.dart';
import 'package:provider/provider.dart';
import 'package:tasktime_bloc/config/themes/theme_config.dart';
import 'package:tasktime_bloc/core/settings/settings.dart';

class SecretScreen extends StatelessWidget{

  void _sendMail() async {
    var email = Email(
        to: ['contact@eggdevs.com'],
        subject: 'I discovered a secret',
        body: 'You can share your thoughts about the application, how you feel today or anything that you want here'
    );
    await EmailLauncher.launch(email);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
          backgroundColor: Colors.blue[900],
          automaticallyImplyLeading: false,
          leading: BackButton(
            onPressed: () {
              applicationPreferences.setString('theme', 'Extra');
              themeProvider.rebuildTheApp();
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[IconButton(
            icon: Icon(Icons.mail),
            onPressed: () {
              _sendMail();
            },
          )
          ]
      ),
      body: Center(
          child: Text('Well done! You have discovered a secret! \n\n'
              ' Check themes option for something extra. \n\n'
              ' If you want to share anything with me press the email button on the app bar',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          )
      ),
    );
  }
}