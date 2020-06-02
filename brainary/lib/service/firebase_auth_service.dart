import 'package:brainary/model/BrainaryUser.dart';
import 'package:brainary/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireBaseAuthService extends AuthService {
  BrainaryUser _currentSignedInUser;

  @override
  Future<BrainaryUser> createNewUserWithEmail(
      String email, String password, String name) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    Firestore firestore = Firestore.instance;
    AuthResult result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    BrainaryUser newUser = new BrainaryUser(result.user.uid, name, email);
    await firestore
        .collection('users')
        .document(newUser.uid)
        .setData(newUser.toMap());
    setCurrentUser(newUser);
    return newUser;
  }

  @override
  BrainaryUser getCurrentSignedInUser() {
    return _currentSignedInUser;
  }

  setCurrentUser(BrainaryUser user) {
    _currentSignedInUser = user;
  }
}
