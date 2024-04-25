import 'dart:async';
import '../services/network.dart';

const apiToken = 'cur_live_XzYR5Hubrv56xUT9h2olS8JAurfPpQIEUBki1XzM';

class RateService {
// https://api.currencyapi.com/v3/latest?apikey=cur_live_XzYR5Hubrv56xUT9h2olS8JAurfPpQIEUBki1XzM
  Future getRateInfo(String title) async {

    var urlUsingOneString = Uri.parse('https://api.currencyapi.com/v3/latest?apikey=$apiToken');

    Uri url = Uri(
      scheme: 'https',
      host: 'api.currencyapi.com',
      path: '/v3',
      query: 'latest?apikey=$apiToken'
    );
    print('url: $url');
    NetworkService networkService = NetworkService(url);
    var data = await networkService.getData();
    print(data);
    return data;
  }

  Future getRate(String title) async {

    var urlUsingOneString = Uri.parse(
        'https://api.currencyapi.com/v3/latest?apikey=$apiToken');

    Uri url = Uri(
      scheme: 'https',
      host: 'api.currencyapi.com',
      path: '/v3',
      query: 'latest?apikey=$apiToken'
    );
    print('url: $url');
    NetworkService networkService = NetworkService(url);
    var data = await networkService.getData();
    print(data);
    return data;
  }
}