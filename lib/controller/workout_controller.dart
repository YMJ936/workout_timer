import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workout_timer/component/workout_making_card.dart';
import 'package:workout_timer/model/routine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WorkoutController extends GetxController { //getx컨트롤러
  var workoutList = <Workout>[].obs; //변수 선언 + .obs를 통해 관찰가능해짐
  var routineList = <Routine>[].obs; // Routine 객체들을 저장할 리스트를 추가
  bool isTimerRunning = false;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() { //getx 컨트롤러가 초기화 될 때 호출됨(생성자?)
    super.onInit();
    fetchWorkouts();
  }

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

      //final user = FirebaseAuth.instance.currentUser;

      final List<Routine> data = [];
      routineData.forEach((key, value) {

        List<dynamic> routinesList = value; // JSON 구조에 따라 적절히 형변환 필요
        routinesList.forEach((routineMap) {
          final routine = Routine.fromJson(routineMap);
          if (routine.user == user!.email) { // routine.user가 'user1'인 경우에만 리스트에 추가
            data.add(routine);
          }
          /*
          if(user == routine.user && order == routine.order) {
            routine.workouts.forEach((workout) {
              workoutList.assignAll(routine.workouts);
            });
          }
           */
          // 여기서 routine의 workouts를 출력합니다.

        });
      });

      routineList.assignAll(data);
    } catch (e) {
      print("데이터를 가져오는 중 에러가 발생했습니다: $e");
    }
  }

  void DeleteRoutine(String user, int order) async {

    String resultKey = '';

    final url1 = Uri.https(
      'workout-timer-d62e6-default-rtdb.firebaseio.com', // DB엔드포인트
      'routines.json', //저장될 json 문서명
    );

    final response = await http.get(url1);
    final routineData = jsonDecode(response.body) as Map<String, dynamic>;

    routineData.forEach((key, value) {
      List<dynamic> routinesList = value;
      routinesList.forEach((routineMap) {
        if (routineMap['user'] == user && routineMap['order'] == order) {
          resultKey = key;
        }
      });
    });


    final url2 = Uri.https(
      'workout-timer-d62e6-default-rtdb.firebaseio.com', // DB엔드포인트
      'routines/$resultKey.json', //저장될 json 문서명
    );
    await http.delete(url2);
    fetchWorkouts();
  }


/*
  void fetchRoutines() async {
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
      //update();
      //refresh();
    } catch (e) {
      print("데이터를 가져오는 중 에러가 발생했습니다: $e");
    }
  }

 */
void save(jd) async { //post방식으로 realtime DB에 데이터 전송
  final url = Uri.https(
    'workout-timer-d62e6-default-rtdb.firebaseio.com', // DB엔드포인트
    'routines.json', //저장될 json 문서명
  );

  await http.post(
    url,
    headers: {'Content_Type': 'application/json'},
    body: jsonEncode(jd),
  );
  fetchWorkouts();
  }
}