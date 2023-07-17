 import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

Future<void>tologgedout()async{
    final sharedprefs=await SharedPreferences.getInstance();
     await sharedprefs.setBool(Logged, false);
    await sharedprefs.remove('totalcalorie');
    await sharedprefs.remove('days');
    await sharedprefs.remove('selectedgoal');
    await sharedprefs.remove('weight');
    await sharedprefs.remove('length');
  }