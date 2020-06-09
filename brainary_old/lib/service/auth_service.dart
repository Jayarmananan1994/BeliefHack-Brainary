import 'package:brainary/model/BrainaryUser.dart';

abstract class AuthService{

    Future<BrainaryUser> createNewUserWithEmail(String email, String password, String name);

    Future<BrainaryUser> getCurrentSignedInUser();

    Future<BrainaryUser> autoSigninEmailUser(String uid);

    Future<void> signout();

    Future<BrainaryUser> signinWithEmail(String email, String password);

}