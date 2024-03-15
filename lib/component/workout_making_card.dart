import 'package:workout_timer/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:workout_timer/component/custom_int_field.dart';
import 'package:workout_timer/component/custom_text_field.dart';

class WorkoutMakingCard extends StatelessWidget {

  String? workoutName;
  int? restTime;
  int? sets;

  String? get getWorkoutName => workoutName;
  int? get getRestTime => restTime;
  int? get getSets => sets;

  @override build(BuildContext context) {
    return Padding(
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
                  onSaved: (String? val) {
                    sets = int.parse(val!);
                  },
                  validator: setValidator,
                  label: '세트 수',
                  isSet: true,
                ),
              ),
              const SizedBox(width: 10.0, height: 77,),
              Expanded(
                flex: 3,
                child: CustomTextField(
                  onSaved: (String? val) {
                    workoutName = val;
                  },
                  validator: nameValidator,
                  label: '운동 이름',
                  isTitle: false,
                ),
              ),
              const SizedBox(width: 10.0,),
              Expanded(
                flex: 2,
                child: CustomIntField(
                  onSaved: (String? val) {
                    restTime = int.parse(val!);
                  },
                  validator: restValidator,
                  label: '휴식 시간',
                  isSet: false,
                ),
              ),
              const SizedBox(width: 10.0,),
            ],
          ),
        ),
      ),
    );
  }

  String? nameValidator(String? val) { //이름값 검증 ?는 해당 값이 null일 수도 있다고 나타내는 기호
    if(val == null) {
      return '이름을 입력해주세요';
    }

    return null;
  }

  String? setValidator(String? val) { //세트 수값 검증
    if(val == null) {
      return '세트 수를 입력해주세요';
    }

    int? number;

    try {
      number = int?.parse(val);
    } catch (e) {
      return '숫자를 입력해주세요';
    }

    if (number < 0) {
      return '0이상의 숫자를 입력해주세요';
    }

    return null;
  }

  String? restValidator(String? val) { //휴식 시간값 검증
    if(val == null) {
      return '휴식 시간을 입력해주세요';
    }

    int? number;

    try {
      number = int?.parse(val);
    } catch (e) {
      return '숫자를 입력해주세요';
    }

    if (number < 0) {
      return '0이상의 숫자를 입력해주세요';
    }

    return null;
  }

}