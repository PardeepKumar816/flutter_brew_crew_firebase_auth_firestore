class User {
  final String? uid;

  User({this.uid});
}

class UserData {
  final String uid;
  final String sugars;
  final String name;
  final int strength;

  UserData(
      {required this.name,
      required this.sugars,
      required this.strength,
      required this.uid});
}
