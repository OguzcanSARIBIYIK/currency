import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final channel = IOWebSocketChannel.connect('wss://nc.ciner.com.tr/sub/dot');
  String dolar = "0.0";
  int dolarChange = 1;
  String quarterGold = "0.0";
  int goldChange = 1;

  @override
  void dispose() {
    super.dispose();
    this.channel.sink.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: this.channel.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var val = json.decode(snapshot.data);

                  if (val["SecuritySlug"] == "dolar") {
                    this.dolarChange = val["ChangeDirection"];
                    this.dolar = val["LastPrice"];
                  } else if (val["SecuritySlug"] == "ceyrek-altin") {
                    this.quarterGold = val["LastPrice"];
                    this.goldChange = val["ChangeDirection"];
                  }
                }

                return Column(
                  children: [
                    Card(
                      clipBehavior: Clip.hardEdge,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: this.goldChange == 1
                                  ? Colors.green
                                  : Colors.red,
                              width: 8,
                            ),
                          ),
                        ),
                        child: Stack(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 2.0),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      SizedBox(width: 8),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Çeyrek Altın",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              this.quarterGold + " TL",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1,
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
                    ),
                    Card(
                      clipBehavior: Clip.hardEdge,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: this.dolarChange == 1
                                  ? Colors.green
                                  : Colors.red,
                              width: 8.0,
                            ),
                          ),
                        ),
                        child: Stack(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 2.0),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      SizedBox(width: 8),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Dolar",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              this.dolar + " TL",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1,
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
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
