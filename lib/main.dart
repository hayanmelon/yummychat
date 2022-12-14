import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yummychat/screens/chat_screen.dart';
import 'screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  print('Start Program');
  WidgetsFlutterBinding.ensureInitialized();
  // 플러터 코어엔진을 초기화 해줘야 함, 플러터에서 파이어베이스 사용하려면
  // 메인메소드 내에서 비동기 방식으로 반드시 이 메소드를 먼저불러오고,
  // 그다음에 Firebase.initialiszeAPp 메소드를 불러와야함
  print('Await Firebase Initializing');
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDIHQ4DORWc7PyIX18fe-IaND-gx8qZ_uU",
      appId: "1:756394425078:android:014d28db9a630b54064ad7",
      messagingSenderId: "756394425078",
      projectId: "chat-app-b55cc",
    ),
  );
  print('Now, Run MyApp');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('  Widget build(BuildContext context) {');

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          print('snapshot : snapshot.hasData ${snapshot.hasData}');
          if (snapshot.hasData){
            return ChatScreen();
          }
          return LoginSignupScreen();
        },
      ),
    );
  }
}
