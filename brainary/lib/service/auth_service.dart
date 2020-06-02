import 'package:brainary/model/BrainaryUser.dart';

abstract class AuthService{

    Future<BrainaryUser> createNewUserWithEmail(String email, String password, String name);

    BrainaryUser getCurrentSignedInUser();
}