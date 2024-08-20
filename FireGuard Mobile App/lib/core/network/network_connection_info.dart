import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectionInfo {
    InternetConnectionChecker internetConnectionChecker;
  InternetConnectionInfo({
    required this.internetConnectionChecker,
  });

  Future<bool> get isConnected async {
    return internetConnectionChecker.hasConnection;
  }
}