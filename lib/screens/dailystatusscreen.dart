import 'package:flutter/material.dart';
import 'package:health_app/functions/db_dailystatusfunction.dart';

import '../models/dailymodel.dart';

class DailyStatus extends StatelessWidget {
  final int index;
  const DailyStatus({super.key, required this.index});

  final box = const SizedBox(
    height: 10,
  );
  final box2 = const SizedBox(
    height: 50,
  );

  final style1 = const TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder(
        valueListenable: dailynotifier,
        builder: (context1, List<DailyModel> dailymodel, child) {
          final data = dailymodel[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              box2,
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Daily status feed',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              box,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 150,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 247, 91, 80),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        'Day ${data.day + 1}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
              box2,
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Calorie consumed for each meal',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              box,
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Breakfast',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(' ${data.breakfast.toString()} calorie',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  box,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Lunch',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(' ${data.lunch.toString()} calorie',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  box,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Dinner',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        ' ${data.dinner.toString()} calorie',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
              // const SizedBox(height: 50),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total calorie consumed -',
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      ' ${data.dailytotal.toString()}calorie',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context1);
                  },
                  child: const Text(
                    'Close',
                    style: TextStyle(fontSize: 25),
                  ))
            ],
          );
        },
      ),
    );
  }
}
