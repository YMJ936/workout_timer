import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label; //텍스트 필드 제목
  final bool isTitle; // 루틴명인지 여부
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;

  const CustomTextField({
    required this.label,
    required this.isTitle,
    required this.onSaved,
    required this.validator,
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
            fontSize: isTitle ? 19.0 : 15.0,
          ),
        ),
        Expanded(
            child: TextFormField(
              onSaved: onSaved,
              validator: validator,
              cursorColor: Colors.grey,
              maxLines: 1, //최대  한줄
              keyboardType: TextInputType.multiline, //기본 숫자 키보드, 일반 글자 키보드
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.grey[300],
              ),
            ),
        ),
      ],
    );
  }
}