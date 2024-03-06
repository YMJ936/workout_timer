import 'package:workout_timer/const/colors.dart';
import 'package:flutter/material.dart';

class RoutineCardButton extends StatelessWidget {
  @override build(BuildContext context){
    return OutlinedButton(
      onPressed: () {},
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
                    child: _RoutineName(
                      routineName: '3분할 루틴',
                    ),
                  ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert,
                  size: 30.0,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      );
  }
}

class _RoutineName extends StatelessWidget {
  final String routineName; // 루틴 이름

  const _RoutineName({
    required this.routineName,
    Key? key,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 20.0,
      color: Colors.black87,
    );
    return Text(
      '${routineName}',
      style: textStyle,
    );
  }
}