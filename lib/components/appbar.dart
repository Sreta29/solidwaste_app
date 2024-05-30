import 'package:flutter/material.dart';

AppBar appBar({
  required String title,
  required List<Widget> actions,
  bool showBackButton = false,
  Function()? onBackButtonPressed, // Callback function for back button
}) {
  List<Widget> appBarActions = [];
  appBarActions.addAll(actions);

  return AppBar(
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
    surfaceTintColor: Colors.transparent,
    leading: showBackButton
        ? Container(
            margin: const EdgeInsets.only(left: 10),
            child: Column(children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: onBackButtonPressed,
              ),
            ]),
          )
        : null,
    actions: [
      Container(
        margin: const EdgeInsets.only(right: 10),
        child: Row(
          children: appBarActions,
        ),
      ),
    ],
  );
}
