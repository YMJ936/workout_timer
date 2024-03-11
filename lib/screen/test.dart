import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workout_timer/component/custom_text_field.dart';
import 'package:workout_timer/component/custom_int_field.dart';
import 'package:workout_timer/component/workout_card_button.dart';
import 'package:workout_timer/const/colors.dart';
import 'package:workout_timer/controller/getx_controller.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ExerciseController exerciseController = Get.put(ExerciseController()); //중복코드를 줄이기 위해 컨트롤러를 선언해둠


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
                itemCount: exerciseController.exercises.length,
                itemBuilder: (context, index) {
                  var exercise = exerciseController.exercises[index];
                  var sets = exercise.sets[0];
                  var setCount = sets.setCount;
                  var restTime = sets.restTime;
                  var isActive = sets.isActive;
                  Timer timer = Timer(Duration.zero, () {});

                  return Padding(
                    padding: const EdgeInsets.only(
                        bottom: 11.0, left: 9.0, right: 9.0),
                    child: OutlinedButton(
                      onPressed: () { //변수 사용할 땐 반드시 sets를 붙여야 함
                        int savedRest = sets.restTime;
                        if(isActive == true){
                          if(exerciseController.isTimerRunning == false){
                            exerciseController.isTimerRunning = true;
                            timer = Timer.periodic(Duration(seconds: 1), (timer) {
                              if(sets.restTime > 1) {
                                sets.restTime--;
                                print('휴식시간: $sets.restTime');
                                exerciseController.exercises.refresh();
                              } else {
                                sets.restTime = savedRest;
                                timer.cancel();
                                exerciseController.isTimerRunning = false;
                                if(setCount > 1){
                                  sets.setCount--;
                                  exerciseController.exercises.refresh();
                                } else {
                                  sets.setCount--;
                                  sets.isActive = false;
                                  if(index+1 != exerciseController.exercises.length){
                                    exerciseController.exercises[index+1].sets[0].isActive = true;
                                    exerciseController.exercises.refresh();
                                  } else {
                                    exerciseController.exercises.refresh();
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
                        exerciseController.exercises.refresh();
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
                                '$setCount',
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
                                exercise.exerciseName,
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
        ],
      ),
    );
  }
}

class ExerciseController extends GetxController { //getx컨트롤러
  var exercises = <Exercise>[].obs; //변수 선언 + .obs를 통해 관찰가능해짐
  bool isTimerRunning = false;

  @override
  void onInit() { //getx 컨트롤러가 초기화 될 때 호출됨(생성자?)
    super.onInit();
    fetchExercises(); //운동 데이터를 가져오는 함수
  }

  void fetchExercises() {
    // 예시 데이터를 직접 넣어줍니다. 실제 앱에서는 여기서 서버로부터 데이터를 가져오는 코드가 위치할 것입니다.
    var routineData = {
      "routine_name": "나의 루틴",
      "exercises": [
        {
          "exercise_name": "스쿼트",
          "sets": [
            {"set_count": 3, "rest_time": 10, "is_active": true},
          ]
        },
        {
          "exercise_name": "푸쉬업",
          "sets": [
            {"set_count": 4, "rest_time": 10, "is_active": false},
          ]
        },
        {
          "exercise_name": "레그 프레스",
          "sets": [
            {"set_count": 5, "rest_time": 10, "is_active": false},
          ]
        }
      ]
    };

    var exercises = (routineData['exercises'] as List) //routineData 변수에서 'exercises'라는 키에 해당하는 값을 가져옵니다. 이 값은 리스트 형태로 되어 있어야 한다.
        .map((e) => Exercise.fromJson(e)) //map 함수를 사용하여 리스트의 각 요소에 대해 Exercise.fromJson함수 호출(Exercise.fromJson함수는 해당 요소를 Exercise객체로 반환
        .toList(); //toList 함수를 사용하여 변환된 Exercise 객체들로 이루어진 리스트를 생성합니다.

    this.exercises.assignAll(exercises); //생성된 리스트를 this.exercises 변수에 할당합니다.
  }

}

class Exercise { // 운동의 이름과 세트 정보를 담은 클래스
  String exerciseName; //운동 이름
  List<SetInfo> sets; //세트 리스트

  Exercise({required this.exerciseName, required this.sets});

  factory Exercise.fromJson(Map<String, dynamic> json) {//Exercise.fromJson 팩토리 메서드: JSON 형식의 데이터를 매개변수로 받아 Exercise 객체를 생성
    var sets = (json['sets'] as List)//주어진 JSON 데이터에서 'sets'라는 키에 해당하는 값을 가져옵니다. 이 값은 리스트 형태로 되어 있어야 합니다.
        .map((set) => SetInfo.fromJson(set)) //map 함수를 사용하여 리스트의 각 요소에 대해 SetInfo.fromJson 함수를 호출합니다./ SetInfo.fromJson 함수는 해당 요소를 SetInfo 객체로 변환합니다.
        .toList();//toList 함수를 사용하여 변환된 SetInfo 객체들로 이루어진 리스트를 생성합니다.

    return Exercise( //exerciseName과 생성된 리스트를 사용하여 Exercise 객체를 생성하고 반환합니다.
      exerciseName: json['exercise_name'],
      sets: sets,
    );
  }
}

class SetInfo {
  int setCount; //세트수
  int restTime; //휴식시간
  bool isActive;


  SetInfo({required this.setCount, required this.restTime, required this.isActive});

  factory SetInfo.fromJson(Map<String, dynamic> json) { //fromJson() 메서드로 JSON데이터를 SetInfo객체로 변환
    return SetInfo(
      setCount: json['set_count'],
      restTime: json['rest_time'],
      isActive: json['is_active'],
    );
  }
}