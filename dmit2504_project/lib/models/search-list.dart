import 'package:flutter/material.dart';
import 'package:card_actions/card_action_button.dart';
import 'package:card_actions/card_actions.dart';
import './rate.dart';
import '../services/db-service.dart';

class SearchList extends StatefulWidget {
  const SearchList({super.key, required this.rates});

  final List<Rate> rates;

  @override
  State<StatefulWidget> createState() {
    return _SearchListState();
  }
}

class _SearchListState extends State<SearchList> {
  final SQFliteDbService databaseService = SQFliteDbService();
  var favouriteList = <Rate>[];      

  @override
  void initState() {
    super.initState();
    getOrCreateDb();
  }

  void getOrCreateDb() async {
    await databaseService.getOrCreateDatabaseHandle();
    
    favouriteList = await databaseService.getAllFavouritesFromDb();
    await databaseService.printAllFavouritesInDbToConsole();
    setState(() {});
  } 
  @override
  Widget build(BuildContext context) {
    return _buildSearchList(context, widget.rates);
  }

  ListView _buildSearchList(context, List<Rate> rates) {
    return ListView.builder(
      itemCount: rates.length,
      itemBuilder: (context, index) {
          return CardActions(
            width:500,
            height: 130,
            actions: <CardActionButton>[
            CardActionButton(
              label: 'Favourite',
              icon: Icon(
                Icons.star_border_outlined,
                color: Colors.blue ),
                onPress:  () async {
                  await databaseService.insertFavourite(
                    Rate(name: rates[index].name, price: rates[index].price)
                  );
                  setState(){};
                },
            )
          ],
          child: Card(
          child: ListTile(
            subtitle: 
              Text('Name: ${rates[index].name}'),
            trailing: 
              Text('Rate: \$${rates[index].price} '),
          ),
        )
      );
      },
    );
  }

  Future<void> favouriteRate(rate) async {
    try{
      await databaseService.insertRate(
        Rate( name: rate.name, price: rate.price,)
        );
      List<Rate> favouriteList = await databaseService.getAllFavouritesFromDb();
        print("search list: $favouriteList");
        await databaseService.printAllRatesInDbToConsole();
      //SetState((){});
    } catch (e) {
      print('SearchView favouriteRate catch: $e');
    }
  }
}
