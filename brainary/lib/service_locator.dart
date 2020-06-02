import 'package:brainary/service/auth_service.dart';
import 'package:brainary/service/firebase_auth_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerSingleton<AuthService>(FireBaseAuthService());
}
