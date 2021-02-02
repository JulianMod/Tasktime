import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tasktime_bloc/core/settings/settings.dart';
import 'package:vibration/vibration.dart';

class CodeInput extends StatelessWidget {
  final _myControllerYearInput = TextEditingController();
  final String _yearCheck = '2020';

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 4,
      backgroundColor: Colors.grey,
      showCursor: false,
      cursorColor: Colors.black,
      enableActiveFill: true,
      autoDismissKeyboard: true,
      autoDisposeControllers: false,
      enablePinAutofill: false,
      mainAxisAlignment: MainAxisAlignment.center,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.underline,
          fieldHeight: 60,
          fieldWidth: 50,
          activeFillColor: Colors.grey,
          inactiveFillColor: Colors.grey,
          selectedFillColor:Colors.grey
      ),
      keyboardType: TextInputType.number,
      controller: _myControllerYearInput,
      onCompleted: (inputValue) {
        if (inputValue == _yearCheck) {
          applicationPreferences.setBool('finalSecretStatus' , true);
          Vibration.vibrate(pattern: [0, 5000], amplitude: 255);
          //TODO: check if the pin code fields properly transitions
          Navigator.of(context).pushNamed(
              '/secret_screen').then((result) {
            Navigator.of(context, rootNavigator: true).pop();
          });
        }
      }, onChanged: (String value) {  },
    );
  }
}

