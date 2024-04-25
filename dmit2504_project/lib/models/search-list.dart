import 'package:flutter/material.dart';
import './rate.dart';

class SearchList extends StatefulWidget {
  const SearchList({super.key, required this.rates});

  final List<Rate> rates;

  @override
  State<StatefulWidget> createState() {
    return _SearchListState();
  }
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    return _buildSearchList(context, widget.rates);
  }

  ListView _buildSearchList(context, List<Rate> rates) {
    return ListView.builder(
      itemCount: rates.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            subtitle: 
              Text('Name: ${rates[index].name}'),
            trailing: 
              Text('Rate: ${rates[index].price} '),
          ),
        );
      },
    );
  }
}

/**
 *         return const CardAction(
          actions: <CardActionButton>[
            CardActionButton(
              icon: Icon(
                Icons.favorite
                color: Colors.blue ,)
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
 * 
 */
