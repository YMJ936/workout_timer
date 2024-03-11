import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workout_timer/component/custom_text_field.dart';
import 'package:workout_timer/component/custom_int_field.dart';
import 'package:workout_timer/component/workout_card_button.dart';
import 'package:workout_timer/const/colors.dart';
import 'package:workout_timer/controller/getx_controller.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BuilderController()); //중복코드를 줄이기 위해 컨트롤러를 선언해둠
    
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
                        '세트',
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
                        '휴식',
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
            child: ListView(
              children: [
                WorkoutCardButton(
                  name: '덤벨 컬',
                  set: 4,
                  rest: 60,
                  isActive: false,
                ),
                WorkoutCardButton(
                    name: '컨센트레이션 컬',
                    set: 2,
                    rest: 39,
                    isActive: true,
                ),
                WorkoutCardButton(
                  name: '행잉 레그레이즈',
                  set: 0,
                  rest: 30,
                  isActive: false,
                ),
                GetBuilder<BuilderController>( // 왼쪽에 제네릭 안에 가져오고 싶은 컨트롤러를 넣으면 된다.
                    init: BuilderController(),
                    builder: (_) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 11.0, left: 9.0, right: 9.0),
                        child: OutlinedButton(
                          onPressed: () {
                            controller.startTimer();
                          },
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.all(15.0),
                            side: BorderSide(
                              width: 3.0,
                              color: COLOR_M,
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
                                    '세트',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Text(
                                    '운동 이름',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  flex: 3,
                                ),
                                Expanded(
                                  child: Text(
                                    '60초',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color:Colors.black87,
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
                ),
              ],
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
                onPressed: () {},
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