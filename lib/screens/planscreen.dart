import 'dart:async';

import 'package:flutter/material.dart';
import 'package:health_app/functions/db_dailystatusfunction.dart';
import 'package:health_app/functions/db_goalfunctions.dart';
import 'package:health_app/screens/dailystatusscreen.dart';
import 'package:health_app/screens/homescreen.dart';
import 'package:health_app/widjets/widjets.dart';
import 'package:health_app/functions/db_mealfunctions.dart';
import 'package:health_app/functions/planscreenfunction.dart';

import 'adminscreen.dart';

class PlanScreen extends StatefulWidget {
  final totalcalorie;
  late int days;
  final int selectedgoal;
  dynamic weight;
  PlanScreen(
      {super.key,
      required this.totalcalorie,
      required this.days,
      required this.selectedgoal,
      required this.weight});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  @override
  void initState() {
    super.initState();
    cleardailystatus();
    start();
  }

  void dispose() {
    start();
    super.dispose();
  }
  
 
  bool isnull = true;
  bool weekupdate = false;
  int week = 0;
  final weekupdatecontroller = TextEditingController();
  late double weekupdateweight;
  late double lastweekweight;
  final _formkey=GlobalKey<FormState>();
  final admincontrolller=TextEditingController();

  //timer
  int lenght = 0;
  Future<void> start() async {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      int weekcounter = lenght + 1;
      setState(() {
        // lunchnotifier.value;
        if (widget.days > 0) {
          widget.days--;
          sumcalorie(lenght);
          timeclear(context);
          if (weekcounter % 7 == 0) {
            isnull = !isnull;
          }
          lenght++;
        } else {
          timer.cancel();
        }
      });
    });
  }

  int? counter;
  double? progressweight;
  void newweekupdate(double progressweight, int counter) {
    setState(() {
      this.progressweight = progressweight;
      counter = this.counter = counter;
    });
  }

  @override
  Widget build(BuildContext context) {
     final screenSize = MediaQuery.of(context).size;
  final textScaleFactor = screenSize.width > 600 ? 1.5 : 1.0;
    final weight = double.parse(widget.weight);
    getmeallist();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber.shade400,
        title: const Text('Your Plan'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),

            //Plan exit button
            child: Row(
              children: [IconButton(onPressed: (){
                 showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return AlertDialog(
                            title: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Enter your password',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Form(
                                    key: _formkey,
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                          hintText: 'hint : pass',hintStyle: TextStyle(
                                            fontWeight: FontWeight.w700,fontSize: 20

                                          )),
                                      obscureText: true,
                                      validator: (value) {
                                        if (value == null || value != '1') {
                                          return 'please enter a valid password';
                                        }
                                        return null;
                                      },
                                      controller: admincontrolller,
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        // String name='fazil';
                                        // final admin=admincontrolller.text;

                                        if (_formkey.currentState!.validate()) {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (ctx) => Admin()));
                                          admincontrolller.clear();
                                        }
                                      },
                                      child: const Text(
                                        'Login',
                                        style: TextStyle(fontSize: 18),
                                      ))
                                ]),
                          );
                        });
              },
               icon: const Icon(Icons.admin_panel_settings)),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: const Text('EXIT PLAN'),
                                icon: const Icon(Icons.outbond),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'NO',
                                          style: TextStyle(fontSize: 20),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          clearHiveData();
                                          Navigator.of(context).pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder: (ctx) => HomeScreen()),
                                              (route) => false);
                                        },
                                        child: const Text(
                                          'YES',
                                          style: TextStyle(fontSize: 20),
                                        ))
                                  ],
                                ));
                          });
                    },
                    icon: const Icon(Icons.exit_to_app)),
              ],
            ),
          )
        ],

        // centerTitle: true,
      ),
      body: ListView(children: [
        SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Container(
              width: double.infinity,
              color: const Color.fromARGB(31, 117, 71, 71),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width *0.8,
                          height: MediaQuery.of(context).size.width *0.1,
                          decoration: BoxDecoration(
                              border: Border.all(width: .3,),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              'Eat upto ${widget.totalcalorie} calorie a day',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 199, 15, 1)),
                            ),
                          ),
                        )
                      ],
                    ),
                    box,
                    //section for user weekly update
                    Card(
                      child: isnull == true
                          ? null
                          : Container(
                              height: 100,
                              child: Column(children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      controller: weekupdatecontroller,
                                      decoration: const InputDecoration(
                                          hintText:
                                              'enter your current weight'),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            weekupdateweight = double.parse(
                                                weekupdatecontroller.text);
                                                lastweekweight=weekupdateweight;
                                            week++;
                                            isnull = true;
                                            weekupdate = true;
                                          });
                                        },
                                        child: const Text('Update'))
                                  ],
                                )
                              ])),
                    ),
                    // weekly update section
                    Card(
                      elevation: 20,
                      child: weekupdate == false
                          ? null
                          : Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Column(
                                    children: [ Text(
                                        'Your were initially ${widget.weight} Kg',
                                        style:  TextStyle(
                                          fontSize: 15*textScaleFactor,
                                        ),
                                      ),
                                      Text(
                                        'Your current weight after $week week is $weekupdateweight Kg',
                                        style:  TextStyle(
                                          fontSize: 15*textScaleFactor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: (ctx) =>
                                      //             WeeklyStatus()));
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      'You were ${widget.weight} Kg')
                                                ],
                                              ),
                                              content: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      'current weight is $weekupdateweight'),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    icon: Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.black, width: 1)),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.list,
                                            size: 30,
                                            color: Colors.red,
                                          ),
                                          Text(
                                            'Status',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w300),
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                    ),
                    box,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Days Remaining: ${widget.days}',
                          style: const TextStyle(fontSize: 20),
                        )
                      ],
                    ),

                    box,
                    cardtile(
                        'Breakfast',
                        widget.totalcalorie / 3,
                        context,
                        widget.selectedgoal,
                        "The calorie totals are listed next to each meal so you can easily swap things in and out as you see fit. Couple this healthy meal plan with daily exercise and you're on track"),

                    box,
                    cardtile(
                        'Lunch',
                        widget.totalcalorie / 3,
                        context,
                        widget.selectedgoal,
                        'There is no single best meal plan for weight loss. However, adopting a diet rich in whole foods and limiting processed foods is a good starting point.'),

                    box,
                    cardtile(
                        'Dinner',
                        widget.totalcalorie / 3,
                        context,
                        widget.selectedgoal,
                        'A healthy eating plan gives your body the nutrients it needs every day while staying within your daily calorie goal for weight loss.'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Your target time:${widget.days.toStringAsFixed(0)} days',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),

                    box,
                    const Text(
                      ' Tracker',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                    ),
                    //day update section
                    SizedBox(
                      height: 100,
                      child: Center(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: lenght,
                            itemBuilder: ((BuildContext context, index) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            content: DailyStatus(index: index)
                                            // Column(
                                            //   children: [
                                            //     Expanded(
                                            //       child: Column(
                                            //         children: [
                                            //           Container(
                                            //             height: 30,
                                            //             width: double.infinity,
                                            //             decoration: BoxDecoration(
                                            //                 borderRadius:
                                            //                     BorderRadius
                                            //                         .circular(10),
                                            //                 color: Colors.amber),
                                            //             child: Center(
                                            //               child: Text(
                                            //                 'Day $index',
                                            //                 style:
                                            //                     const TextStyle(
                                            //                         fontSize: 25),
                                            //               ),
                                            //             ),
                                            //           ),
                                            //           box,
                                            //           const Text('Breakfast',
                                            //               style: TextStyle(
                                            //                 fontSize: 30,
                                            //                 color: Color.fromARGB(
                                            //                     255, 5, 79, 141),
                                            //               )),
                                            //           const SizedBox(
                                            //             height: 5,
                                            //           ),
                                            //           track('protein', 300),
                                            //           box,
                                            //           track('calorie', 564),
                                            //           box,
                                            //           track('fat', 300),
                                            //           box,
                                            //           const Text('Lunch',
                                            //               style: TextStyle(
                                            //                 fontSize: 30,
                                            //                 color: Color.fromARGB(
                                            //                     255, 5, 79, 141),
                                            //               )),
                                            //           const SizedBox(
                                            //             height: 5,
                                            //           ),
                                            //           track('protein', 230),
                                            //           box,
                                            //           track('calorie', 650),
                                            //           box,
                                            //           track('fat', 289),
                                            //           box,
                                            //           const Text('Dinner',
                                            //               style: TextStyle(
                                            //                 fontSize: 30,
                                            //                 color: Color.fromARGB(
                                            //                     255, 5, 79, 141),
                                            //               )),
                                            //           const SizedBox(
                                            //             height: 5,
                                            //           ),
                                            //           track('protein', 230),
                                            //           box,
                                            //           track('calorie', 650),
                                            //           box,
                                            //           track('fat', 289),
                                            //         ],
                                            //       ),
                                            //     ),
                                            //     TextButton(
                                            //         onPressed: () {
                                            //           Navigator.of(context).pop();
                                            //         },
                                            //         child: const Text(
                                            //           'Close',
                                            //           style:
                                            //               TextStyle(fontSize: 25),
                                            //         ))
                                            //   ],
                                            // ),
                                            );
                                      });
                                },
                                child: Card(
                                  elevation: 1,
                                  child: Container(
                                    width: 100,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.amber),
                                    // color: Colors.amber,
                                    margin: EdgeInsets.all(5),
                                    child: Center(
                                      child: Text(
                                        'Day ${index + 1}',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })),
                      ),
                    ),
                    box,
                    Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromARGB(255, 243, 138, 130)),
                      width: double.infinity,
                      height: 50,
                      child: Center(
                        child: Text(
                          'Your initial weight-$weight',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),

                    box,

                    // const Text(
                    //   ' Progress',
                    //   style:
                    //       TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                    // ),
                    // Container(
                    //   width: double.infinity,
                    //   height: 100,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       color: Colors.amber.shade300),
                    //   child: Center(
                    //       child: Column(
                    //     children: [
                    //       Text(
                    //         'your current weight -$weight ',
                    //         style: const TextStyle(fontSize: 20),
                    //       ),
                    //     ],
                    //   )),
                    // ),
                  ],
                ),
              )),
        )),
      ]),
    );
  }
}
