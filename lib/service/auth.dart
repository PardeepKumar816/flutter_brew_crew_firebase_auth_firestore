import 'dart:async';

import 'package:brew_crew/model/user.dart';
import 'package:brew_crew/service/database.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;

class AuthService {
  final _auth = Auth.FirebaseAuth.instance;

  // to convert json to user model
  User? _userFromFirebaseUser(Auth.User? user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign in anonymously
  Future signInAnon() async {
    try {
      var result = await _auth.signInAnonymously();
      var user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInUserWithEmailAndPassword(String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      var user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// register with email and password
  Future registerUserWithEmailAndPassword(String email, String password) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      var user = result.user;
      await DataBaseService(uid: user?.uid)
          .updateUserData('0', 'new crew member', 100);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
