import 'package:brew_crew/screen/authenticate/authenticate.dart';
import 'package:brew_crew/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    // will return home or authenticate
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
