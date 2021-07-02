import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {

    final String label;
    final double value;
    final double percentage;

    ChartBar({ 
        this.label, 
        this.value, 
        this.percentage 
    });

    @override
    Widget build(BuildContext context) {
        return LayoutBuilder(
            builder: (ctx, constraints) {
                return Column(
                    children: <Widget>[
                        Container(
                            height: constraints.maxHeight * 0.15,
                            child: FittedBox(
                                child: Text(" ${(value).toStringAsFixed(2)}")
                            ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.05),
                        Container(
                            height: constraints.maxHeight * 0.6,
                            width: 10,
                            child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: <Widget>[
                                    Container(
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(220, 220, 220, 0.44),
                                            border: Border.all(
                                                color: Colors.grey[300],
                                                width: 1.0
                                            ),
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                    ),
                                    FractionallySizedBox(
                                        heightFactor: percentage,
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Theme.of(context).primaryColor,
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                        ),
                                    )
                                ],
                            ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.05),
                        Container(
                            height: constraints.maxHeight * 0.15,
                            child: FittedBox(
                                child: Text(label),
                            )
                        ),
                    ],
                );
            },
        );
    }
}