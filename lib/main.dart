import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  print('Start Program');
  WidgetsFlutterBinding.ensureInitialized();
  // 플러터 코어엔진을 초기화 해줘야 함, 플러터에서 파이어베이스 사용하려면
  // 메인메소드 내에서 비동기 방식으로 반드시 이 메소드를 먼저불러오고,
  // 그다음에 Firebase.initialiszeAPp 메소드를 불러와야함
  print('Await Firebase Initializing');
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginSignupScreen(),
    );
  }
}
