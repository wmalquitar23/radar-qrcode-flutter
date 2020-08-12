import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:radar_qrcode_flutter/dependency_instantiator.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TestDataInstantiator extends DataInstantiator {
  @override
  Future<Database> getDatabase(Map<String, String> env) async {
    String dpPath = env['LOCAL_DB'];
    DatabaseFactory dbFactory = databaseFactoryIo;
    return await dbFactory.openDatabase(dpPath);
  }

  Dio getDio(Database database, Map<String, String> env) {
    Dio dio = super.getDio(database, env);
    dio.interceptors.add(
      PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          maxWidth: 500,
          error: true,
          responseBody: true),
    );
    return dio;
  }
}
