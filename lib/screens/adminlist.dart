import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../functions/db_goalfunctions.dart';
import 'package:image_picker/image_picker.dart';

import '../models/foodmodel.dart';

class AdminList extends StatefulWidget {
  final int selectedgoal;
  AdminList({Key? key, required this.selectedgoal}) : super(key: key);

  @override
  State<AdminList> createState() => _AdminListState();
}

class _AdminListState extends State<AdminList> {
  late TextEditingController foodcontroller;
  late TextEditingController caloriecontroller;
  late TextEditingController portioncontroller;

  ValueNotifier<List<FoodModel>> getgoal() {
    if (widget.selectedgoal == 1) {
      return gainfoodNotifier;
    } else {
      return lossfoodNotifier;
    }
  }

  File? selectedImage;
  Future<void> selectImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final imageFile = File(pickedImage.path);
      setState(() {
        selectedImage = imageFile;
      });
    }
  }

  Future<void> updatefood(int index, int id) async {
    final gainlist = gainfoodNotifier.value;
    final losslist = lossfoodNotifier.value;
    final food = foodcontroller.text;
    final calorie = caloriecontroller.text;
    final portion = portioncontroller.text;
    final cal = double.parse(calorie);

    if (selectedImage != null) {
      final imageBytes = await selectedImage!.readAsBytes();
      final String base64Image = base64Encode(imageBytes);

      FoodModel foodobj = FoodModel(
        name: food,
        calorie: cal,
        id: id,
        portion: portion,
        imagepath: base64Image,
      );

      if (widget.selectedgoal == 1) {
        Box<FoodModel> foodDB = await Hive.openBox<FoodModel>('gainfood');
        await foodDB.put(id, foodobj);
        gainlist[index] = foodobj;
        gainfoodNotifier.notifyListeners();
      } else {
        Box<FoodModel> foodDB2 = await Hive.openBox<FoodModel>('lossfood');
        await foodDB2.put(id, foodobj);
        losslist[index] = foodobj;
        lossfoodNotifier.notifyListeners();
      }
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
                final base64image = data.imagepath;
                final imagedecoded = base64image != null ? base64Decode(base64image) : null;

                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        backgroundImage: selectedImage != null
                            ? FileImage(selectedImage!)
                            : imagedecoded != null
                                ? MemoryImage(imagedecoded)as ImageProvider
                                : const AssetImage('assets/logo.png'),
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
                          foodcontroller = TextEditingController();
                          caloriecontroller = TextEditingController();
                          portioncontroller = TextEditingController();
                          foodcontroller.text = data.name;
                          caloriecontroller.text = data.calorie.toString();
                          portioncontroller.text = data.portion;
                          showDialog(
                            context: ctx,
                            builder: (ctx1) {
                              return AlertDialog(
                                title: const Text('EDIT'),
                                content: SizedBox(child:
                                  SingleChildScrollView(
                                    child: Column(
                                      children:[ Column(mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          if (selectedImage != null) ...[
                                            Container(
                                              width:MediaQuery.of(context).size.width*0.4,
                                              height: MediaQuery.of(context).size.height*0.2,
                                             child: Image.file(selectedImage!)),
                                            const SizedBox(height: 10),
                                          ],
                                          ElevatedButton(
                                            onPressed: selectImage,
                                            child: const Text('Select Image'),
                                          ),
                                        ],
                                      ),
                                                                  
                                    Form(
                                      key: editkey,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            decoration: const InputDecoration(hintText: 'food'),
                                            controller: foodcontroller,
                                          ),
                                          TextFormField(
                                            decoration: const InputDecoration(hintText: 'calorie'),
                                            controller: caloriecontroller,
                                          ),
                                          TextFormField(
                                            decoration: const InputDecoration(hintText: 'portion'),
                                            controller: portioncontroller,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            updatefood(index, data.id!);
                                          },
                                          child: const Text('Update'),
                                        ),
                                      ],
                                    ),
                                                                  ]),
                                  ),),
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (data.id != null) {
                            deletefood(data.id!, widget.selectedgoal);
                          }
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
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
              itemCount: foodmodel.length,
            );
          },
        ),
      ),
    );
  }
}
