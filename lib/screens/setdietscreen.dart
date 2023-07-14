import 'package:flutter/material.dart';
import 'package:health_app/screens/planscreen.dart';
import 'package:flutter/services.dart';

class SetDiet extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables

  final space = const SizedBox(
    height: 10,
  );
  final dynamic weight;
  final double bodymass;
  final int selectedgoal;

  final targetweight = TextEditingController();

  SetDiet(
      {super.key,
      required this.bodymass,
      required this.selectedgoal,
      required this.weight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(title: const Text('Set Target'),
      centerTitle: true,),
        body: SafeArea(
      child: Container(
          height: double.infinity,
          width: double.infinity,
          // color: Colors.red,
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.6,
                  height: 50,
                  // color: Colors.amber.shade100,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                    BoxShadow(
                        color: Colors.amber.shade400,
                        spreadRadius: 2,
                        blurRadius: 1)
                  ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'BMR: ${bodymass.toString()}',
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                     const  Text('Basal Metabloic Rate')

                    ],
                  ),
                ),
                space,
                space,
                space,
                const Expanded(
                  child: SizedBox(),
                  // child: Text(
                  //   'This will help us know about your goal, and prepare a plan for you accordingly',
                  //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  //   textAlign: TextAlign.center,
                  // ),
                ),
                space,
                space,
                const Text(
                  'Your Target Weight',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                ),
                space,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: targetweight,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        hintText: 'weight in kilograms'),
                  ),
                ),
                space,
                space,
                const Expanded(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'This app recommends gaining/reducing 500grams per week,more than that needs a healthcare assistance',
                        style: TextStyle(),
                        textAlign: TextAlign.start,
                      )),
                ),
                // const SizedBox(height: 100,),
                // Expanded(
                //   child: Column(children: [
                //      Row(mainAxisAlignment: MainAxisAlignment.center,
                //     children: [Text('Your Basal Metabolic Rate: ${bodymass.toString()}',style:const  TextStyle(fontSize: 23),)],),

                //   const Row(mainAxisAlignment: MainAxisAlignment.center,
                //   children: [Text(' Basal Metabolic Rate represents the number of\n calories your body needs to maintain basic\n physiological functions at rest, such as breathing,\n circulating blood, regulating body temperature,\n and supporting organ functions.',
                //   style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300),textAlign: TextAlign.center,)],),]),
                // ),
                Container(
                  width: 100,
                  height: 80,
                  child: FloatingActionButton(
                      // style: const ButtonStyle(
                      //     backgroundColor:
                      //         MaterialStatePropertyAll(Colors.amber)),
                      onPressed: () {
                        final tarweight = targetweight.text;
                        double tweight = double.parse(tarweight);
                        double days = (tweight / .5) * 7;

                        double additionalcalorie = 3850 / 7;
                        double totalcalorie = selectedgoal == 1
                            ? bodymass + additionalcalorie
                            : bodymass - additionalcalorie;

                        FocusScope.of(context).unfocus();
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx1) => PlanScreen(
                                    weight: weight,
                                    totalcalorie: totalcalorie,
                                    days: days.toInt(),
                                    selectedgoal: selectedgoal,
                                  )));
                        });
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
