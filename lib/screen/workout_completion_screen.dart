import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workout_timer/const/colors.dart';
import 'package:workout_timer/screen/routine_select_test.dart';

class WorkoutCompletionScreen extends StatelessWidget {
  const WorkoutCompletionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100.0,),
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 5.0,
                    color: COLOR_M,
                  ),
                ),
                child: Center(
                  child: Text(
                    '오늘도 고생했어요!',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 100.0,),
              Container(
                width: 260.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [COLOR_L, COLOR_R],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextButton(
                  onPressed: () {
                    Get.off(
                      RoutineSelectTest(),
                      transition: Transition.native,
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(16.0),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '루틴선택 화면으로 돌아가기',
                        style: TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}