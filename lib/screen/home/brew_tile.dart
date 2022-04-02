import 'package:brew_crew/model/brews.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {
  const BrewTile({Key? key, this.brew}) : super(key: key);

  final Brews? brew;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown[brew!.strength],
          ),
          title: Text(brew!.name),
          subtitle: Text('Take ${brew!.sugars} sugar(s)'),
        ),
      ),
    );
  }
}
