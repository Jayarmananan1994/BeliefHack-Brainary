import 'package:brainery/service/auth_service.dart';
import 'package:brainery/service/firebase_auth_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerSingleton<AuthService>(FireBaseAuthService());
}
