import 'package:brainery/model/BraineryUser.dart';
import 'package:brainery/service/auth_service.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireBaseAuthService extends AuthService {
  BraineryUser _currentSignedInUser;
  FirebaseAuth _firebaseAuth;
  CloudFunctions _cloudFunctions;

  @override
  Future<BraineryUser> createNewUserWithEmail(
      String email, String password, String name) async {
    AuthResult result = await getFirebaseAuth()
        .createUserWithEmailAndPassword(email: email, password: password);

    BraineryUser newUser =
        new BraineryUser(result.user.uid, name, email, [], []);
    await getCloudFunctions()
        .getHttpsCallable(functionName: 'createBraineryUser')
        .call(newUser.toMap());
    return newUser;
  }

  @override
  Future<BraineryUser> getCurrentSignedInUser() async {
    if (_currentSignedInUser == null) {
      print("if Service>>>>>>>>>>>>");
      var firebaseAuth = getFirebaseAuth();
      FirebaseUser firebaseUser = await firebaseAuth.currentUser();
      if (firebaseUser == null) {
        return null;
      }
      HttpsCallableResult result = await getCloudFunctions()
          .getHttpsCallable(functionName: 'getBraineryUser')
          .call();
      _currentSignedInUser = BraineryUser.fromMap(result.data);
      return _currentSignedInUser;
    } else {
      print("Service>>>>>>>>>>>>");
      return _currentSignedInUser;
    }
  }

  void setCurrentUser(BraineryUser user) {
    _currentSignedInUser = user;
  }

  FirebaseAuth getFirebaseAuth() {
    if (_firebaseAuth == null) {
      _firebaseAuth = FirebaseAuth.instance;
    }
    return _firebaseAuth;
  }

  @override
  Future<void> signout() {
    //getSharedPreference().remove('user');
    //getSharedPreference().remove('uuid');
    _currentSignedInUser = null;
    return getFirebaseAuth().signOut();
  }

  Future<BraineryUser> signinWithEmail(String email, String password) async {
     HttpsCallableResult callResult = await getCloudFunctions()
          .getHttpsCallable(functionName: 'getBraineryUser')
          .call();
    print(callResult.data);
    return BraineryUser.fromMap(callResult.data);
  }

  CloudFunctions getCloudFunctions() {
    if (_cloudFunctions == null) {
      _cloudFunctions = CloudFunctions.instance;
    }
    return _cloudFunctions;
  }
}
