// ignore_for_file: todo, avoid_print, use_key_in_widget_constructors, avoid_function_literals_in_foreach_calls, use_build_context_synchronously, unused_local_variable

import 'package:flutter/material.dart';
import 'dart:async';
import '../models/search-list.dart';
import '../models/rate.dart';
import '../services/rate-service.dart';
import '../services/db-service.dart';
import 'favourite.dart';

class HomeView extends StatefulWidget {
  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  final RateService rateService = RateService();
  final SQFliteDbService databaseService = SQFliteDbService();
  var rateList = <Rate>[];
  String rateName = "";

  @override
  void initState() {
    super.initState();
    getOrCreateDbAndDisplayAllRatesInDb();
  }

  void getOrCreateDbAndDisplayAllRatesInDb() async {
    await databaseService.getOrCreateDatabaseHandle();
    rateList = await databaseService.getAllRatesFromDb();
    await databaseService.printAllRatesInDbToConsole();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Currency Exchange", style: TextStyle(color:  Color.fromARGB(255, 216, 231, 243)),),  
        backgroundColor: const Color.fromARGB(255, 1, 108, 111),
        ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            child: const Text(
              'Find Rate',
            ),
            onPressed: () async {
              await databaseService.getOrCreateDatabaseHandle();
              rateList = await databaseService.getAllRatesFromDb();
              await databaseService.printAllRatesInDbToConsole();
              setState(() {});
              searchRate();
            },
          ),
          //We must use an Expanded widget to get
          //the dynamic ListView to play nice
          //with the TextButton.
          Expanded(
            child: SearchList(rates: rateList),
          ),
          ElevatedButton(
            child: const Text('Favourites Page',
            style: TextStyle(fontSize: 30.0),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const FavouriteView()));
            },
          )
        ],
      ),
    );

  }

  Future<void> searchRate() async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Input Currency'),
            contentPadding: const EdgeInsets.all(5.0),
            content: TextField(
              decoration: const InputDecoration(hintText: "Search"),
              onChanged: (String value) {
                rateName = value;
              },
            ),
            actions: <Widget>[
              TextButton(
                child: const Text("Add Rate"),
                onPressed: () async {
                  if (rateName.isNotEmpty) {
                    print('User entered Title: $rateName');
                    var name = rateName;
                    var price = '';
                    try {
                      var data = 
                          await rateService.getRateInfo();
                      if (!data.isNotEmpty) {
                        print(
                          "Call to getRateInfo failed to return data");
                      } else {
                          name = data["data"][name]["code"];
                          print(name);
                          price = (data["data"][name]["value"].toString());
                          print(price);
                          await databaseService.insertRate(
                            Rate
                            ( name: name, price: price,
                            ));
                          
                          List<Rate> rateList = await databaseService.getAllRatesFromDb();
                          print("search list: $rateList");
                          await databaseService.printAllRatesInDbToConsole();
                      }
                      setState(() {});
                    } catch (e) {
                      print('HomeView searchRate catch: $e');
                    }
                  }
                  rateName = "";
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }
}

//Navigator.push(context, MaterialPageRoute(builder: (context) => FavouriteViewState()));