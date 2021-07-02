
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:personal_expenses/components/Chart.dart';
import 'package:personal_expenses/components/TransactionForm.dart';
import 'package:personal_expenses/components/TransactionList.dart';
import 'package:personal_expenses/models/Transaction.dart';
// import 'package:flutter/services.dart';
// import "package:intl/intl.dart";

class ExpensesApp extends StatelessWidget {

    @override
    Widget build(BuildContext context) {

        // SystemChrome.setPreferredOrientations([
        //     DeviceOrientation.portraitUp
        // ]);

        return MaterialApp(
            home: MyHomePage(),
            theme: ThemeData(
                primarySwatch: Colors.purple,
                accentColor: Colors.amber[500],
                fontFamily: "Roboto",
                textTheme: ThemeData.light().textTheme.copyWith(
                    button: TextStyle(
                        fontFamily: "Roboto",
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                    headline6: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    )
                ),
                appBarTheme: AppBarTheme(
                    textTheme: ThemeData.light().textTheme.copyWith(
                        headline6: TextStyle(
                            fontFamily: "DelaGothicOne",
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                        )
                    )
                ),
            ),
        );
    }
}

class MyHomePage extends StatefulWidget {
    @override
    _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
    final List<Transaction> _transactions = <Transaction>[
        // Transaction(
        //     id: "T0",
        //     title: "Old Account",
        //     value: 400.00,
        //     date: DateTime.now().subtract(Duration(days: 33)),
        // ),
        // Transaction(
        //     id: "T1",
        //     title: "New run shoes",
        //     value: 510.76,
        //     date: DateTime.now().subtract(Duration(days: 1)),
        // ),
        // Transaction(
        //     id: "T2",
        //     title: "New run shoes",
        //     value: 710.76,
        //     date: DateTime.now().subtract(Duration(days: 2)),
        // ),
        // Transaction(
        //     id: "T3",
        //     title: "Light bill",
        //     value: 2111.30,
        //     date: DateTime.now().subtract(Duration(days: 3)),
        // ),
    ];
    bool _showChart = false;

    @override
    void initState() {
        super.initState();
        WidgetsBinding.instance.addObserver(this);
    }

    @override
    void didChangeAppLifecycleState(AppLifecycleState state) {
        print(state);
    }

    @override
    void dispose() {
        super.dispose();
        WidgetsBinding.instance.removeObserver(this);
    }

    // List<Transaction> get _recentTransactions {
    //     return _transactions.where(
    //         (transaction) => 
    //             transaction.date.isAfter(
    //                 DateTime.now().subtract(Duration(days: 7))
    //             )
    //     );
    // }

    void Function(String, double) 
        // ignore: missing_return
        _addTransaction(String title, double value, DateTime date) {
            final newTransaction = Transaction(
                id: Random().nextDouble().toString(),
                title: title,
                value: value,
                date: date,
            );

            setState(() {
                _transactions.add(newTransaction);
            });

            Navigator.of(context).pop();
    }

    void Function() _removeTransaction(String id) {
        setState(() {
            _transactions.removeWhere((element) => element.id == id);
        });
    }

    void Function(BuildContext) _openTransactionFormModal(BuildContext context) {
        showModalBottomSheet(
            context: context,
            builder: (_) => TransactionForm(addTransaction: _addTransaction,),
        );
    }

    Widget _getIconButton({ IconData icon, Function fn }) {
        return Platform.isIOS
            ? GestureDetector(onTap: fn, child: Icon(icon))
            : IconButton(icon: Icon(icon), onPressed: fn);
    }

    // 
    // () => {
    //                 setState(() {
    //                     _showChart = !_showChart;
    //                 })
    //             }


    @override
    Widget build(BuildContext context) {
        final mediaQuery = MediaQuery.of(context);

        bool isLandScape = mediaQuery.orientation == Orientation.landscape;

        final iconList = Platform.isIOS ? CupertinoIcons.news : Icons.list;
        final chartList = Platform.isIOS ? CupertinoIcons.refresh : Icons.show_chart;

        final actions = <Widget>[
            if (isLandScape) 
                _getIconButton(
                    icon: _showChart ? iconList : chartList,
                    fn: () {
                        setState(() {
                            _showChart = !_showChart;
                        });
                    }
                ),
            _getIconButton(
                icon: Platform.isIOS ? CupertinoIcons.add : Icons.add,
                fn: () => _openTransactionFormModal(context),
            ),
        ];

        final PreferredSizeWidget appBar = Platform.isIOS 
            ? CupertinoNavigationBar(
                middle: Text(
                    "Personal Expenses",
                    style: TextStyle(
                        fontSize: 16 * mediaQuery.textScaleFactor
                    ),
                ),
                trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: actions
                ),
            )
            : AppBar(
                title: Text(
                    "Personal Expenses",
                    style: TextStyle(
                        fontSize: 16 * mediaQuery.textScaleFactor
                    ),
                ),
                actions: actions,
            );

        final availableHeight = 
            mediaQuery.size.height 
                - appBar.preferredSize.height
                    - mediaQuery.padding.top;

        final bodyPage = SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                        // Container(
                        //     width: double.infinity,
                        //     child: Card(
                        //         color: Colors.blue,
                        //         child: Text("Graph"),
                        //         elevation: 5,
                        //     ),
                        // ),
                        // if (isLandScape)
                        //     Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: <Widget>[
                        //             Text("Exibir Gráfico"),
                        //             Switch.adaptive(
                        //                 activeColor: Theme.of(context).accentColor,
                        //                 value: _showChart,
                        //                 onChanged: (value) {
                        //                 setState(() {
                        //                     _showChart = value;
                        //                 });
                        //                 }
                        //             ),
                        //         ],
                        //     ),
                        if (_showChart || !isLandScape)
                            Container(
                                height: availableHeight * (isLandScape ? 0.7 : 0.3),
                                child: Chart(recentTransactions: _transactions)
                            ),
                        if (!_showChart || !isLandScape)
                            Container(
                                height: availableHeight * (isLandScape ? 1 : 0.7),
                                child: TransactionList(
                                    transactions: _transactions,
                                    removeTransaction: _removeTransaction,
                                ),
                            )
                    ],
                ),
            )
        );

        return Platform.isIOS 
            ? CupertinoPageScaffold(
                navigationBar: appBar,
                child: bodyPage,
            )
            : Scaffold(
                appBar: appBar,
                body: bodyPage,
                floatingActionButton: Platform.isIOS 
                    ? Container() 
                    : FloatingActionButton(
                        child: Icon(Icons.add),
                        onPressed: () => _openTransactionFormModal(context),
                        // backgroundColor: Theme.of(context).primaryColor,
                    ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
            );
    }
}

main() {
    runApp(new ExpensesApp());
}