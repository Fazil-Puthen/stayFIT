// import 'package:flutter/material.dart';



// Widget adminpopup(){
//    return SingleChildScrollView(
//                             child: AlertDialog(
//                               title: const Text('Add Food to weight gain list'),
//                               actions: [
//                                 Form(
//                                   key: _popupkey,
//                                   child: Column(
//                                     children: [
//                                       TextFormField(
//                                         decoration: const InputDecoration(
//                                             hintText: 'Your food here'),
//                                         keyboardType: TextInputType.name,
//                                         controller: foodcontroller,
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             return 'Mnadatory field';
//                                           }
//                                         },
//                                       ),
//                                       TextFormField(
//                                         decoration: const InputDecoration(
//                                             hintText: 'Calorie here'),
//                                         keyboardType: TextInputType.number,
//                                         controller: caloriecontroller,
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             return 'Mnadatory field';
//                                           }
//                                         },
//                                       ),
//                                       TextFormField(
//                                         decoration: const InputDecoration(
//                                             hintText: 'portion here'),
//                                         controller: potioncontroller,
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             return 'Mnadatory field';
//                                           }
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     TextButton(
//                                         onPressed: () {
//                                           Navigator.of(ctx).pop();
//                                         },
//                                         child: const Text('Cancel')),
//                                     ElevatedButton(
//                                         style: const ButtonStyle(
//                                             backgroundColor:
//                                                 MaterialStatePropertyAll(
//                                                     Colors.amber)),
//                                         onPressed: () {
//                                           if (_popupkey.currentState!
//                                               .validate()) {
//                                             onAddButton(selctedgoal: 1);
//                                             foodcontroller.clear();
//                                             caloriecontroller.clear();
//                                             Navigator.of(ctx).pop();
//                                           }
//                                         },
//                                         child: const Text('Add')),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           );
// }