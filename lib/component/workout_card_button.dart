import 'package:workout_timer/const/colors.dart';
import 'package:flutter/material.dart';

class WorkoutCardButton extends StatelessWidget {
  final String name;
  final int set;
  final int rest;
  final bool isActive;

  const WorkoutCardButton({
    required this.name,
    required this.set,
    required this.rest,
    required this.isActive,
    Key? key,
  }) : super(key: key);

  @override build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 11.0, left: 9.0, right: 9.0),
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(15.0),
          side: BorderSide(
            width: 3.0,
            color: isActive ? COLOR_M : Colors.white,
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
                  '${set}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isActive ? Colors.black87 : Colors.grey[600],
                    fontSize: 20.0,
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isActive ? Colors.black87 : Colors.grey[600],
                    fontSize: 20.0,
                  ),
                ),
                flex: 3,
              ),
              Expanded(
                child: Text(
                  '${rest}초',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isActive ? Colors.black87 : Colors.grey[600],
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
  }
}