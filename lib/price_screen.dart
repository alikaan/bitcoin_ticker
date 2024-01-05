import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'components/crypto_card.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList[0];
  String cryptoRate = '?';
  Map<String, String> coinValues = {
    '${cryptoList[0]}': '?',
    '${cryptoList[1]}': '?',
    '${cryptoList[2]}': '?'
  };

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
      print(currency);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker(){
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      var newItem = Text('$currency');
      pickerItems.add(newItem);
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getData();
        });
      },
      children: pickerItems,
    );
  }

  void getData() async {
    try {
      for(String cyrpto in cryptoList){
        print('cyrpto: $cyrpto');
        var coinData = CoinData(cyrpto, selectedCurrency);
        var val = await coinData.getCoinData();
        print('val: $val');
        setState(() {
          coinValues[cyrpto] = val.toStringAsFixed(0);
        });
      }
    } catch (e) {
      print('ex: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CryptoCard(coinValues['BTC']!, selectedCurrency, 'BTC'),
              CryptoCard(coinValues['ETH']!, selectedCurrency, 'ETH'),
              CryptoCard(coinValues['LTC']!, selectedCurrency, 'LTC'),
            ],
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? iOSPicker() : androidDropdown()
          ),
        ],
      ),
    );
  }
}
