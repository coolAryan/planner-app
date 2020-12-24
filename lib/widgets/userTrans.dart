import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import '../models/transaction.dart';
//import './trans_list.dart';

class UserTransactions extends StatefulWidget {
  final Function addNewTrans;
  UserTransactions(this.addNewTrans);

  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final amountController = TextEditingController();
  DateTime _selectedDate;
  final titleController = TextEditingController();

  void submitd() {
    final enteredAmount = double.parse(amountController.text);
    final enteredTitle = titleController.text;
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addNewTrans(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
                  child: Card(
            elevation: 8,
            child: Container(
              padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: titleController,
                    // onChanged: (val) => prdctInput = val,
                    decoration: InputDecoration(labelText: "ProductName"),
                    onSubmitted: (_) => submitd(),
                  ),
                  TextField(
                    controller: amountController,
                    //onChanged: (val) => amtInput = val,
                    decoration: InputDecoration(labelText: "Amount"),
                    onSubmitted: (_) => submitd(),
                    keyboardType: TextInputType.number,
                  ),
                  Container(
                    height: 70,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(_selectedDate == null
                              ? 'No Date Chosen!'
                              : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
                        ),
                        FlatButton(
                          onPressed: _presentDate,
                          child: Text(
                            'Choose Date',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          textColor: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: RaisedButton(
                      color: Colors.amber,
                      onPressed: () => submitd()
                      // print(amtInput);
                      // print(prdctInput);
                      ,
                      child: Text("Add Transaction"),
                      textColor: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // TransactionList(_userTransactions),
      ],
    );
  }
}
