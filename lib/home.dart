import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

import 'SpecialCard.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final channel = IOWebSocketChannel.connect('wss://nc.ciner.com.tr/sub/dot');
  String dolar = "-";
  int dolarDirection = 1;
  String euro = "-";
  int euroDirection = 1;
  String gold = "-";
  int goldDirection = 1;
  String quarterGold = "-";
  int quarterGoldDirection = 1;
  String gramGold = "-";
  int gramGoldDirection = 1;

  @override
  void dispose() {
    super.dispose();
    this.channel.sink.close();
  }

  _currencyBuilder() {
    return StreamBuilder(
      stream: this.channel.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var val = json.decode(snapshot.data);

          if (val["SecuritySlug"] == "dolar") {
            this.dolarDirection = val["ChangeDirection"];
            this.dolar = val["LastPrice"];
          } else if (val["SecuritySlug"] == "euro") {
            this.euro = val["LastPrice"];
            this.euroDirection = val["ChangeDirection"];
          } else if (val["SecuritySlug"] == "ceyrek-altin") {
            this.quarterGold = val["LastPrice"];
            this.quarterGoldDirection = val["ChangeDirection"];
          } else if (val["SecuritySlug"] == "gram-altin") {
            this.gramGold = val["LastPrice"];
            this.gramGoldDirection = val["ChangeDirection"];
          } else if (val["SecuritySlug"] == "cumhuriyet-altini") {
            this.gold = val["LastPrice"];
            this.goldDirection = val["ChangeDirection"];
          }
        }

        return Column(
          children: [
            SpecialCard(
              title: "Gram Altın",
              changeDirection: this.gramGoldDirection,
              amount: this.gramGold,
            ),
            SpecialCard(
              title: "Çeyrek Altın",
              changeDirection: this.quarterGoldDirection,
              amount: this.quarterGold,
            ),
            SpecialCard(
              title: "Tam Altın",
              changeDirection: this.goldDirection,
              amount: this.gold,
            ),
            SpecialCard(
              title: "Euro",
              changeDirection: this.euroDirection,
              amount: this.euro,
            ),
            SpecialCard(
              title: "Dolar",
              changeDirection: this.dolarDirection,
              amount: this.dolar,
            ),
          ],
        );
      },
    );
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
            _currencyBuilder(),
          ],
        ),
      ),
    );
  }
}
