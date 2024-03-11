import 'package:flutter/material.dart';
import 'package:workout_timer/screen/Mypage.dart';
import 'package:workout_timer/screen/workout_screen.dart';
import 'package:workout_timer/screen/workout_completion_screen.dart';
import 'package:workout_timer/screen/splash_screen.dart';
import 'package:workout_timer/screen/routine_select_screen.dart';
import 'package:workout_timer/screen/routine_create_screen.dart';
import 'package:workout_timer/screen/test.dart';
import 'package:get/get.dart';

void main() {
  runApp(
      GetMaterialApp(
        home: Test(),
      ),
  );
}