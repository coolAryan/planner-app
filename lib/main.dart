import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:planner/widgets/trans_list.dart';
import './widgets/userTrans.dart';
import './models/transaction.dart';
import 'package:flutter/services.dart';
import './widgets/chart.dart';

void main() {
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyHome());
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Transaction> _userTransactions = [];
  List<Transaction> get recentTrans {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  bool _showChart = false;
  void _addNewTrans(String title, double amt, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amt,
      date: chosenDate,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void startNewTrans(BuildContext ctx) {
    try {
      showModalBottomSheet(
          context: ctx,
          builder: (_) {
            return GestureDetector(
              child: UserTransactions(_addNewTrans),
              onTap: () {},
              behavior: HitTestBehavior.opaque,
            );
          });
    } catch (e) {
      print(e);
    }
  }

  void _deleteTrans(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final isLandscape =
        media.orientation == Orientation.landscape;
    var app = AppBar(
      actions: [
        IconButton(
            icon: Icon(Icons.add), onPressed: () => startNewTrans(context)),
      ],
      title: Text(
        "Budget Planner",
        style: GoogleFonts.mcLaren(
          color: Colors.white,
          fontStyle: FontStyle.italic,
          fontSize: 30,
        ),
      ),
      leading: Icon(Icons.dehaze),
    );
    final txWidget = Container(
      child: TransactionList(_userTransactions, _deleteTrans),
      height: (media.size.height -
              app.preferredSize.height -
              media.padding.top) *
          .6,
    );
    //var d = MediaQuery.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber, accentColor: Colors.purple),
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => startNewTrans(context),
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        appBar: app,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isLandscape)
                    Switch(
                        value: _showChart,
                        onChanged: (val) {
                          setState(() {
                            _showChart = val;
                          });
                        }),
                  if (isLandscape) Text('Show Chart'),
                ],
              ),
              if (!isLandscape)
                Container(
                  child: MyChart(recentTrans),
                  height: (media.size.height -
                          app.preferredSize.height -
                          media.padding.top) *
                      .3,
                ),
              if (!isLandscape) txWidget,
              if (isLandscape)
                _showChart
                    ? Container(
                        child: MyChart(recentTrans),
                        height: (media.size.height -
                                app.preferredSize.height -
                                media.padding.top) *
                            .7,
                      )
                    : txWidget
            ],
          ),
        ),
      ),
    );
  }
}
