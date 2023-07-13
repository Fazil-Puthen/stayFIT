import 'dart:io';

import 'package:flutter/material.dart';
import 'package:health_app/models/foodmodel.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:health_app/screens/homescreen.dart';
import '../functions/db_goalfunctions.dart';
import 'adminlist.dart';

class Admin extends StatefulWidget {
  Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final picker = ImagePicker();

  File? imagefile;

  final foodcontroller = TextEditingController();

  final caloriecontroller = TextEditingController();

  final potioncontroller = TextEditingController();

  Future<void> imagepick() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        imagefile = File(pickedFile.path);
      }
    });
  }

  final _popupkey = GlobalKey<FormState>();
  bool islossnull = false;
  bool isgainnull=false;
  void change(int value) {
    setState(() {
      if(value==1){
      islossnull=false;
      isgainnull = !isgainnull;}
      else {
        isgainnull=false;
       islossnull=!islossnull;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
        backgroundColor: Colors.amber,
        centerTitle: true,
        actions: const [Icon(Icons.exit_to_app)],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 1, 78, 142),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                    child: const Text('Add Food to weight gain',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    onPressed: () {
                      change(1);
      
                      // showDialog(
                      //     context: context,
                      //     builder: (ctx) {
                      //       return SingleChildScrollView(
                      //         child: AlertDialog(
                      //           title: const Text('Add Food to weight gain list'),
                      //           actions: [
                      //             Form(
                      //               key: _popupkey,
                      //               child: Column(
                      //                 children: [
                      //                   // Row(
                      //                   //   mainAxisAlignment: MainAxisAlignment.center,
                      //                   //   children: [
                      //                   //     GestureDetector(
                      //                   //       onTap: () {
                      //                   //         imagepick();
                      //                   //       },
                      //                   //       child: CircleAvatar(
                      //                   //         backgroundImage: imagefile == null
                      //                   //             ? const AssetImage('assets/logo.png')
                      //                   //                 as ImageProvider
                      //                   //             : FileImage(imagefile!)
                      //                   //                 as ImageProvider,
                      //                   //         backgroundColor: Colors.transparent,
                      //                   //         radius: 80,
                      //                   //         child: const Center(
                      //                   //           child: Text('Add image'),
                      //                   //         ),
                      //                   //       ),
                      //                   //     ),
                      //                   //   ],
                      //                   // ),
                      //                   TextFormField(
                      //                     decoration: const InputDecoration(
                      //                         hintText: 'Your food here'),
                      //                     keyboardType: TextInputType.name,
                      //                     controller: foodcontroller,
                      //                     validator: (value) {
                      //                       if (value!.isEmpty) {
                      //                         return 'Mnadatory field';
                      //                       }
                      //                       return null;
                      //                     },
                      //                   ),
      
                      //                   TextFormField(
                      //                     decoration: const InputDecoration(
                      //                         hintText: 'Calorie here'),
                      //                     keyboardType: TextInputType.number,
                      //                     controller: caloriecontroller,
                      //                     validator: (value) {
                      //                       if (value!.isEmpty) {
                      //                         return 'Mnadatory field';
                      //                       }
                      //                       return null;
                      //                     },
                      //                   ),
                      //                   TextFormField(
                      //                     decoration: const InputDecoration(
                      //                         hintText: 'portion here'),
                      //                     controller: potioncontroller,
                      //                     validator: (value) {
                      //                       if (value!.isEmpty) {
                      //                         return 'Mnadatory field';
                      //                       }
                      //                       return null;
                      //                     },
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //             const SizedBox(height: 10),
                      //             Row(
                      //               mainAxisAlignment: MainAxisAlignment.end,
                      //               children: [
                      //                 TextButton(
                      //                     onPressed: () {
                      //                       foodcontroller.clear();
                      //                       caloriecontroller.clear();
                      //                       potioncontroller.clear();
                      //                       Navigator.of(ctx).pop();
                      //                     },
                      //                     child: const Text('Cancel')),
                      //                 ElevatedButton(
                      //                     style: const ButtonStyle(
                      //                         backgroundColor:
                      //                             MaterialStatePropertyAll(
                      //                                 Colors.amber)),
                      //                     onPressed: () {
                      //                       if (_popupkey.currentState!
                      //                           .validate()) {
                      //                         onAddButton(selctedgoal: 1);
                      //                         foodcontroller.clear();
                      //                         caloriecontroller.clear();
                      //                         potioncontroller.clear();
                      //                         Navigator.of(ctx).pop();
                      //                       }
                      //                     },
                      //                     child: const Text('Add')),
                      //               ],
                      //             )
                      //           ],
                      //         ),
                      //       );
                      //     });
                    },
                  ),
                ),
              ],
            ),
      
            Card( child: isgainnull == false
                    ? null:
               Container(decoration: BoxDecoration(border: Border.all(width: 1),
               borderRadius: BorderRadius.circular(10)),
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Form(
                                      key: _popupkey,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  imagepick();
                                                },
                                                child: CircleAvatar(
                                                  backgroundImage: imagefile == null
                                                      ? const AssetImage('assets/logo.png')
                                                         
                                                      : FileImage(imagefile!)
                                                          as ImageProvider,
                                                  backgroundColor: Colors.transparent,
                                                  radius: 80,
                                                  child: const Center(
                                                    child: Text('Add image'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          TextFormField(
                                            decoration: const InputDecoration(
                                                hintText: 'Your food here'),
                                            keyboardType: TextInputType.name,
                                            controller: foodcontroller,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Mnadatory field';
                                              }
                                              return null;
                                            },
                                          ),
                      
                                          TextFormField(
                                            decoration: const InputDecoration(
                                                hintText: 'Calorie here'),
                                            keyboardType: TextInputType.number,
                                            controller: caloriecontroller,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Mnadatory field';
                                              }
                                              return null;
                                            },
                                          ),
                                          TextFormField(
                                            decoration: const InputDecoration(
                                                hintText: 'portion here'),
                                            controller: potioncontroller,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Mnadatory field';
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              foodcontroller.clear();
                                              caloriecontroller.clear();
                                              potioncontroller.clear();
                                              change(1);
                                            },
                                            child: const Text('Cancel')),
                                        ElevatedButton(
                                            style: const ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Colors.amber)),
                                            onPressed: () {
                                              if (_popupkey.currentState!
                                                  .validate()) {
                                                onAddButton(selctedgoal: 1);
                                                foodcontroller.clear();
                                                caloriecontroller.clear();
                                                potioncontroller.clear();
                                             change(1);
                                              }
                                            },
                                            child: const Text('Add')),
                                      ],
                                    ) ],
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
      
      
            Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 1, 78, 142),
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                    child: const Text('Add Food to weight loss',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    onPressed: () {
                      change(2);
                      // showDialog(
                      //     context: context,
                      //     builder: (ctx) {
                      //       return SingleChildScrollView(
                      //         child: AlertDialog(
                      //           title: const Text('Add Food to weight loss list'),
                      //           actions: [
                      //             Form(
                      //               key: _popupkey,
                      //               child: Column(
                      //                 children: [
                      //                   Row(
                      //                     mainAxisAlignment:
                      //                         MainAxisAlignment.center,
                      //                     children: [
                      //                       GestureDetector(
                      //                         onTap: () {
                      //                           imagepick();
                      //                         },
                      //                         child: CircleAvatar(
                      //                           backgroundImage: imagefile == null
                      //                               ? const AssetImage(
                      //                                   'assets/logo.png')
                      //                               : FileImage(imagefile!)
                      //                                   as ImageProvider,
                      //                           backgroundColor:
                      //                               Colors.transparent,
                      //                           radius: 80,
                      //                           child: const Center(
                      //                             child: Text('Add image'),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                   TextFormField(
                      //                     decoration: const InputDecoration(
                      //                         hintText: 'Your food here'),
                      //                     keyboardType: TextInputType.name,
                      //                     controller: foodcontroller,
                      //                     validator: (value) {
                      //                       if (value!.isEmpty) {
                      //                         return 'Mnadatory field';
                      //                       }
                      //                       return null;
                      //                     },
                      //                   ),
                      //                   TextFormField(
                      //                     decoration: const InputDecoration(
                      //                         hintText: 'Calorie here'),
                      //                     keyboardType: TextInputType.number,
                      //                     controller: caloriecontroller,
                      //                     validator: (value) {
                      //                       if (value!.isEmpty) {
                      //                         return 'Mnadatory field';
                      //                       }
                      //                       return null;
                      //                     },
                      //                   ),
                      //                   TextFormField(
                      //                     decoration: const InputDecoration(
                      //                         hintText: 'portion here'),
                      //                     controller: potioncontroller,
                      //                     validator: (value) {
                      //                       if (value!.isEmpty) {
                      //                         return 'Mnadatory field';
                      //                       }
                      //                       return null;
                      //                     },
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //             const SizedBox(height: 10),
                      //             Row(
                      //               mainAxisAlignment: MainAxisAlignment.end,
                      //               children: [
                      //                 TextButton(
                      //                     onPressed: () {
                      //                       foodcontroller.clear();
                      //                       caloriecontroller.clear();
                      //                       potioncontroller.clear();
                      //                       Navigator.of(ctx).pop();
                      //                     },
                      //                     child: const Text('Cancel')),
                      //                 ElevatedButton(
                      //                     style: const ButtonStyle(
                      //                         backgroundColor:
                      //                             MaterialStatePropertyAll(
                      //                                 Colors.amber)),
                      //                     onPressed: () {
                      //                       if (_popupkey.currentState!
                      //                           .validate()) {
                      //                         onAddButton(selctedgoal: 2);
                      //                         foodcontroller.clear();
                      //                         caloriecontroller.clear();
                      //                         potioncontroller.clear();
                      //                         Navigator.of(ctx).pop();
                      //                       }
                      //                     },
                      //                     child: const Text('Add')),
                      //               ],
                      //             )
                      //           ],
                      //         ),
                      //       );
                      //     });
                    })),
            const SizedBox(
              height: 20,
            ),

             Card( child: islossnull == false
                    ? null:
               Container(decoration: BoxDecoration(border: Border.all(width: 1),
               borderRadius: BorderRadius.circular(10)),
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Form(
                                      key: _popupkey,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  imagepick();
                                                },
                                                child: CircleAvatar(
                                                  backgroundImage: imagefile == null
                                                      ? const AssetImage('assets/logo.png')
                                                         
                                                      : FileImage(imagefile!)
                                                          as ImageProvider,
                                                  backgroundColor: Colors.transparent,
                                                  radius: 80,
                                                  child: const Center(
                                                    child: Text('Add image'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          TextFormField(
                                            decoration: const InputDecoration(
                                                hintText: 'Your food here'),
                                            keyboardType: TextInputType.name,
                                            controller: foodcontroller,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Mnadatory field';
                                              }
                                              return null;
                                            },
                                          ),
                      
                                          TextFormField(
                                            decoration: const InputDecoration(
                                                hintText: 'Calorie here'),
                                            keyboardType: TextInputType.number,
                                            controller: caloriecontroller,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Mnadatory field';
                                              }
                                              return null;
                                            },
                                          ),
                                          TextFormField(
                                            decoration: const InputDecoration(
                                                hintText: 'portion here'),
                                            controller: potioncontroller,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Mnadatory field';
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              foodcontroller.clear();
                                              caloriecontroller.clear();
                                              potioncontroller.clear();
                                              change(2);
                                            },
                                            child: const Text('Cancel')),
                                        ElevatedButton(
                                            style: const ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Colors.amber)),
                                            onPressed: () {
                                              if (_popupkey.currentState!
                                                  .validate()) {
                                                onAddButton(selctedgoal: 1);
                                                foodcontroller.clear();
                                                caloriecontroller.clear();
                                                potioncontroller.clear();
                                             change(2);
                                              }
                                            },
                                            child: const Text('Add')),
                                      ],
                                    ) ],
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
      
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.amber,
                  ),
                  child: TextButton(
                    child: const Text(
                      'Gain food list',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => AdminList(selectedgoal: 1)));
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 120,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.amber,
                  ),
                  child: TextButton(
                    child: const Text(
                      'Loss food list',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => AdminList(selectedgoal: 2)));
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void onAddButton({required int selctedgoal}) {
    final String name = foodcontroller.text;
    final String calorie = caloriecontroller.text;
    final String portion = potioncontroller.text;

    if (name.isEmpty && calorie.isEmpty) {
      return;
    } else {
      double cal = double.parse(calorie);
      final addfood = FoodModel(name: name, calorie: cal, portion: portion);
      foodadd(addfood, selctedgoal);
    }
  }
}
