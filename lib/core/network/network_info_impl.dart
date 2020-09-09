import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:radar_qrcode_flutter/core/architecture/radar_app_architecture.dart';

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
