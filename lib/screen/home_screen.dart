import 'package:flutter/material.dart';
import 'package:workout_timer/component/custom_text_field.dart';
import 'package:workout_timer/component/custom_int_field.dart';
import 'package:workout_timer/const/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Expanded(
            child: ListView(
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
                          const SizedBox(width: 2.0,),
                          Expanded(
                            child: Text(
                              '세트',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                            flex: 1,
                          ),
                          const SizedBox(width: 50.0,),
                          Expanded(
                            child: Text(
                              '운동 이름',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                            flex: 1,
                          ),
                          const SizedBox(width: 50.0,),
                          Expanded(
                            child: Text(
                              '휴식',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                            flex: 1,
                          ),
                          const SizedBox(width: 2.0,),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 11.0, left: 9.0, right: 9.0),
                  child: IntrinsicHeight(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 2.0,),
                          Expanded(
                            child: Text(
                              '세트',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                            flex: 1,
                          ),
                          const SizedBox(width: 50.0,),
                          Expanded(
                            child: Text(
                              '운동 이름',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                            flex: 1,
                          ),
                          const SizedBox(width: 50.0,),
                          Expanded(
                            child: Text(
                              '휴식',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                            flex: 1,
                          ),
                          const SizedBox(width: 2.0,),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 11.0, left: 9.0, right: 9.0),
                  child: IntrinsicHeight(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: COLOR_M,
                          width: 3.0,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 10.0,),
                          Expanded(
                            flex: 2,
                            child: CustomIntField(
                              label: '세트 수',
                              isSet: true,
                            ),
                          ),
                          const SizedBox(width: 10.0, height: 77,),
                          Expanded(
                            flex: 3,
                            child: CustomTextField(
                              label: '운동 이름',
                              isTitle: false,
                            ),
                          ),
                          const SizedBox(width: 10.0,),
                          Expanded(
                            flex: 2,
                            child: CustomIntField(
                              label: '휴식 시간',
                              isSet: false,
                            ),
                          ),
                          const SizedBox(width: 10.0,),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 11.0, left: 9.0, right: 9.0),
                  child: IntrinsicHeight(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: COLOR_M,
                          width: 3.0,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 10.0,),
                          Expanded(
                            flex: 2,
                            child: CustomIntField(
                              label: '세트 수',
                              isSet: true,
                            ),
                          ),
                          const SizedBox(width: 10.0, height: 77,),
                          Expanded(
                            flex: 3,
                            child: CustomTextField(
                              label: '운동 이름',
                              isTitle: false,
                            ),
                          ),
                          const SizedBox(width: 10.0,),
                          Expanded(
                            flex: 2,
                            child: CustomIntField(
                              label: '휴식 시간',
                              isSet: false,
                            ),
                          ),
                          const SizedBox(width: 10.0,),
                        ],
                      ),
                    ),
                  ),
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