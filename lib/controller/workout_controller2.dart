import 'dart:async';
import 'dart:convert';
import 'package:workout_timer/model/routine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WorkoutController2 extends GetxController { //getx컨트롤러
  var workoutList = <Workout>[].obs; //변수 선언 + .obs를 통해 관찰가능해짐
  bool isTimerRunning = false;
  final String user;
  final int order;

  WorkoutController2({required this.user,required this.order});

  @override
  void onInit() { //getx 컨트롤러가 초기화 될 때 호출됨(생성자?)
    super.onInit();
      // 둘 다 값이 설정되어 있다면 fetchWorkouts2를 실행합니다.
      fetchWorkouts2(user!, order!);
      print(user);
      print(order);
  }
/*
  void fetchWorkouts() async {
    final url = Uri.https(
      'workout-timer-d62e6-default-rtdb.firebaseio.com', // DB엔드포인트
      'routines.json', //저장된 json 문서명
    );
    try {
      final response = await http.get(url); //DB에 요청을 보내서 받은 응답
      final routineData = jsonDecode(response.body) as Map<String, dynamic>; //응답의 body의 내용물을 Map형태로 변환
      print('response Map으로 변환 (routineData)');
      print(routineData);

      String user = 'user1'; // 추후에 주입하는 방식으로 바꾸기
      int order = 3; // 위와 같음

      final List<Routine> data = [];
      routineData.forEach((key, value) {
        // 여기서 value는 리스트를 포함하는 Map입니다.
        // value를 리스트로 변환하여 처리합니다.
        List<dynamic> routinesList = value; // JSON 구조에 따라 적절히 형변환 필요
        routinesList.forEach((routineMap) {
          final routine = Routine.fromJson(routineMap);
          //data.add(routine);
          if (routine.user == 'user1') { // routine.user가 'user1'인 경우에만 리스트에 추가
            data.add(routine);
          }
          if(user == routine.user && order == routine.order) {
            routine.workouts.forEach((workout) {
              print('Workout Name: ${workout.workoutName.runtimeType}, Sets: ${workout.sets.runtimeType}, RestTime: ${workout.restTime.runtimeType}, IsActive: ${workout.isActive.runtimeType}');
              print(workout);
              print(routine);
              workoutList.assignAll(routine.workouts);
            });
          }
          // 여기서 routine의 workouts를 출력합니다.

        });
      });

      routineList.assignAll(data);
    } catch (e) {
      print("데이터를 가져오는 중 에러가 발생했습니다: $e");
    }

  }
*/
  void fetchWorkouts2(String user, int order) async { // user와 order를 매개변수로 받음
    final url = Uri.https(
      'workout-timer-d62e6-default-rtdb.firebaseio.com', // DB엔드포인트
      'routines.json', //저장된 json 문서명
    );
    try {
      final response = await http.get(url); //DB에 요청을 보내서 받은 응답
      final routineData = jsonDecode(response.body) as Map<String, dynamic>; //응답의 body의 내용물을 Map형태로 변환
      print('response Map으로 변환 (routineData)');
      print(routineData);

      final List<Routine> data = [];
      routineData.forEach((key, value) {
        // 여기서 value는 리스트를 포함하는 Map입니다.
        // value를 리스트로 변환하여 처리합니다.
        List<dynamic> routinesList = value; // JSON 구조에 따라 적절히 형변환 필요
        routinesList.forEach((routineMap) {
          final routine = Routine.fromJson(routineMap);
          if(user == routine.user && order == routine.order) {
            routine.workouts.forEach((workout) {
              print('Workout Name: ${workout.workoutName.runtimeType}, Sets: ${workout.sets.runtimeType}, RestTime: ${workout.restTime.runtimeType}, IsActive: ${workout.isActive.runtimeType}');
              print(workout);
              print(routine);
              workoutList.assignAll(routine.workouts);
            });
          }
        });
      });

    } catch (e) {
      print("데이터를 가져오는 중 에러가 발생했습니다: $e");
    }
  }
}