import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmt;
  final double spendingPct;
  ChartBar(this.label, this.spendingAmt, this.spendingPct);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint) {
      return Column(
      children: <Widget>[
        Container(
          height: constraint.maxHeight*.1,
          child: FittedBox(
              fit: BoxFit.cover,
              child: Text('\$${spendingAmt.toStringAsFixed(0)}')),
        ),
        SizedBox(
          height:  constraint.maxHeight*.05,
        ),
        Container(
          height:  constraint.maxHeight*.5,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Color.fromRGBO(180, 200, 220, 1.5),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              FractionallySizedBox(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                heightFactor: spendingPct,
              )
            ],
          ),
        ),
        SizedBox(
          height:  constraint.maxHeight*.1,
        ),
        Container(height: constraint.maxHeight*.1 ,child: FittedBox(child: Text(label))),
      ],
    );
    });
    
  }
}
