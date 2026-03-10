import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected async {
    final result = await connectionChecker.hasConnection;
    print("CHECK INTERNET RESULT: $result");
    return result;
  }
}
// import 'dart:async';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:http/http.dart' as http;

// abstract class NetworkInfo {
//   Future<bool> get isConnected;
// }

// class NetworkInfoImpl implements NetworkInfo {
//   final InternetConnectionChecker _checker;

//   NetworkInfoImpl(this._checker);

//   @override
//   Future<bool> get isConnected async {
//     // أولًا: نستخدم InternetConnectionChecker
//     bool result = await _checker.hasConnection;

//     // لو قال false، نجرب HTTP GET للتأكد
//     if (!result) {
//       result = await _tryHttpPing();
//     }

//     print("NetworkInfo: isConnected = $result");
//     return result;
//   }

//   Future<bool> _tryHttpPing() async {
//     try {
//       final response = await http
//           .get(Uri.parse('https://www.google.com'))
//           .timeout(Duration(seconds: 5));
//       return response.statusCode == 200;
//     } catch (_) {
//       return false;
//     }
//   }
// }
