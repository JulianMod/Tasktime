import 'package:flutter/material.dart';
import 'package:tasktime_bloc/core/settings/settings.dart';
import 'package:tasktime_bloc/utils/ui/components/three_theme_buttons.dart';
import 'package:tasktime_bloc/utils/ui/components/two_theme_buttons.dart';

class ThemeChoiceButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (finalSecretUnlocked == true){
      return ThreeThemeButtons();
    }
    return TwoThemeButtons();
  }
}

