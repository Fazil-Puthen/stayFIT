import 'dart:convert';
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
  File? imagefile;

  final foodcontroller = TextEditingController();

  final caloriecontroller = TextEditingController();

  final potioncontroller = TextEditingController();

  final picker = ImagePicker();

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
  bool isgainnull = false;
  void change(int value) {
    setState(() {
      if (value == 1) {
        imagefile = null; // Clear the background image
        islossnull = false;
        isgainnull = !isgainnull;
      } else {
        imagefile = null;
        isgainnull = false;
        islossnull = !islossnull;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
  final screenSize = MediaQuery.of(context).size;
  final textScaleFactor = screenSize.width > 600 ? 1.5 : 1.0;
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
                      color: const Color.fromARGB(255, 1, 78, 142),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                    child: const Text('Add Food to weight gain',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    onPressed: () {
                      change(1);
                    },
                  ),
                ),
              ],
            ),
            Card(
              child: isgainnull == false
                  ? null
                  : Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.6,
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
                                        child: ClipOval(
                                          child: CircleAvatar(
                                            backgroundImage: imagefile == null
                                                ? const AssetImage(
                                                    'assets/camera add.jpg')
                                                : FileImage(imagefile!)
                                                    as ImageProvider,
                                            radius: 70,
                                            child: Center(
                                              child: imagefile == null
                                                  ? const Text('Add image')
                                                  : null,
                                            ),
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
                                      if (imagefile == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content:
                                              Text(' All fields are required'),
                                          backgroundColor: Colors.red,
                                          behavior: SnackBarBehavior.floating,
                                          // padding: EdgeInsets.all(20),
                                          margin: EdgeInsets.all(30),
                                        ));
                                      } else if (_popupkey.currentState!
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
                            )
                          ],
                        ),
                      ),
                    ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 1, 78, 142),
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                    child: const Text('Add Food to weight loss',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    onPressed: () {
                      change(2);
                    })),
            const SizedBox(
              height: 20,
            ),
            Card(
              child: islossnull == false
                  ? null
                  : Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.6,
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
                                              ? const AssetImage(
                                                  'assets/camera add.jpg')
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
                                      if (imagefile == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content:
                                              Text(' All fields are required'),
                                          backgroundColor: Colors.red,
                                          behavior: SnackBarBehavior.floating,
                                          // padding: EdgeInsets.all(20),
                                          margin: EdgeInsets.all(30),
                                        ));
                                      } else {
                                        if (_popupkey.currentState!
                                            .validate()) {
                                          onAddButton(selctedgoal: 2);
                                          foodcontroller.clear();
                                          caloriecontroller.clear();
                                          potioncontroller.clear();
                                          change(2);
                                        }
                                      }
                                    },
                                    child: const Text('Add')),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
            ),
            const SizedBox(
              height: 20,
            ),
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
                    child:  Text(
                      'Gain food list',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15*textScaleFactor,
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
                    child:  Text(
                      'Loss food list',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15*textScaleFactor,
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

  Future<void> onAddButton({required int selctedgoal}) async {
    final String name = foodcontroller.text;
    final String calorie = caloriecontroller.text;
    final String portion = potioncontroller.text;

    if (name.isEmpty && calorie.isEmpty) {
      return;
    }
    if (imagefile == null) {
      return;
    }
    final bytes = await imagefile!.readAsBytes();
    final String base64Image = base64Encode(bytes);

    double cal = double.parse(calorie);
    final addfood = FoodModel(
        name: name, calorie: cal, portion: portion, imagepath: base64Image);
    foodadd(addfood, selctedgoal);
  }
}
