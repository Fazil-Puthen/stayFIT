// import 'package:flutter/material.dart';
// import 'package:health_app/functions/db_mealfunctions.dart';
// import 'package:health_app/screens/searchscreen.dart';

// import 'detailscreen.dart';

// class cardWidjet extends StatefulWidget {
//   final String meal;
//   final double cal;
//   final BuildContext context;
//   // final double? totalcalorie;
//   final int selectedgoal;
//   final String quote;
//   const cardWidjet(
//       {super.key,
//       required this.meal,
//       required this.cal,
//       required this.context,
//       // this.totalcalorie,
//       required this.selectedgoal,
//       required this.quote});

//   @override
//   State<cardWidjet> createState() => _cardWidjetState();
// }

// class _cardWidjetState extends State<cardWidjet> {
//   @override
//   Widget build(BuildContext context) {
//     String calorie = widget.cal.toStringAsFixed(0);
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(MaterialPageRoute(
//             builder: (ctx) => DetailScreen(
//                   mealtime: widget.meal,
//                 )));
//       },
//       child: Container(
//         height: 150,
//         // shadowColor: Colors.yellow,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: Colors.amber.shade300),

//         child: Column(
//           children: [
//             const SizedBox(
//               height: 15,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       widget.meal,
//                       style: const TextStyle(
//                         fontSize: 20,
//                       ),
//                     ),
//                     Text(
//                       '$calorie cal',
//                       style: const TextStyle(
//                           fontSize: 20, color: Color.fromARGB(255, 143, 6, 20)),
//                     )
//                   ]),
//             ),
//             const Divider(
//               height: 1,
//               thickness: 1,
//               indent: 10,
//               endIndent: 10,
//               color: Colors.grey,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     '${widget.totalcalorie} of $calorie cal',
//                     style: const TextStyle(fontSize: 20),
//                   ),

//                   //Add button
//                   TextButton(
//                       onPressed: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (ctx) => SearchScreen(
//                                   selectedgoal: widget.selectedgoal,
//                                   mealtime: widget.meal,
//                                 )));
//                       },
//                       child: const Row(
//                         children: [
//                           Icon(Icons.add),
//                           Text(
//                             'ADD',
//                             style: TextStyle(fontSize: 20),
//                           )
//                         ],
//                       ))
//                 ],
//               ),
//             ),
//             const Divider(height: 1, thickness: 1),
//             const SizedBox(
//               height: 4,
//             ),
//             Container(
//               width: double.infinity,
//               height: 50,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 5),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.quote,
//                       textAlign: TextAlign.start,
//                       style: const TextStyle(color: Colors.black),
//                     )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
