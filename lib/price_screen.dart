import 'dart:html';

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'constants.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currentCurrency = currenciesList[0];
  Networking _networking = Networking();
  @override
  void initState() {
    super.initState();
    GetCoinsData(currentCurrency);
    //_networking.getRate("coinName", "");

    //_networking.GetCoinPriceIn("coinName", "CurrencyName");
  }

  String btcPriceText = "";
  String ethPriceText = "";
  String IOTXPriceText = "";
  void GetCoinsData(String currency) async {
    double btcPrice = await _networking.GetCoinPriceIn("BTC", currency);
    double ETHPrice = await _networking.GetCoinPriceIn("ETH", currency);
    double IOTXPrice = await _networking.GetCoinPriceIn("IOTX", currency);

    setState(() {
      btcPriceText = btcPrice.toStringAsFixed(0);
      ethPriceText = ETHPrice.toStringAsFixed(0);
      IOTXPriceText = IOTXPrice.toStringAsFixed(4);
    });
  }

  List<DropdownMenuItem<String>> getDropDownItems() {
    List<DropdownMenuItem<String>> itemList = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(child: Text(currency), value: currency);
      itemList.add(newItem);
    }

    return itemList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            CoinPriceCard(
                Coin: "BTC", Currency: "$currentCurrency", price: btcPriceText),
            CoinPriceCard(
                Coin: "ETH", Currency: "$currentCurrency", price: ethPriceText),
            CoinPriceCard(
                Coin: "IOTX",
                Currency: "$currentCurrency",
                price: IOTXPriceText),
          ]),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
              value: currentCurrency,
              items: getDropDownItems(),
              onChanged: (value) {
                setState(() {
                  currentCurrency = value ?? "";
                  GetCoinsData(currentCurrency);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CoinPriceCard extends StatelessWidget {
  CoinPriceCard(
      {@required this.Coin, @required this.Currency, @required this.price});
  final String Coin;
  final String Currency;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $Coin = $price $Currency',
            textAlign: TextAlign.center,
            style: kCardTextStyle,
          ),
        ),
      ),
    );
  }
}
