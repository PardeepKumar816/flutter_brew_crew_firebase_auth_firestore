import 'package:brew_crew/model/user.dart';
import 'package:brew_crew/service/database.dart';
import 'package:brew_crew/shared/constant.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  const SettingForm({Key? key}) : super(key: key);

  @override
  State<SettingForm> createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DataBaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          var userData = snapshot.data;
          if (snapshot.hasData) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Update your brew settings',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: userData?.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? 'Pleae enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  //DropDown
                  DropdownButtonFormField(
                    value: _currentSugars ?? userData?.sugars,
                    decoration: textInputDecoration,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        child: Text('$sugar sugars'),
                        value: sugar,
                      );
                    }).toList(),
                    onChanged: (String? value) =>
                        setState(() => _currentSugars = value!),
                  ),
                  //slider
                  Slider(
                      activeColor:
                          Colors.brown[_currentStrength ?? userData!.strength],
                      inactiveColor:
                          Colors.brown[_currentStrength ?? userData!.strength],
                      min: 100,
                      max: 900,
                      divisions: 8,
                      value:
                          (_currentStrength ?? userData!.strength).toDouble(),
                      onChanged: (val) =>
                          setState(() => _currentStrength = val.round())),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DataBaseService(uid: user.uid).updateUserData(
                            _currentSugars ?? userData!.sugars,
                            _currentName ?? userData!.name,
                            _currentStrength ?? userData!.strength);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Update'),
                  ),
                ],
              ),
            );
          } else {
            return const Loading();
          }
        });
  }
}
