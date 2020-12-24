import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deletetTx;
  TransactionList(this.transactions, this.deletetTx);
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraint) {
            return Column(
              children: <Widget>[
                Text("No Transaction added yet"),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: constraint.maxHeight * .6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.contain,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  title: Text(
                    transactions[index].title,
                    style: GoogleFonts.mcLaren(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text(
                    DateFormat.yMEd().format(transactions[index].date),
                    style:
                        GoogleFonts.mcLaren(color: Colors.grey, fontSize: 14),
                  ),
                  leading: CircleAvatar(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        child: Text(
                          '\$${transactions[index].amount}',
                          style: GoogleFonts.mcLaren(
                              color: Colors.purple, fontSize: 22),
                        ),
                      ),
                    ),
                    radius: 30,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  trailing: MediaQuery.of(context).size.width > 400
                      ? FlatButton.icon(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          onPressed: () => deletetTx(transactions[index].id),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 28,
                          ),
                          label: Text('Delete'))
                      : IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 28,
                          ),
                          onPressed: () => deletetTx(transactions[index].id)),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
