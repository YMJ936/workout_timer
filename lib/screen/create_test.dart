import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:workout_timer/component/custom_text_field.dart';
import 'package:workout_timer/component/custom_int_field.dart';
import 'package:workout_timer/component/workout_making_card.dart';
import 'package:workout_timer/const/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:workout_timer/model/workout.dart';

class CreateTest extends StatefulWidget {
  const CreateTest({Key? key}) : super(key: key);

  @override
  State<CreateTest> createState() => _CreateTest();
}

class _CreateTest extends State<CreateTest> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final WorkoutMakingController controller = Get.put(WorkoutMakingController());

  String? routineName;
  final List<WorkoutMakingCard> workoutCards = []; // WorkoutMakingCard 리스트
  String? workoutName;
  int? restTime;
  int? setCount;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
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
          title: Text('운동 루틴 생성'),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22.0,
            color: Colors.white,
          ),
          centerTitle: true,
        ),
        body: Obx(() => Column(
          children: [
            SizedBox(height: 5.0,),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 11.0, left: 9.0, right: 9.0),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    const SizedBox(width: 30.0,),
                    Expanded(
                      child: CustomTextField(
                        onSaved: (String? val) {
                          routineName = val;
                        },
                        validator: nameValidator,
                        label: '루틴 이름',
                        isTitle: true,
                      ),
                    ),
                    const SizedBox(width: 30.0,),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.workoutCards.length + 1,
                itemBuilder: (context, index) {
                  if (index < controller.workoutCards.length) {
                    return controller.workoutCards[index];
                  } else {
                    return IconButton(
                      onPressed: () {
                        controller.addWorkoutCard();
                      },
                      icon: Icon(
                        Icons.add_circle_outline,
                        size: 80.0,
                      ),
                    );
                  }
                },
              ),
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
                    onSavePressed2();
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
                        '루틴 생성하기',
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
        ),
      ),
    );
  }

  void onSavePressed2() {
    List<Workout> workouts = [];
    formKey.currentState!.save();

    // 각 카드에서 데이터를 수집하여 리스트로 만듦
    for (var widget in controller.workoutCards) {
      if (widget is WorkoutMakingCard) { // widget이 WorkoutMakingCard 타입인지 확인
        String? workoutName = widget.getWorkoutName;
        int? setCount = widget.getSetCount;
        int? restTime = widget.getRestTime;


      if (workoutName != null && setCount != null && restTime != null) {
        workouts.add(
          Workout(
            workoutName: workoutName,
            sets: [
              SetInfo(
                setCount: setCount,
                restTime: restTime,
                isActive: false,
              ),
            ],
          ),
        );
      }
      }
    }

    print('리스트');
    print(workouts);
  }

  String? nameValidator(String? val) { //이름값 검증 ?는 해당 값이 null일 수도 있다고 나타내는 기호
    if(val == null) {
      return '이름을 입력해주세요';
    }

    return null;
  }
}

class WorkoutMakingController extends GetxController {
  RxList<Widget> workoutCards = <Widget>[].obs;

  void addWorkoutCard() {
    workoutCards.add(WorkoutMakingCard());
  }
}


void save() async { //post방식으로 realtime DB에 데이터 전송
  final url = Uri.https(
    'workout-timer-d62e6-default-rtdb.firebaseio.com', // DB엔드포인트
        'flutter-test3.json', //저장될 json 문서명
  );
  http.post(
    url,
    headers: {'Content_Type': 'application/json'},
    body: jsonEncode(
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
        }
    ),
  );


}