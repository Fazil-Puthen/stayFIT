import 'package:flutter/material.dart';
import 'package:health_app/functions/db_dailystatusfunction.dart';
import 'package:health_app/main.dart';
import 'package:health_app/screens/homescreen.dart';
import 'package:health_app/screens/planscreen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../functions/db_goalfunctions.dart';
import '../functions/db_mealfunctions.dart';
import '../models/dailymodel.dart';
import '../models/foodmodel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    gotoLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/logo.png'))),
        ),
      ),
    );
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(FoodModelAdapter().typeId)) {
      Hive.registerAdapter(FoodModelAdapter());
    }
    if (!Hive.isAdapterRegistered(DailyModelAdapter().typeId)) {
      Hive.registerAdapter(DailyModelAdapter());
    }
    getfoodlist();
    getmeallist();
    getdailystatusfeed();
    final sharedprefs = await SharedPreferences.getInstance();
    final userloggedin = sharedprefs.getBool(Logged);
    if (userloggedin == null || userloggedin == false) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen()));
    } else {
      final totalcalorie = sharedprefs.getDouble('totalcalorie');
      final days = sharedprefs.getInt('days');
      final selectedgoal = sharedprefs.getInt('selectedgoal');
      final weight = sharedprefs.getDouble('weight');
      final lenght = sharedprefs.getInt('length');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx2) => PlanScreen(
                totalcalorie: totalcalorie!,
                days: days!,
                selectedgoal: selectedgoal!,
                weight: weight!,
                lenght: lenght!,
              )));
    }
  }
}
