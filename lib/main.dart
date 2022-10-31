import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_saver/provider/BottomNavProvider.dart';
import 'package:status_saver/provider/GetStatusProvider.dart';
import 'package:status_saver/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>BottomNavProvider()),
      ChangeNotifierProvider(create: (_)=>GetStatusProvider())
    ],
    child: MaterialApp(
      title: 'Status Saver',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    ),
    );
  }
}

