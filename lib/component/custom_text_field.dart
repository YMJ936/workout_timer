import 'package:flutter/services.dart';
import 'package:workout_timer/const/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label; //텍스트 필드 제목
  final bool isInt; //숫자인지 여부

  const CustomTextField({
    required this.label,
    required this.isInt,
    Key? key,
}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, // 세로로 텍스트와 텍스트 필드 매치
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 15.0,
          ),
        ),
        Expanded(
            flex: isInt ? 0 : 1, //뭐징?
            child: TextFormField(
              cursorColor: Colors.grey,
              maxLines: 1,
              //expands: isInt,
              keyboardType: isInt ? TextInputType.number : TextInputType.multiline,
              inputFormatters: isInt ? [FilteringTextInputFormatter.digitsOnly,] : [],
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.grey[300],
                suffixText: isInt ? '초' : null,
              ),
            ),
        ),
      ],
    );
  }
}