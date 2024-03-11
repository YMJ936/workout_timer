import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuilderController extends GetxController{

  int rest = 0;
  int sets = 0;
  Timer timer = Timer(Duration.zero, () {});
  bool isTimerRunning = false;
  bool isActive = true;

  void startTimer() {
    if(isActive == true) {
      if (isTimerRunning == false) {
        isTimerRunning = true;
        sets = rest;
        timer = Timer.periodic(Duration(seconds: 1), (timer) {
          if (rest > 0) {
            rest--;
            print('휴식시간 : ${rest}');
            update();
          } else {
            resetRest();
            timer.cancel();
            isTimerRunning = false;
            if(sets > 0){
              sets++;
            } else {
              isActive = false;
              // 다음 인덱스의 isActive 활성화
            }
          }
        });
      } else {
        print('이미 실행중입니다.');
      }
    } else {
      print('비활성화 상태인 운동입니다.');
    }
  }

  void resetRest() {
    rest = 50;
    update();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}