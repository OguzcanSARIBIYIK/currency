import 'package:flutter/material.dart';

class SpecialCard extends StatefulWidget {
  int changeDirection;
  String title;
  String amount;

  SpecialCard({
    this.changeDirection,
    this.title,
    this.amount,
  });

  @override
  _SpecialCardState createState() => _SpecialCardState();
}

class _SpecialCardState extends State<SpecialCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color:
                  this.widget.changeDirection == 1 ? Colors.green : Colors.red,
              width: 8,
            ),
          ),
        ),
        child: Stack(
          children: [
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: Text(
                          this.widget.title,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              this.widget.amount + " TL",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
