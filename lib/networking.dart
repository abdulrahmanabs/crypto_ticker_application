import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class Networking {
  String apiKey = "AE81E274-73B2-4C6B-9A6F-611EFAE5D7A0";
  String url = "https://rest.coinapi.io/v1/exchangerate";

  Future<dynamic> GetCoinPriceIn(String coinName, String CurrencyName) async {
    EasyLoading().indicatorType = EasyLoadingIndicatorType.pulse;
    EasyLoading().indicatorSize = 80;

    EasyLoading.show(status: "Fetching Data");
    http.Response response = await http.get(Uri.parse(
        "$url/${coinName.toUpperCase()}/${CurrencyName.toUpperCase()}?apikey=$apiKey"));

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      var rate = decodedData['rate'];
      EasyLoading.dismiss();
      return rate;
    } else {
      print(response.statusCode);
      throw "problem with server";
    }
  }
}
