import 'dart:async';
import 'package:workout_timer/model/routine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkoutController extends GetxController { //getx컨트롤러
  var workoutList = <Workout>[].obs; //변수 선언 + .obs를 통해 관찰가능해짐
  bool isTimerRunning = false;

  @override
  void onInit() { //getx 컨트롤러가 초기화 될 때 호출됨(생성자?)
    super.onInit();
    fetchWorkouts(); //운동 데이터를 가져오는 함수
  }

  void fetchWorkouts() {
    // 예시 데이터를 직접 넣어줍니다. 실제 앱에서는 여기서 서버로부터 데이터를 가져오는 코드가 위치할 것입니다.
    var routineData = {
      "routineName": "무분할 루틴",
      "workouts": [
        {
          "workoutName": "푸쉬업",
          "sets": 3,
          "restTime": 30,
          "isActive": true
        },
        {
          "workoutName": "싯업",
          "sets": 4,
          "restTime": 20,
          "isActive": false
        },
        {
          "workoutName": "스쿼트",
          "sets": 5,
          "restTime": 45,
          "isActive": false
        }
      ]
    };
    /*
    {
      "routine_name": "나의 루틴",
      "workouts": [
        {
          "workout_name": "스쿼트",
          "sets": [
            {"set_count": 3, "rest_time": 10, "is_active": true},
          ]
        },
        {
          "workout_name": "푸쉬업",
          "sets": [
            {"set_count": 4, "rest_time": 10, "is_active": false},
          ]
        },
        {
          "workout_name": "레그 프레스",
          "sets": [
            {"set_count": 5, "rest_time": 10, "is_active": false},
          ]
        }
      ]
    };*/

    var routine = Routine.fromJson(routineData);
    /*
    var routine = (routineData['workouts'] as List) //routineData 변수에서 'exercises'라는 키에 해당하는 값을 가져옵니다. 이 값은 리스트 형태로 되어 있어야 한다.
        .map((e) => Routine.fromJson(e)) //map 함수를 사용하여 리스트의 각 요소에 대해 Exercise.fromJson함수 호출(Exercise.fromJson함수는 해당 요소를 Exercise객체로 반환
        .toList(); //toList 함수를 사용하여 변환된 Exercise 객체들로 이루어진 리스트를 생성합니다.
     */
    this.workoutList.assignAll(routine.workouts); //생성된 리스트를 this.exercises 변수에 할당합니다.
  }

}