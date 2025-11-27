import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_cluster/screen/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Настройка ориентации экрана
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Настройка системных UI элементов
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Cluster',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(),
    );
  }
}