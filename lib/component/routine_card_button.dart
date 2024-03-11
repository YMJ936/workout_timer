import 'package:workout_timer/const/colors.dart';
import 'package:flutter/material.dart';

class RoutineCardButton extends StatelessWidget {
  final String routineName; // 루틴 이름

  const RoutineCardButton({
    required this.routineName,
    Key? key,
  }) : super(key: key);

  @override build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 11.0, left: 9.0, right: 9.0),
      child: OutlinedButton(
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
                    child: Text(
                      '${routineName}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                        color: Colors.black87,
                      ),
                    )
                ),
              ),
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
                  ),
                ],
                icon: Icon(
                  Icons.more_vert,
                  size: 30.0,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

