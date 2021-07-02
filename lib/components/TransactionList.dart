import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/components/TransactionItem.dart';
import 'package:personal_expenses/models/Transaction.dart';

class TransactionList extends StatelessWidget {

    final List<Transaction> transactions;
    final void Function(String) removeTransaction;

    TransactionList({ this.transactions, this.removeTransaction });

    @override
    Widget build(BuildContext context) {
        return transactions.isEmpty 
            ? LayoutBuilder(
                builder: (ctx, constraints) {
                    return Column(
                        children: <Widget>[
                            const SizedBox(height: 20),
                            Text(
                                "Nenhuma Transação cadastrada",
                                style: Theme.of(context).textTheme.headline6
                            ),
                            const SizedBox(height: 20),
                            Container(
                                height: constraints.maxHeight * 0.6,
                                child: Image.network(
                                    "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ft3.ftcdn.net%2Fjpg%2F00%2F63%2F46%2F36%2F240_F_63463652_7GZCqnOetdoqDCTpO9IiGpysJpACy3Fw.jpg&f=1&nofb=1",
                                    fit: BoxFit.cover,
                                ),
                                // child: Image.asset(
                                //     "assets\\images\\waiting.png",
                                //     fit: BoxFit.cover,
                                // ),
                            ),
                        ],
                    );
                }
            )
            : ListView.builder(
                itemCount: transactions.length,
                    itemBuilder: (ctx, index) {
                        final tr = transactions[index];
                        return TransactionItem(
                            key: GlobalObjectKey(tr),
                            tr: tr, 
                            removeTransaction: removeTransaction
                        );
                    },
            );
            // : ListView(
            //     children: transactions.map((tr) {
            //         return TransactionItem(
            //             key: ValueKey(tr.id),
            //             tr: tr, 
            //             removeTransaction: removeTransaction
            //         );
            //     }).toList(),
            // );
    }
}
