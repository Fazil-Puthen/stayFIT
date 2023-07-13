import 'package:flutter/material.dart';

class WeeklyStatus extends StatefulWidget {
  const WeeklyStatus({super.key});

  @override
  State<WeeklyStatus> createState() => _WeeklyStatusState();
}

class _WeeklyStatusState extends State<WeeklyStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    
      // appBar: AppBar(
      //   title: Text('hi'),
      // ),
      body: ListWheelScrollView(itemExtent: 10,
      
      children: [Container(height: 50,color: Colors.red, child: Center(child: Text('hello'),),),
      Container(height: 50,color: Colors.red,child: Center(child: Text('hello'),),),
      Container(height: 50,color: Colors.red,child: Center(child: Text('hello'),),),
      Container(height: 50,color: Colors.red,child: Center(child: Text('hello'),),),
      Container(height: 50,color: Colors.red,child: Center(child: Text('hello'),),),
      Container(height: 50,color: Colors.red,child: Center(child: Text('hello'),),)],)
    );
  }
}
 