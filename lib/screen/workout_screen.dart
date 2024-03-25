import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workout_timer/component/custom_text_field.dart';
import 'package:workout_timer/component/custom_int_field.dart';
import 'package:workout_timer/component/workout_card_button.dart';
import 'dart:async';
import 'package:workout_timer/const/colors.dart';
import 'package:workout_timer/controller/workout_controller.dart';
import 'package:workout_timer/controller/workout_controller2.dart';
import 'package:workout_timer/screen/workout_completion_screen.dart';

class WorkoutScreen extends StatelessWidget {
  final String user;
  final int order;

  const WorkoutScreen({Key? key, required this.user, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WorkoutController2 workoutController = Get.put(WorkoutController2(user: user, order: order), permanent: false); //중복코드를 줄이기 위해 컨트롤러를 선언해둠
    
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
        title: Text('운동 진행 중'),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 22.0,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 11.0),
          Padding(
            padding: const EdgeInsets.only(
                bottom: 11.0, left: 9.0, right: 9.0),
            child: IntrinsicHeight(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 6.0,),
                    Expanded(
                      child: Text(
                        '남은 세트',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Text(
                        '운동 이름',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: Text(
                        '휴식 시간',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      flex: 1,
                    ),
                    const SizedBox(width: 5.0,),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() { //GetX패키지에서 제공하는 위젯으로 관찰 가능한 상태(exercises변수)를 감지하고 상태가 변경될 떄마다 화면을 업데이트한다.
              return ListView.builder(
                itemCount: workoutController.workoutList.length,
                itemBuilder: (context, index) {
                  var workout = workoutController.workoutList[index];
                  var workoutName = workout.workoutName;
                  var sets = workout.sets;
                  var restTime = workout.restTime;
                  var isActive = workout.isActive;
                  Timer timer = Timer(Duration.zero, () {});

                  return Padding(
                    padding: const EdgeInsets.only(
                        bottom: 11.0, left: 9.0, right: 9.0),
                    child: OutlinedButton(
                      onPressed: () {
                        int savedRest = restTime;
                        if(isActive == true){
                          if(workoutController.isTimerRunning == false){
                            workoutController.isTimerRunning = true;
                            timer = Timer.periodic(Duration(seconds: 1), (timer) {
                              if(workout.restTime > 1) {
                                workout.restTime--;
                                print('휴식시간: ${workout.restTime}');
                                workoutController.workoutList.refresh();
                              } else {
                                workout.restTime = savedRest;
                                timer.cancel();
                                workoutController.isTimerRunning = false;
                                if(sets > 1){
                                  workout.sets--;
                                  workoutController.workoutList.refresh();
                                } else {
                                  workout.sets--;
                                  workout.isActive = false;
                                  if(index+1 != workoutController.workoutList.length){
                                    workoutController.workoutList[index+1].isActive = true;
                                    workoutController.workoutList.refresh();
                                  } else {
                                    workoutController.workoutList.refresh();
                                    print('운동 끝!');
                                  }
                                }
                              }
                            });
                          } else {
                            print('이미 타이머가 실행 중 입니다.');
                          }
                        } else {
                          print('진행 중인 운동이 아닙니다.');
                        }
                        workoutController.workoutList.refresh();
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(15.0),
                        side: BorderSide(
                          width: 3.0,
                          color: isActive ? COLOR_M : Colors.white,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            const SizedBox(width: 2.0,),
                            Expanded(
                              child: Text(
                                '$sets',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isActive ? Colors.black87 : Colors.grey[600],
                                  fontSize: 20.0,
                                ),
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: Text(
                                '$workoutName',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isActive ? Colors.black87 : Colors.grey[600],
                                  fontSize: 20.0,
                                ),
                              ),
                              flex: 3,
                            ),
                            Expanded(
                              child: Text(
                                '$restTime초',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isActive ? Colors.black87 : Colors.grey[600],
                                  fontSize: 20.0,
                                ),
                              ),
                              flex: 1,
                            ),
                            const SizedBox(width: 2.0,),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(
                bottom: 11.0, left: 9.0, right: 9.0
            ),
            child: Container(
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
                    WorkoutCompletionScreen(),
                    transition: Transition.zoom,
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
                      '운동 완료',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}