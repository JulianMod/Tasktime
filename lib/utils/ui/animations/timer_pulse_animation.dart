import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class TimerPulse{

  AnimationController _pulseAnimationController;
  String pulseAnimationStatus;

  void animationInitialization(TickerProvider tp, int dur) {
    _pulseAnimationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: tp,
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed && dur != 0) {
          _pulseAnimationController.reverse();
          pulseAnimationStatus = 'reverse';
        } else
        if (status == AnimationStatus.dismissed && dur != 0) {
          _pulseAnimationController.forward();
          pulseAnimationStatus = 'forward';
        }
      });
    startAnimation();
  }

  void disposeController() {
    _pulseAnimationController.dispose();
  }

  void resetAnimation() {
    _pulseAnimationController.reset();
  }

  void stopAnimation() {
    _pulseAnimationController.stop();
  }

  void continueAnimation() {
    if(pulseAnimationStatus == 'forward') {
      _pulseAnimationController.forward();
    }
    else if(pulseAnimationStatus == 'reverse'){
      _pulseAnimationController.reverse();
    }
  }

  void startAnimation() {
    _pulseAnimationController.forward();
  }

  Widget buildWidget() {
    return TimerPulseAnimation(controller: _pulseAnimationController);
  }
}

class TimerPulseAnimation extends AnimatedWidget {
  TimerPulseAnimation({Key key, AnimationController controller})
      : super(key: key, listenable: controller);
  @override
  Widget build(BuildContext context) {
    final controller = listenable as AnimationController;
    final Animation<double> _expansionAnimation = CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutSine
    );
    final Animation<double> _opacityAnimation = CurvedAnimation(
        parent: controller,
        curve: Curves.linear
    );
    final _expansionTween = Tween<double>(begin: 0, end: 310);
    final _opacityTween = Tween<double>(begin: 0, end: 0.15);
    return Opacity(opacity: _opacityTween.evaluate(_opacityAnimation),
        child: Container(
            width: _expansionTween.evaluate(_expansionAnimation),
            height: _expansionTween.evaluate(_expansionAnimation),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle
            )
        )
    );
  }
}