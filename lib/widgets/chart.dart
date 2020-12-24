import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class MyChart extends StatelessWidget {
  final List<Transaction> recentTrans;
  MyChart(this.recentTrans);

  List<Map<String, Object>> get groupedTransValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (var i = 0; i < recentTrans.length; i++) {
        if (recentTrans[i].date.day == weekDay.day &&
            recentTrans[i].date.month == weekDay.month &&
            recentTrans[i].date.year == weekDay.year) {
          totalSum += recentTrans[i].amount;
        }
      }
      print(DateFormat.E().format(weekDay).substring(0, 1));
      print(totalSum);
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get spending {
    return groupedTransValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransValues);
    return  Card(
        elevation: 6,
        margin: EdgeInsets.all(10),
        child: Container(
          
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  data['day'],
                  data['amount'],
                  spending == 0.0 ? 0 : (data['amount'] as double) / spending,
                ),
              );
            }).toList(),
          ),
        ),
      
    );
  }
}
