import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/Transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction tr;
  final void Function(String p1) removeTransaction;

  const TransactionItem({
    Key key,
    @required this.tr,
    @required this.removeTransaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5,
        ),
        child: ListTile(
            leading: CircleAvatar(
                radius: 30,
                child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: FittedBox(
                        child: Text("R\$${tr.value}")
                    ),
                ),
            ),
            title: Text(
                tr.title,
                style: Theme.of(context).textTheme.headline6
            ),
            subtitle: Text(
                DateFormat("d/MMM/yyyy").format(tr.date)
            ),
            trailing: MediaQuery.of(context).size.width > 480 
            ? TextButton.icon(
                icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                ),
                onPressed: () => removeTransaction(tr.id),
                label: Text(
                    "Excluir", 
                    style: TextStyle(
                        color: Theme.of(context).errorColor
                    ),
                ),
            ) 
            :   IconButton(
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => removeTransaction(tr.id),
                ),
        ),
    );
  }
}