import 'networking.dart';
import 'dart:convert';

const coinApiUrl = 'https://rest.coinapi.io/v1/exchangerate';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  final String crypto;
  final String currency;

  CoinData(this.crypto, this.currency);

  Future getCoinData()async {
    var url = '$coinApiUrl/$crypto/$currency/apikey-$apiKey';
    print(url);
    NetworkHelper networkHelper = NetworkHelper(url);
    var data = await networkHelper.getData();
    print('data: $data');
    var lastPrice = data['rate'];
    return lastPrice;
  }
}
