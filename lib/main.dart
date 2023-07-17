import 'package:flutter/material.dart';
import 'package:health_app/models/dailymodel.dart';
import 'package:health_app/models/foodmodel.dart';
import 'package:health_app/screens/homescreen.dart';
import 'package:health_app/screens/splash.dart';
import 'package:hive_flutter/adapters.dart';
const Logged='userloggedin';
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  // if (!Hive.isAdapterRegistered(FoodModelAdapter().typeId)) {
  //   Hive.registerAdapter(FoodModelAdapter());
  // }
  // if (!Hive.isAdapterRegistered(DailyModelAdapter().typeId)) {
  //   Hive.registerAdapter(DailyModelAdapter());
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:const SplashScreen(),
    );
  }
}
