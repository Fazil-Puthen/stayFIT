import 'package:flutter/material.dart';
import 'package:health_app/screens/adminscreen.dart';
import 'package:health_app/screens/setdietscreen.dart';
import 'package:health_app/widjets/widjets.dart';

import '../functions/db_goalfunctions.dart';
// import 'package:health_app/methods/db_methods.dart';
// import 'package:health_app/screens/goalscreen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });
  final space = const SizedBox(
    height: 10,
  );
  final gap = const Padding(padding: EdgeInsets.symmetric(horizontal: 40));

  TextEditingController namecontroller = TextEditingController();
  final agecontroller = TextEditingController();
  final heightcontroller = TextEditingController();
  final weightcontroller = TextEditingController();
  final admincontrolller = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  final _textkey=GlobalKey<FormState>();

  Widget textfield(
      String hint, TextEditingController control, TextInputType value,
      String? Function(String?) validator) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.black.withOpacity(.3))),
      controller: control,
      keyboardType: value,
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    getfoodlist();

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50),
        child: ListView(
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/logo.png'))),
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Let Us Know\n About You',
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
            space,
             Form(
              key: _textkey,
               child: Column(
                 children: [
                   textfield('name', namecontroller, TextInputType.text,(value){
                    if(value!.isEmpty){
                      return 'plaese enter a Name';
                    }
                    return null;
                             }),
            space,
            textfield('age', agecontroller, TextInputType.number,(value){
              int data=int.parse(value!);
              if(data>65 || data<18){
                 return 'The age should be between 18 and 65';
              }
              return null;
            }),
            space,
            textfield(
                'weight in kilograms', weightcontroller, TextInputType.number,(value){
                  int data=int.parse(value!);
                  if(data>200 || data<30){
                    return 'Your weight is not eligible to register';
                  }
                  return null;
                }),
            space,
            textfield('height in centimetres', heightcontroller,
                TextInputType.number,(value){
                  int data=int.parse(value!);
                  if(data>200 || data<90){
                    return 'Your height is not eligible to register';
                  }
                  return null;
                }) ]
               ),),
            space,
            space,
            ElevatedButton(
                onPressed: () {
                  if(_textkey.currentState!.validate()){

                  final username = namecontroller.text;
                  final age = agecontroller.text;
                  final height = heightcontroller.text;
                  final weight = weightcontroller.text;

                  if (username.isNotEmpty &&
                      age.isNotEmpty &&
                      height.isNotEmpty &&
                      weight.isNotEmpty) {
                    bottomsheet(context, age, height, weight);
                    // Navigator.of(context).push(MaterialPageRoute(builder:
                    // (ctx)=>GoalScreen()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('All the fields are required'),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      // padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(30),
                    ));
                  }
                }},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Next',
                      style: TextStyle(fontSize: 15),
                    ),
                    Icon(Icons.arrow_forward)
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
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
                                          hintText: 'password'),
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
                  child: const Text(
                    'Login as admin',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
            space,
            addTile(
                ' get active for 150 minutes a week – you can break this up into shorter sessions',
                Icons.run_circle),
            space,
            addTile(
                ' get active for 150 minutes a week – you can break this up into shorter sessions',
                Icons.run_circle)
          ],
        ),
      ),
    ));
  }

  Future<void> bottomsheet(BuildContext ctx, age, height, weight) async {
    showModalBottomSheet(
        context: ctx,
        builder: (ctx1) {
          return Container(
            width: double.infinity,
            height: 400,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.amber.shade400,
                      // spreadRadius: .5,
                      // blurRadius: .5,
                    ),
                  ], borderRadius: BorderRadius.circular(20)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'What is your Goal?',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                space,
                const Text(
                  "In order to know where you're headed,\n you must be aware of your own personal goals.",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                  textAlign: TextAlign.center,
                ),
                space,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        int selectedgoal = 1;
                        bottomsheet2(ctx1, selectedgoal, age, height, weight);
                      },
                      child: Container(
                          width: 200,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(width: 1)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.man,
                                color: Colors.red,
                                size: 40,
                              ),
                              Text(
                                'Weight Gain',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w400),
                              )
                            ],
                          )),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        int selectedgoal = 2;
                        bottomsheet2(ctx1, selectedgoal, age, height, weight);
                        //  Navigator.of(ctx1).pop();
                      },
                      child: Container(
                        width: 200,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.man_2_sharp,
                              color: Colors.green,
                              size: 40,
                            ),
                            Text(
                              'Weight Loss',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Future<void> bottomsheet2(
      BuildContext ctx, int selectedgoal, age, height, weight) async {
    showModalBottomSheet(
        context: ctx,
        builder: (ctx2) {
          return Container(
              height: 400,
              width: double.infinity,
              // color: Colors.red,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 50,
                    // color: Colors.amber.shade100,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.amber.shade400,
                        // spreadRadius: 5,
                        // blurRadius: 2
                      )
                    ], borderRadius: BorderRadius.circular(50)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "What's your biological sex?",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  space,
                  space,
                  space,
                  const Text(
                    'This can help us know your gender.\nWe need the this to calculate your body matrics',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                    textAlign: TextAlign.center,
                  ),
                  space,
                  space,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          double bmr = (10 * double.parse(weight)) +
                              (6.25 * double.parse(height)) -
                              (5 * double.parse(age)) +
                              5;
                          Navigator.of(ctx).push(MaterialPageRoute(
                              builder: (ctx1) => SetDiet(
                                    weight: weight,
                                    bodymass: bmr,
                                    selectedgoal: selectedgoal,
                                  )));
                        },
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.blue.shade200),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.male,
                                size: 40,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Male',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          double bmr = (10 * double.parse(weight)) +
                              (6.25 * double.parse(height)) -
                              (5 * double.parse(age)) -
                              161;
                          Navigator.of(ctx).push(MaterialPageRoute(
                              builder: (ctx3) => SetDiet(
                                    weight: weight,
                                    bodymass: bmr,
                                    selectedgoal: selectedgoal,
                                  )));
                        },
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              color: Colors.pink.shade200),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.female,
                                size: 40,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Female',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ));
        });
  }
}
