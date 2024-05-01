import 'package:flutter/material.dart';

class SelectedLocation extends StatefulWidget{
    const SelectedLocation({super.key});

  @override
  State<SelectedLocation> createState() => _SelectedLocationState();
}

class _SelectedLocationState extends State<SelectedLocation>{

@override
void initState(){
  super.initState();
}


   @override
  Widget build(BuildContext context) {
    return const Center(child: Text('selected Location'),
    );
  }
}