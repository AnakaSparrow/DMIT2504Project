import 'package:flutter/material.dart';
import '../models/favourite-list.dart';
import '../models/rate.dart';
import '../services/rate-service.dart';
import '../services/db-service.dart';

class FavouriteView extends StatefulWidget {
  const FavouriteView({super.key});

  @override
  FavouriteViewState createState() => FavouriteViewState();
}

class FavouriteViewState extends State<FavouriteView> {
  final RateService rateService = RateService();
  final SQFliteDbService databaseService = SQFliteDbService();
  var favouriteList = <Rate>[];

  @override
  void initState() {
    super.initState();
    getOrCreateDbAndDisplayAllRatesInDb();
  }

  void getOrCreateDbAndDisplayAllRatesInDb() async {
    await databaseService.getOrCreateDatabaseHandle();
    favouriteList = await databaseService.getAllFavouritesFromDb();
    await databaseService.printAllFavouritesInDbToConsole();
    setState(() {});
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: 
       Scaffold(
        //default route
        backgroundColor: const Color.fromARGB(255, 220, 227, 232),
        appBar: AppBar(
          title: const Text("Currency Exchange", style: TextStyle(color:  Color.fromARGB(255, 216, 231, 243)),),
          backgroundColor: const Color.fromARGB(255, 1, 108, 111),
        ),
        body: Column(
          children: <Widget>[
            const Text('Favourites', 
                  style:  TextStyle(
                      color:  Color.fromARGB(255, 8, 69, 71), 
                      fontSize: 25
                    )
                ),          
                Expanded(
                  child: FavouriteList(rates: favouriteList)),
          ],
        ),
      )
    );
    }
}

