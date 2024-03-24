import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workout_timer/component/routine_card_button.dart';
import 'package:workout_timer/const/colors.dart';
import 'package:workout_timer/screen/create_test.dart';

class RoutineSelectScreen extends StatelessWidget {
  const RoutineSelectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make app bar transparent
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                COLOR_L,
                COLOR_R,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        title: Text('운동 루틴 선택'),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 21.0,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(height: 11.0),
          RoutineCardButton(
            routineName: '3분할 루틴',
          ),
          RoutineCardButton(
            routineName: '4분할 루틴',
          ),
          RoutineCardButton(
            routineName: '5분할 루틴',
          ),
          IconButton(
            onPressed: () {
              Get.to(
                  CreateTest(),
                transition: Transition.rightToLeftWithFade,
              );
            },
            icon: Icon(
              Icons.add_circle_outline,
              size: 80.0,
            ),
          ),
        ],
      ),
    );
  }
}