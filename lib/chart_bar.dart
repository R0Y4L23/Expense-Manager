// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import "package:flutter/material.dart";

class ChartBar extends StatelessWidget {
  const ChartBar(
      {Key? key,
      required this.label,
      required this.spendingAmountTotal,
      required this.spendingAmountPercentage})
      : super(key: key);
  final String label;
  final double spendingAmountTotal;
  final double spendingAmountPercentage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Rs. $spendingAmountTotal',
          style: TextStyle(fontSize: 10),
        ),
        SizedBox(
          height: 4.0,
        ),
        Container(
            height: 60,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: spendingAmountPercentage,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.purpleAccent,
                          borderRadius: BorderRadius.circular(10))),
                )
              ],
            )),
        SizedBox(
          height: 4.0,
        ),
        Text(label)
      ],
    );
  }
}
