import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class CustomIntField extends StatelessWidget {
  final String label; //텍스트 필드 제목
  final bool isSet; //세트인지 여부

  const CustomIntField({
    required this.label,
    required this.isSet,
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
          child: TextFormField(
            cursorColor: Colors.grey,
            maxLines: 1, //최대  한줄
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly,], // 숫자만 입력하도록 제한
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[300],
              suffixText: isSet ? '세트' : '초',
            ),
          ),
        ),
      ],
    );
  }
}