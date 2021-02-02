import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class CardExpansionAnimation {
  AnimationController _expandAnimationController;
  Animation<double> animation;

  void animationInitialization(TickerProvider tp) {
    _expandAnimationController = AnimationController(
      vsync: tp,
      duration: Duration(milliseconds: 1500),
    );
    animation = CurvedAnimation(
        parent: _expandAnimationController,
        curve: Curves.fastOutSlowIn
    );
  }

  void runExpandCheck(bool ex) {
    if(ex) {
      _expandAnimationController.forward();
    }
    else {
      _expandAnimationController.reverse();
    }
  }

  void disposeController() {
    _expandAnimationController.dispose();
  }

}