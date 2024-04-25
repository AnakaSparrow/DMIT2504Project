import 'package:flutter/material.dart';
import './rate.dart';

class FavouriteList extends StatefulWidget {
  const FavouriteList({super.key, required this.rates});

  final List<Rate> rates;

  @override
  State<StatefulWidget> createState() {
    return _FavouriteListState();
  }
}

class _FavouriteListState extends State<FavouriteList> {
  @override
  Widget build(BuildContext context) {
    return _buildFavouriteList(context, widget.rates);
  }

  ListView _buildFavouriteList(context, List<Rate> rates) {
    return ListView.builder(
      itemCount: rates.length,
      itemBuilder: (context, index) {
        return Card(
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
