import 'package:workout_timer/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:workout_timer/component/custom_int_field.dart';
import 'package:workout_timer/component/custom_text_field.dart';

class WorkoutMakingCard extends StatelessWidget {

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
    );
  }
}