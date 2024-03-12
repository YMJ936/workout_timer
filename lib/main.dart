import 'package:flutter/material.dart';
import 'package:workout_timer/firebase_options.dart';
import 'package:workout_timer/screen/create_test.dart';
import 'package:workout_timer/screen/workout_screen.dart';
import 'package:workout_timer/screen/workout_completion_screen.dart';
import 'package:workout_timer/screen/splash_screen.dart';
import 'package:workout_timer/screen/routine_select_screen.dart';
import 'package:workout_timer/screen/routine_create_screen.dart';
import 'package:workout_timer/screen/test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Flutter 프레임워크의 핵심 바인딩을 초기화하고, 앱의 위젯 트리를 생성

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
      GetMaterialApp(
        home: WorkoutScreen(),
      ),
  );
}