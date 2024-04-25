import 'package:flutter/material.dart';
import './rate.dart';
import 'package:card_actions/card_action_button.dart';
import 'package:card_actions/card_actions.dart';

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
          return CardActions(
            width:500,
            height: 130,
            actions: <CardActionButton>[
            CardActionButton(
              label: '',
              icon: Icon(
                Icons.star_border_outlined),
                onPress:() {setState(() {});},
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
}
