import 'package:brew_crew/model/brews.dart';
import 'package:brew_crew/screen/home/settings_form.dart';
import 'package:brew_crew/service/auth.dart';
import 'package:brew_crew/service/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'brew_list.dart';

class Home extends StatelessWidget {
  //const Home({Key? key}) : super(key: key);

  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SettingForm(),
            );
          });
    }

    return StreamProvider<List<Brews>>.value(
      value: DataBaseService().documents,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text('Brew Crew'),
          actions: [
            TextButton.icon(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.black),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('Log out'),
            ),
            TextButton.icon(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.black),
              ),
              onPressed: () {
                _showSettingPanel();
              },
              icon: Icon(Icons.settings),
              label: Text('Settings'),
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
