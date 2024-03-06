import 'package:flutter/material.dart';
import 'package:workout_timer/const/colors.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30.0),
            Image.asset(
              'assets/img/logo.png',
            ),
            const SizedBox(height: 50.0),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                COLOR_M,
              ),
            ),
          ],
        ),
      ),
    );
  }
}