import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/components/ChartBar.dart';
import 'package:personal_expenses/models/Transaction.dart';

class Chart extends StatelessWidget {
    final List<Transaction> recentTransactions;

    Chart({ this.recentTransactions });

    List<Map<String, Object>> get groupedTranslations {
        return List.generate(7, (index) {
            final DateTime weekDay = DateTime.now()
                .subtract(Duration(days: index));

            double totalSum = 0.0;

            for (Transaction transaction in recentTransactions) {
                bool sameDay = transaction.date.day == weekDay.day;
                bool sameMon = transaction.date.month == weekDay.month;
                bool sameYear = transaction.date.year == weekDay.year;

                if (sameDay && sameMon && sameYear) totalSum += transaction.value;
            }

            return {
                "day": DateFormat.E().format(weekDay)[0].toUpperCase(),
                "value": totalSum
            };
        }).reversed.toList();
    }

    double get _weekTotalValue {
        return groupedTranslations
            .fold(0.0, (prevValue, tr) => prevValue + (tr["value"] as double));
    }

    @override
    Widget build(BuildContext context) {
        groupedTranslations;
        return Card(
            elevation: 6,
            margin: EdgeInsets.all(20),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(3, 10, 3, 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: groupedTranslations.map((transact) {
                        // return Text("${transact["day"]}: ${transact["value"]}");
                        return Flexible(
                            fit: FlexFit.tight,
                            child: ChartBar(
                                label: transact["day"], 
                                value: transact["value"],
                                percentage: _weekTotalValue == 0 ? 0 : (transact["value"] as double) / _weekTotalValue,
                            ),
                        );
                    }).toList(),
                ),
            ),
        );
    }
}