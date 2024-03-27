import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workout_timer/const/colors.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:workout_timer/screen/routine_select_test.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 130.0),
                Image.asset(
                  'assets/img/logo_truc.png',
                  width: 252.0,
                ),
                const SizedBox(height: 150.0),
                Container(
                  width: 260.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [COLOR_L, COLOR_R],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextButton(
                    onPressed: ()=> onGoogleLoginPress(context),
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
                          '구글 로그인',
                          style: TextStyle(
                            fontSize: 19.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
  onGoogleLoginPress(BuildContext context) async {
    // 구글 로그인 객체 생성
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    try{
      // signIn 함수를 실행해서 로그인을 진행합니다.
      GoogleSignInAccount? account = await googleSignIn.signIn();

      // AccessToken과 idToken을 가져올 수 있는 GoogleAignInAuthetication 객체를 불러옵니다.
      final GoogleSignInAuthentication? googleAuth = await account?.authentication;

      // AuthCredential 객체를 상속받는 GoogleAuthProvider 객체를 생성합니다. accessToken과 idToken만 제공하면 생성됩니다.
      final credential = GoogleAuthProvider.credential(
        accessToken:  googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      //signInWithCredential() 함수를 이용하면 파이어베이스 인증을 할 수 있습니다.
      await FirebaseAuth.instance.signInWithCredential(credential);

      //인증이 끝나면 홈 스크린으로 이동합니다.
      /*
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (_) => RoutineSelectTest(),
        ),
      );
       */
      Get.off(RoutineSelectTest());

      // 어떤 값을 반환받는지 출력하여 확인하기
      print(account);
    }catch(error){
      //로그인 에러가 나면 Snackbar를 보여줌
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 실패')),
      );
    }
  }
}