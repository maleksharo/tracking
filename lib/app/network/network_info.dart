// import 'package:tracking/app/di/injection.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:injectable/injectable.dart';
//
//
//
// abstract class NetworkInfo {
//   Future<ConnectivityResult> get isConnected;
//
//   List<ConnectivityResult> get connectionList;
// }
//
// @Injectable(as: NetworkInfo)
// class NetworkInfoImpl extends NetworkInfo {
//   final _internetConnectionChecker = getIt<Connectivity>();
//
//   @override
//   Future<ConnectivityResult> get isConnected => _internetConnectionChecker.checkConnectivity();
//
//   @override
//   List<ConnectivityResult> get connectionList => [
//         ConnectivityResult.ethernet,
//         ConnectivityResult.mobile,
//         ConnectivityResult.wifi,
//         ConnectivityResult.vpn,
//         ConnectivityResult.bluetooth,
//         ConnectivityResult.other,
//       ];
// }
