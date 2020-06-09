import 'package:brainery/model/BraineryUser.dart';
import 'package:brainery/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireBaseAuthService extends AuthService {
  BraineryUser _currentSignedInUser;
  FirebaseAuth _firebaseAuth;
  Firestore _firestore;
  SharedPreferences _sharedPreferences;

  @override
  Future<BraineryUser> createNewUserWithEmail(
      String email, String password, String name) async {
    AuthResult result = await getFirebaseAuth()
        .createUserWithEmailAndPassword(email: email, password: password);

    BraineryUser newUser = new BraineryUser(result.user.uid, name, email);
    await getFirestore()
        .collection('users')
        .document(newUser.uid)
        .setData(newUser.toMap());
    setCurrentUser(newUser);
    return newUser;
  }

  @override
  Future<BraineryUser> getCurrentSignedInUser() async {
    var firebaseAuth = getFirebaseAuth();
    if(_currentSignedInUser==null){
      FirebaseUser firebaseUser = await firebaseAuth.currentUser();
      if(firebaseUser==null){
          return null;
      }
      DocumentSnapshot result= await getFirestore().collection('users').document(firebaseUser.uid).get();
      return BraineryUser.fromFirestoreDcoument(result);
    }else{
      return _currentSignedInUser;
    }
  }

  setCurrentUser(BraineryUser user) {
    _currentSignedInUser = user;
  }

  FirebaseAuth getFirebaseAuth() {
    if (_firebaseAuth == null) {
      _firebaseAuth = FirebaseAuth.instance;
    }
    return _firebaseAuth;
  }

  Firestore getFirestore() {
    if (_firestore == null) {
      _firestore = Firestore.instance;
    }
    return _firestore;
  }

  SharedPreferences getSharedPreference() {
    if (_sharedPreferences == null) {
      SharedPreferences.getInstance()
          .then((value) => _sharedPreferences = value);
    }
    return _sharedPreferences;
  }

  @override
  Future<BraineryUser> autoSigninEmailUser(String uid) async {
      DocumentReference doc =  getFirestore().collection('users').document(uid);
      return doc.get().then((value){
        return BraineryUser.fromFirestoreDcoument(value);
      });
  }

  @override
  Future<void> signout() {
    //getSharedPreference().remove('user');
    //getSharedPreference().remove('uuid');
    _currentSignedInUser = null;  
    return getFirebaseAuth().signOut();
  }

  Future<BraineryUser> signinWithEmail(String email, String password) async {
    AuthResult result = await  getFirebaseAuth().signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser fireBaseUser = result.user;
    DocumentSnapshot firebaseResult = await  getFirestore().collection('users').document(fireBaseUser.uid).get();
    return  BraineryUser.fromFirestoreDcoument(firebaseResult);
  }
}
