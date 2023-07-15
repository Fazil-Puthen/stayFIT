import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../functions/db_goalfunctions.dart';

import '../models/foodmodel.dart';

class AdminList extends StatelessWidget {
  final int selectedgoal;
  AdminList({super.key, required this.selectedgoal});

  late TextEditingController foodcontroller;

  late TextEditingController caloriecontroller;

  late TextEditingController portioncontroller;

  ValueNotifier<List<FoodModel>> getgoal() {
    if (selectedgoal == 1) {
      return gainfoodNotifier;
    } else {
      return lossfoodNotifier;
    }
  }

  Future<void> updatefood(int index, int id) async {
    final gainlist = gainfoodNotifier.value;
    final losslist = lossfoodNotifier.value;
    final food = foodcontroller.text;
    final calorie = caloriecontroller.text;
    final portion = portioncontroller.text;
    final cal = double.parse(calorie);
    final gainimage=gainlist[index].imagepath;
    final lossimage=losslist[index].imagepath;

  
    if (selectedgoal == 1) {
      FoodModel foodobj =
      FoodModel(name: food, calorie: cal, id: id, portion: portion,imagepath: gainimage);
      Box<FoodModel> foodDB = await Hive.openBox<FoodModel>('gainfood');
      await foodDB.put(id, foodobj);
      gainlist[index] = foodobj;
      gainfoodNotifier.notifyListeners();
    } else {
        FoodModel foodobj =
      FoodModel(name: food, calorie: cal, id: id, portion: portion,imagepath: lossimage);
      Box<FoodModel> foodDB2 = await Hive.openBox<FoodModel>('lossfood');
      await foodDB2.put(id, foodobj);
      losslist[index] = foodobj;
      lossfoodNotifier.notifyListeners();
    }
  }

  final editkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ValueListenableBuilder(
            valueListenable: getgoal(),
            builder: (BuildContext ctx, List<FoodModel> foodmodel, _) {
              return ListView.separated(
                  itemBuilder: (ctx, index) {
                    final data = foodmodel[index];
                    // final base64image=data.imagepath;
                    // final imagedecoded=base64Decode(base64image!);
                    //List tile
                    return Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            backgroundImage: data.imagepath != null
                                ? MemoryImage(base64Decode(data.imagepath!))
                                    as ImageProvider
                                : const AssetImage(
                                    'assets/logo.png'),
                          ),
                          Column(
                            children: [
                              Text(data.name),
                              Text(data.calorie.toString()),
                            ],
                          ),
                          Text(data.portion),
                          IconButton(
                              onPressed: () {
                                //edit function
                                foodcontroller = TextEditingController();
                                caloriecontroller = TextEditingController();
                                portioncontroller = TextEditingController();
                                foodcontroller.text = data.name;
                                caloriecontroller.text =
                                    data.calorie.toString();
                                portioncontroller.text = data.portion;
                                showDialog(
                                    context: ctx,
                                    builder: (ctx1) {
                                      return AlertDialog(
                                        title: const Text('EDIT'),
                                        actions: [
                                          Form(
                                            key: editkey,
                                            child: Column(children: [
                                              TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                        hintText: 'food'),
                                                controller: foodcontroller,
                                              ),
                                              TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                        hintText: 'calorie'),
                                                controller: caloriecontroller,
                                              ),
                                              TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                        hintText: 'portion'),
                                                controller: portioncontroller,
                                              ),
                                            ]),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    updatefood(index, data.id!);
                                                  },
                                                  child: const Text('Update'))
                                            ],
                                          )
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              )),
                          IconButton(
                              onPressed: () {
                                if (data.id != null) {
                                  deletefood(data.id!, selectedgoal);
                                }
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const Divider(
                      height: .5,
                      thickness: .5,
                    );
                  },
                  itemCount: foodmodel.length);
            }),
      ),
    );
  }
}
