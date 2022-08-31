// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable

import "package:flutter/material.dart";
import "./chart_bar.dart";

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List Expenses = [];
  final itemController = TextEditingController();
  final costController = TextEditingController();
  Map dailyExpense = {
    "mon": 0.0,
    "tue": 0.0,
    "wed": 0.0,
    "thu": 0.0,
    "fri": 0.0,
    "sat": 0.0,
    "sun": 0.0,
  };
  Map dayData = {
    "1": "mon",
    "2": "tue",
    "3": "wed",
    "4": "thu",
    "5": "fri",
    "6": "sat",
    "7": "sun"
  };
  double totalExpense = 0.0;

  void calculateTotalExpense() {
    double sum = 0;
    Map de = {
      "mon": 0.0,
      "tue": 0.0,
      "wed": 0.0,
      "thu": 0.0,
      "fri": 0.0,
      "sat": 0.0,
      "sun": 0.0,
    };
    for (int i = 0; i < Expenses.length; i++) {
      sum += double.parse(Expenses[i]["cost"]);
      de[dayData[Expenses[i]["date"].weekday.toString()]] +=
          double.parse(Expenses[i]["cost"]);
    }
    print(sum);
    setState(() {
      totalExpense = sum;
      dailyExpense = de;
    });
  }

  void startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (bottomSheetContext) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  controller: itemController,
                  decoration: InputDecoration(
                    labelText: 'Enter Item',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: costController,
                  decoration: InputDecoration(
                    labelText: 'Enter Cost',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.purpleAccent)),
                    onPressed: () {
                      selectDate(bottomSheetContext);
                    },
                    child: Text("Select Date")),
              ),
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                      "Selected Date : ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}")),
              Padding(
                padding: EdgeInsets.all(20),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.purpleAccent)),
                    onPressed: () {
                      setState(() {
                        List e = Expenses;
                        e.add({
                          'item': itemController.text,
                          'cost': costController.text,
                          'date': selectedDate
                        });
                        // print(e);
                        Expenses = e;
                        itemController.text = "";
                        costController.text = "";
                      });
                      calculateTotalExpense();
                      Navigator.pop(bottomSheetContext);
                    },
                    child: Text("Add Expense")),
              ),
            ],
          );
        });
  }

  DateTime selectedDate = DateTime.now();

  void selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
  }

  double getExpensePercentage(String day) {
    if (totalExpense == 0.0 && dailyExpense[day] == 0.0) {
      return 0.0;
    } else {
      return dailyExpense[day] / totalExpense;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Expenses"),
        backgroundColor: Colors.purpleAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              startAddNewTransaction(context);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ChartBar(
                  label: "Mon",
                  spendingAmountTotal: dailyExpense["mon"],
                  spendingAmountPercentage: getExpensePercentage("mon")),
              ChartBar(
                  label: "Tue",
                  spendingAmountTotal: dailyExpense["tue"],
                  spendingAmountPercentage: getExpensePercentage("tue")),
              ChartBar(
                  label: "Wed",
                  spendingAmountTotal: dailyExpense["wed"],
                  spendingAmountPercentage: getExpensePercentage("wed")),
              ChartBar(
                  label: "Thu",
                  spendingAmountTotal: dailyExpense["thu"],
                  spendingAmountPercentage: getExpensePercentage("thu")),
              ChartBar(
                  label: "Fri",
                  spendingAmountTotal: dailyExpense["fri"],
                  spendingAmountPercentage: getExpensePercentage("fri")),
              ChartBar(
                  label: "Sat",
                  spendingAmountTotal: dailyExpense["sat"],
                  spendingAmountPercentage: getExpensePercentage("sat")),
              ChartBar(
                  label: "Sun",
                  spendingAmountTotal: dailyExpense["sun"],
                  spendingAmountPercentage: getExpensePercentage("sun")),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Image.asset(
            "assets/flutter.jpg",
            height: 200,
            width: 300,
          ),
          SizedBox(
            height: 40,
          ),
          Expenses.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: Expenses.length,
                  itemBuilder: (context, position) {
                    return ListTile(
                      leading: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text("Rs." + Expenses[position]["cost"]),
                      ),
                      title: Text(Expenses[position]["item"]),
                      subtitle: Text(
                          "${Expenses[position]["date"].day}/${Expenses[position]["date"].month}/${Expenses[position]["date"].year}"),
                      trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              List e = Expenses;
                              e.removeAt(position);
                              Expenses = e;
                            });
                            calculateTotalExpense();
                          },
                          icon: Icon(Icons.delete)),
                    );
                  },
                ))
              : Center(
                  child: Text(
                    "No Data",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          startAddNewTransaction(context);
        },
        backgroundColor: Colors.yellow,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
