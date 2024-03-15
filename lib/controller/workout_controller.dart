import 'dart:async';
import 'dart:convert';
import 'package:workout_timer/model/routine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WorkoutController extends GetxController { //getx컨트롤러
  var workoutList = <Workout>[].obs; //변수 선언 + .obs를 통해 관찰가능해짐
  bool isTimerRunning = false;

  @override
  void onInit() { //getx 컨트롤러가 초기화 될 때 호출됨(생성자?)
    super.onInit();
    fetchWorkouts(); //운동 데이터를 가져오는 함수
  }

  void fetchWorkouts() async {
    final url = Uri.https(
      'workout-timer-d62e6-default-rtdb.firebaseio.com', // DB엔드포인트
      'routines.json', //저장될 json 문서명
    );
    try {
      final response = await http.get(url); //DB에 요청을 보내서 받은 응답
      final routineData = jsonDecode(response.body) as Map<String, dynamic>; //응답의 body의 내용물을 Map형태로 변환
      print('response Map으로 변환 (routineData)');
      print(routineData);

      /* 루틴 데이터 내용물 까보기
      if (routineData is Map<String, dynamic>) {
        routineData.forEach((key, value) {
          // 키의 타입을 출력
          print(key.runtimeType);
          // 값의 타입을 출력
          print(value.runtimeType);

          // 값이 List인 경우 각 항목의 타입을 체크할 수도 있습니다.
          if (value is List) {
            value.forEach((item) {
              print(item.runtimeType);
            });
          }
        });
      }
       */

      final List<Routine> data = [];
      routineData.forEach((key, value) {
        // 여기서 value는 리스트를 포함하는 Map입니다.
        // value를 리스트로 변환하여 처리합니다.
        List<dynamic> routinesList = value; // JSON 구조에 따라 적절히 형변환 필요
        routinesList.forEach((routineMap) {
          final routine = Routine.fromJson(routineMap);
          data.add(routine);

          // 여기서 routine의 workouts를 출력합니다.
          routine.workouts.forEach((workout) {
            print('Workout Name: ${workout.workoutName.runtimeType}, Sets: ${workout.sets.runtimeType}, RestTime: ${workout.restTime.runtimeType}, IsActive: ${workout.isActive.runtimeType}');
            print(workout);
            print(routine);
            workoutList.assignAll(routine.workouts);
          });
        });
      });

    } catch (e) {
      print("데이터를 가져오는 중 에러가 발생했습니다: $e");
    }

  }

}