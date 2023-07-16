// import 'package:flutter/material.dart';
// import 'package:health_app/screens/weekly_status.dart';


// int counter = 0;
// Future sevendayspopup(BuildContext context, dynamic weight) {
//   double finalweight = double.parse(weight);
//   final weightprogress = TextEditingController();
//   counter++;
//   return showDialog(
//     context: context,
//     builder: (BuildContext ctx2) {
//       return AlertDialog(
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'You completed $counter week',
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//         content: const Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'let us know your progress',
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//         actions: [
//           TextField(
//             controller: weightprogress,
//             decoration: const InputDecoration(
//                 hintText: 'enter your current weight here'),
//           ),
//           TextButton(
//               onPressed: () async {
//                 // final double progress = double.parse(weightprogress.text);
//                 // await weeklystatus(context, progress, counter, finalweight);
//                 // print('this is sevendays progress $progress');
//                 // print('this is seven days counter $counter');

//                 Navigator.of(ctx2).pop();
//               },
//               child: const Text(
//                 'save',
//                 style: TextStyle(fontSize: 20),
//               ))
//         ],
//       );
//     },
//   );
// }

// // Widget progresstrack(double weight, {int? counter}) {
// //   print('this is the weight $weight');
// //   print('this is counter $counter');
// //   return Container(
// //     width: double.infinity,
// //     height: 100,
// //     decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(10), color: Colors.amber.shade300),
// //     child: Center(
// //         child: Column(
// //       children: [
// //         Text(
// //           'your current weight -$weight ',
// //           style: const TextStyle(fontSize: 20),
// //         ),
// //         Text(counter != null ? 'weight after $counter week- $weight' : "hello"),
// //       ],
// //     )),
// //   );
// // }
// double currentweight = 0;
// Future weeklystatus(BuildContext context, double presentweight, int counter,
//     double initialweight) {
//   if (counter == 1) {
//     if (initialweight > presentweight) {
//       currentweight = initialweight - presentweight;
//     } else {
//       currentweight = presentweight - initialweight;
//     }
//   } else {
//     if (currentweight > presentweight) {
//       currentweight = currentweight - presentweight;
//     } else {
//       currentweight = presentweight - currentweight;
//     }
//   }
//   return showDialog(
//       context: context,
//       builder: (BuildContext ctx3) {
//         return AlertDialog(
//           title: Text(
//               initialweight > presentweight || currentweight > presentweight
//                   ? ' You lost $currentweight'
//                   : 'You gained $currentweight'),
//           actions: [
//             TextButton(
//                 onPressed: () {
//                   Navigator.pop(ctx3);
//                 },
//                 child: const Text('Close'))
//           ],
//         );
//       });
// }
