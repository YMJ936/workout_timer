import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workout_timer/component/routine_card_button.dart';
import 'package:workout_timer/const/colors.dart';
import 'package:workout_timer/controller/workout_controller.dart';
import 'package:workout_timer/screen/create_test.dart';
import 'package:workout_timer/screen/workout_screen.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class RoutineSelectTest extends StatelessWidget {
  const RoutineSelectTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final WorkoutController workoutController = Get.put(WorkoutController(), permanent: false);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: COLOR_M,
        onPressed: () async {
          var result = await Get.to(
            CreateTest(),
            transition: Transition.downToUp,
          );
          if (result == 'refresh') {
            final WorkoutController workoutController = Get.find<WorkoutController>();
            workoutController.fetchWorkouts();
          }
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

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
      body: Column(
        children: [
          SizedBox(height: 11.0),
          Expanded(
            child: Obx(() {
              if (workoutController.routineList.isEmpty) {
                return Center(
                  child: Text(
                    "운동 루틴이 없습니다.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: workoutController.routineList.length,
                itemBuilder: (context, index) {
                  var routine = workoutController.routineList[index];

                  return Padding(

                    padding: const EdgeInsets.only(
                        bottom: 11.0, left: 9.0, right: 9.0),
                    child: OutlinedButton(
                      onPressed: () {
                        Get.off(
                          WorkoutScreen(user: routine.user, order: routine.order,),
                          transition: Transition.rightToLeft,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(16.0),
                        side: BorderSide(
                          width: 3.0,
                          color: COLOR_M,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            SizedBox(width: 50.0),
                            Expanded(
                              child: Center(
                                  child: Text(
                                    '${routine.routineName}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.0,
                                      color: Colors.black87,
                                    ),
                                  )
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Get.defaultDialog(
                                  title: '경고',
                                  middleText: '운동 루틴을 삭제하시겠습니까?',
                                  backgroundColor: Colors.white,
                                  //buttonColor: COLOR_M,
                                  onCancel: () => {}, // '취소' 버튼을 눌렀을 때의 동작
                                  onConfirm: () {
                                    // '확인' 버튼을 눌렀을 때 원하는 작업을 수행하세요.
                                    workoutController.DeleteRoutine(routine.user, routine.order);
                                    Get.back(); // 대화상자를 닫습니다.
                                  },
                                  textCancel: '아니오',
                                  textConfirm: '예',
                                  confirmTextColor: Colors.white,
                                );
                              },/*{
                                workoutController.DeleteRoutine(routine.user, routine.order);
                              },*/
                              icon: Icon(
                                Icons.close,
                                size: 27.0,
                                color: Colors.grey[600],
                              ),
                            ),
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

/*
  void DeleteRoutine(/*String user, int order*/) async {
    // 키값 구하는 로직
    String targetId = '-NtoxM8jsFkXU2VC701i';

    final url = Uri.https(
      'workout-timer-d62e6-default-rtdb.firebaseio.com', // DB엔드포인트
      'routines/$targetId.json', //저장될 json 문서명
    );
    await http.delete(url);
    print('삭제하기');
  }
 */
/* 버튼 백업
PopupMenuButton<String>(
                              onSelected: (String result) {},
                              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  value: 'update',
                                  child: Text('수정'),
                                ),
                                PopupMenuItem<String>(
                                  value: 'delete',
                                  child: Text('삭제'),
                                  onTap: () {
                                    workoutController.DeleteRoutine(routine.user, routine.order);
                                  },
                                ),
                              ],
                              icon: Icon(
                                Icons.more_vert,
                                size: 30.0,
                                color: Colors.grey[600],
                              ),
                            ),
 */
}