import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/components/AdaptativeButton.dart';
import 'package:personal_expenses/components/AdaptativeDatePicker.dart';
import 'package:personal_expenses/components/AdaptativeTextField.dart';

                         //   StatefulWidget | Stateless | State<Father>
class TransactionForm extends StatefulWidget {
    final void Function(String, double, DateTime) addTransaction;

    TransactionForm({ this.addTransaction });
    // TransactionForm(this.addTransaction, {addTransaction}) {
    //     print("Constructor TransactionForm!");
    // }

    @override
    _TransactionFormState createState() {

        return _TransactionFormState();
    }
}

class _TransactionFormState extends State<TransactionForm> {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _valueController = TextEditingController();
    DateTime _selectedDate = DateTime.now();

    void Function() _submitForm()  {
        final title = _titleController.text;
        final value = double.tryParse(_valueController.text) ?? 0.0;

        if (title.isNotEmpty || value > 0 || _selectedDate == null) {
            widget.addTransaction(title, value, _selectedDate);
        }
    }

    @override
    Widget build(BuildContext context) {
        return SingleChildScrollView(
            child: Card(
                elevation: 5,
                child: Padding(
                    padding: EdgeInsets.only(
                        top: 10,
                        right: 10,
                        left: 10,
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                        children: <Widget>[
                            AdaptativeTextField(
                                label: "Título",
                                controller: _titleController,
                                onSubmitted: (_) => _submitForm(),
                            ),
                            AdaptativeTextField(
                                label: "Valor (R\$)",
                                controller: _valueController,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true
                                ),
                                onSubmitted: (_) => _submitForm(),
                            ),
                            AdaptativeDatePicker(
                                selectedDate: _selectedDate,
                                onDateChanged: (newDate) {
                                    setState(() {
                                        _selectedDate = newDate;
                                    });
                                },
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                    AdaptativeButton(
                                        label: "Nova Transação",
                                        onPressed: _submitForm,
                                    ),
                                ],
                            )
                        ],
                    ),
                ),
            ),
        );
    }
}