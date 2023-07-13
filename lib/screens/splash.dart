import 'package:flutter/material.dart';
import 'package:health_app/screens/homescreen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../models/dailymodel.dart';
import '../models/foodmodel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState(){
    gotoLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(width: MediaQuery.of(context).size.width*0.8,
        height: MediaQuery.of(context).size.height*0.8,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/logo.png'))),
              child: const Center(child:  Text('please wait while initializing')),
        ),
      ),
    );
  }
  Future<void> gotoLogin() async {
    Future.delayed(const Duration(seconds: 5));
      WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(FoodModelAdapter().typeId)) {
    Hive.registerAdapter(FoodModelAdapter());
  }
  if (!Hive.isAdapterRegistered(DailyModelAdapter().typeId)) {
    Hive.registerAdapter(DailyModelAdapter());
  }
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen()));
  }
}


