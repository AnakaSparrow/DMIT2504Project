import 'package:flutter/material.dart';
import './rate.dart';
import '../services/db-service.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({super.key, required this.rates});

  final List<Rate> rates;

  @override
  State<StatefulWidget> createState() {
    return _HistoryListState();
  }
}

class _HistoryListState extends State<HistoryList> {
  final SQFliteDbService databaseService = SQFliteDbService();
  var historyList = <Rate>[];      

  @override
  void initState() {
    super.initState();
    getOrCreateDb();
  }

  void getOrCreateDb() async {
    await databaseService.getOrCreateDatabaseHandle();
    
    historyList = await databaseService.getAllHistoryFromDb();
    await databaseService.printAllHistoryInDbToConsole();
    setState(() {});
  } 
  @override
  Widget build(BuildContext context) {
    return _buildHistoryList(context, widget.rates);
  }

  ListView _buildHistoryList(context, List<Rate> rates) {
    return ListView.builder(
      itemCount: rates.length,
      itemBuilder: (context, index) {
          return  Card(
          child: ListTile(
            subtitle: 
              Text('Name: ${rates[index].name}'),
            trailing: 
              Text('Rate: \$${rates[index].price} '),
          ),
        );
      },
    );
  }
}