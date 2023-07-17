import 'package:flutter/material.dart';
import 'package:health_app/screens/planscreen.dart';

class SetDiet extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables

  final space = const SizedBox(
    height: 10,
  );
  final double weight;
  final double bodymass;
  final int selectedgoal;

  final targetweight = TextEditingController();
  final dietkey = GlobalKey<FormState>();

  SetDiet(
      {super.key,
      required this.bodymass,
      required this.selectedgoal,
      required this.weight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
          title: const Text('Set Target'),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: SafeArea(
          child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    space,
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'BMR: ${bodymass.toString()}',
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                          const Text('Basal Metabloic Rate')
                        ],
                      ),
                    ),
                    space,
                    space,
                    space,
                    const Expanded(
                      child: SizedBox(),
                    ),
                    space,
                    space,
                    const Text(
                      'Your Target Weight',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                    ),
                    space,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: Form(
                        key: dietkey,
                        child: TextFormField(
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                          controller: targetweight,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a target weight';
                            }
                            int data = int.parse(value);
                            if (data > 10 || data < 1) {
                              return 'target should be between 1 to 10';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              hintText: 'weight in kilograms'),
                        ),
                      ),
                    ),
                    space,
                    space,
                    const Expanded(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 60),
                          child: Text(
                            'This app recommends gaining/reducing 500grams per week,more than that needs a healthcare assistance',
                            style: TextStyle(),
                            textAlign: TextAlign.start,
                          )),
                    ),
                    SizedBox(
                      width: 100,
                      height: 80,
                      child: 
                      FloatingActionButton(
                          onPressed: () {
                            if (dietkey.currentState!.validate()) {
                              int lenght=0;
                              final tarweight = targetweight.text;
                              double tweight = double.parse(tarweight);
                              double days = (tweight / .5) * 7;

                              double additionalcalorie = 3850 / 7;
                              double totalcalorie = selectedgoal == 1
                                  ? bodymass + additionalcalorie
                                  : bodymass - additionalcalorie;

                              FocusScope.of(context).unfocus();
                              Future.delayed(const Duration(seconds: 1), () {
                                // checklogin();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (ctx1) => PlanScreen(
                                            totalcalorie: totalcalorie,
                                            days: days.toInt(),
                                            selectedgoal: selectedgoal,
                                            weight: weight,
                                            lenght: lenght,)),
                                    (route) => false);
                              });
                            }
                          },
                          child: const Text(
                            'Prepare plan',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          )),
                    )
                  ])),
        ));
  }
}
