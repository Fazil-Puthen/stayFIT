import 'package:flutter/material.dart';
import 'package:health_app/widjets/widjets.dart';
// import 'package:health_app/screens/planscreen.dart';

import '../functions/db_goalfunctions.dart';
import '../functions/db_mealfunctions.dart';
import '../models/foodmodel.dart';
import '../widjets/searchscreenwidget.dart';

class SearchScreen extends StatefulWidget {
  final int selectedgoal;
  final String mealtime;
  const SearchScreen(
      {super.key, required this.selectedgoal, required this.mealtime});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  double total = 0;
  //get selected goal
  ValueNotifier<List<FoodModel>> getgoal() {
    if (widget.selectedgoal == 1) {
      return gainfoodNotifier;
    } else {
      return lossfoodNotifier;
    }
  }

  final searchController = TextEditingController();
  List<FoodModel> filteredlist = [];
  List<bool> isPressed = [];

  @override
  void initState() {
    super.initState();
    filteredlist = getgoal().value;
    isPressed = List.generate(filteredlist.length, (index) => false);
  }

  void _updateFilteredList() {
    setState(() {
      filteredlist = getgoal()
          .value
          .where((food) =>
              food.name
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()) ||
              food.calorie
                  .toString()
                  .contains(searchController.text.toString()))
          .toList();
    });
  }

  // // bool isPressed = false;
  void icon(bool value) {
    setState(() {
      value = !value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Select Your Meal'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: double.infinity,
          // color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: Colors.blue,
                    hintText: 'search',
                  ),
                  controller: searchController,
                  onChanged: (_) => _updateFilteredList(),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,

                  //valuelistnable
                  child: ValueListenableBuilder(
                      valueListenable: getgoal(),
                      builder:
                          (BuildContext ctx, List<FoodModel> foodmodel, _) {
                        return ListView.separated(
                            itemBuilder: (ctx, index) {
                              final data = filteredlist[index];
                              print(data.name);
                              return searchScreen(data, index, widget.mealtime);
                              //     ListTile(
                              //   title: Text(
                              //     data.name,
                              //     style: const TextStyle(fontSize: 20),
                              //   ),
                              //   subtitle: Text(
                              //     '${data.calorie.toString()} calorie',
                              //     style: const TextStyle(fontSize: 15),
                              //   ),
                              //   //ADD BUTTON
                              //   trailing: IconButton(
                              //     icon: Icon(
                              //       isPressed[index]
                              //           ? Icons.add
                              //           : Icons.minimize,
                              //     ),
                              //     color: Colors.blue.shade500,
                              //     onPressed: () {
                              //       print('this is pressed $isPressed');
                              //       setState(() {
                              //         isPressed[index] = !isPressed[index];
                              //       });
                              //       // mealadd().value.add(data);
                              //       // mealadd().notifyListeners();
                              //       // final name=data.name;
                              //       // final calorie=data.calorie;
                              //       total = total + data.calorie;
                              //       print('this is calorie $total');
                              //       final meal = FoodModel(
                              //           name: data.name, calorie: data.calorie);
                              //       addmealtime(meal, widget.mealtime);
                              //     },
                              //   ),
                              // );
                            },
                            separatorBuilder: (ctx, index) {
                              return const Divider(
                                height: .5,
                                thickness: .5,
                                indent: 20,
                                endIndent: 30,
                              );
                            },
                            itemCount: filteredlist.length);
                      }),
                ),
              ),
              Container(
                width: 80,
                height: 80,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.amber)),
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
