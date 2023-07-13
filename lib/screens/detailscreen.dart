import 'package:flutter/material.dart';
import 'package:health_app/models/foodmodel.dart';

import '../functions/db_goalfunctions.dart';
import '../functions/db_mealfunctions.dart';


// ignore: must_be_immutable
class DetailScreen extends StatelessWidget {
  late String mealtime;
   DetailScreen({super.key,required this.mealtime});
   
   //get selected mealtime
   ValueNotifier<List<FoodModel>> mealadd(){
    if(mealtime=='Breakfast')
    {
      return breakfastnotifier;
    }
   else if(mealtime=='Lunch')
   {
    return lunchnotifier;
   }
   else
   {
    return dinnernotifier;
   }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.amber,
      title: Text(mealtime),
      centerTitle: true,
    ),
      body: Padding(padding:
       const EdgeInsets.all(8),
       child: ValueListenableBuilder(valueListenable: mealadd(),
       builder: (BuildContext ctx,List<FoodModel> foodmodel,_){
        return ListView.separated(itemBuilder: (ctx,index){
          final data=foodmodel[index];
          return ListTile(
            title: Text(data.name),
            subtitle: Text(data.calorie.toString()),
            trailing: IconButton(icon: const Icon(Icons.delete,color: Colors.red,),
            onPressed: (){
              if(data.id!=null){
              deletemeal(data.id!, mealtime);}
            },),
          );
        },
         separatorBuilder: (ctx,index){
          return const Divider(height: .5,thickness: .5,endIndent: 10,);
         },
          itemCount: foodmodel.length);
       }
         
          // child: ,
         ),
       ),

    );
  }
}