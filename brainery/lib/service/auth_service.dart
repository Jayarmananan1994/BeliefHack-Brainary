import 'package:brainery/model/BraineryUser.dart';

abstract class AuthService{

    Future<BraineryUser> createNewUserWithEmail(String email, String password, String name);

    Future<BraineryUser> getCurrentSignedInUser();

    Future<BraineryUser> autoSigninEmailUser(String uid);

    Future<void> signout();

    Future<BraineryUser> signinWithEmail(String email, String password);

}