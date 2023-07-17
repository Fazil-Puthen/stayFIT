import 'package:flutter/material.dart';
import 'package:health_app/screens/detailscreen.dart';
import 'package:health_app/screens/searchscreen.dart';

const box = SizedBox(
  height: 20,
);

Widget cardtile(String meal, double cal, BuildContext context, int selectedgoal,
    String quote) {
  final screenSize = MediaQuery.of(context).size;
  final textScaleFactor = screenSize.width > 600 ? 1.5 : 1.0;
  String calorie = cal.toStringAsFixed(0);
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => DetailScreen(
                mealtime: meal,
              )));
    },
    child: Card(elevation: 20,shadowColor: const  Color.fromARGB(255, 243, 138, 130),
      child: Container(
        height: 150,
        // shadowColor: Colors.yellow,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.amber.shade300),
    
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      meal,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '$calorie cal',
                      style: const TextStyle(
                          fontSize: 20, color: Color.fromARGB(255, 143, 6, 20)),
                    )
                  ]),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              indent: 10,
              endIndent: 10,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Add button
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => SearchScreen(
                                  selectedgoal: selectedgoal,
                                  mealtime: meal,
                                )));
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.add),
                          Text(
                            'ADD',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ))
                ],
              ),
            ),
            const Divider(height: 1, thickness: 1),
            const SizedBox(
              height: 4,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width *0.9,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Wrap(
                  children: [
                    Text(
                      quote,
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: Colors.black,fontSize: 11.5*textScaleFactor),
                      softWrap: true,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

//widjet to add calorie if user adds food
Widget track(String cal, int num) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$cal - ',
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            num.toString(),
            style: const TextStyle(fontSize: 20),
          )
        ],
      )
    ],
  );
}

//Home page ad tile
Widget addTile(String content, ikon) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.shade100,
                border: Border.all(width: .1, color: Colors.black)),
            width: 150,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  ikon,
                  color: Colors.red,
                  size: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9),
                  child: Text(
                    content,
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red.shade50,
                border: Border.all(width: .1, color: Colors.black)),
            width: 150,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  ikon,
                  size: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9),
                  child: Text(
                    content,
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    ],
  );
}

