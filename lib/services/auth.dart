import 'package:firebase_auth/firebase_auth.dart';
import '../models/users.dart';

class AuthService {
  final FirebaseAuth _authService = FirebaseAuth.instance;

  // Create User object based on Firebase User
  TheUser? _allUsersFromFirebase(User? allUsers) {
    return allUsers != null ? TheUser(uid: allUsers.uid) : null;
  }

  //Auth change User Stream
  Stream<TheUser?> get allUsers {
    return _authService.authStateChanges().map(_allUsersFromFirebase);
  }

  //Anon SignUp
  Future signUpAnon() async {
    try {
      UserCredential resultAnon = await _authService.signInAnonymously();
      User? userAnon = resultAnon.user;
      return _allUsersFromFirebase(userAnon);
    } catch (e) {
      //print(e.toString());
      return null;
    }
  }

  // Log Out

  Future signOut() async {
    try {
      return await _authService.signOut();
    } catch (e) {
      //print(e.toString());
      return null;
    }
  }
}
