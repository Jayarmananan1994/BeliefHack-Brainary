import 'package:brainery/model/BraineryUser.dart';
import 'package:brainery/service/auth_service.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    _currentSignedInUser = null;
    return getFirebaseAuth().signOut();
  }

  Future<BraineryUser> signinWithEmail(String email, String password) async {
    await getFirebaseAuth().signInWithEmailAndPassword(email: email, password: password);
    HttpsCallableResult callResult = await getCloudFunctions()
        .getHttpsCallable(functionName: 'getBraineryUser')
        .call();
    return BraineryUser.fromMap(callResult.data);
  }

  CloudFunctions getCloudFunctions() {
    if (_cloudFunctions == null) {
      _cloudFunctions = CloudFunctions.instance;
    }
    return _cloudFunctions;
  }
}
