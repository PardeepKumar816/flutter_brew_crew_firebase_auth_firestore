import 'package:brew_crew/model/brews.dart';
import 'package:brew_crew/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  DataBaseService({this.uid});
  final String? uid;

  // collection reference
  final brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // get brew list from snapshot
  List<Brews> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brews(
          name: doc.get('name') ?? '',
          sugars: doc.get('sugars') ?? '0',
          strength: doc.get('strength') ?? 0);
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        name: snapshot.get('name'),
        sugars: snapshot.get('sugars'),
        strength: snapshot.get('strength'),
        uid: uid!);
  }

  //get brews stream
  Stream<List<Brews>> get documents {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
