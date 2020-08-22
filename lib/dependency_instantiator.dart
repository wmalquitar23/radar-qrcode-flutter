import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:radar_qrcode_flutter/core/architecture/freddy_app_architecture.dart';
import 'package:radar_qrcode_flutter/core/utils/app/env_util.dart';
import 'package:radar_qrcode_flutter/data/sources/data/rest_client.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/register_as/register_as_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/success/success_bloc.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';

import 'presentation/bloc/splash/splash_bloc.dart';

final sl = GetIt.instance;

class DataInstantiator extends RadarDataInstantiator {
  Database database;

  @override
  Future<void> init() async {
    Map<String, String> env = await loadEnvFile();
    database = await getDatabase(env);
    Dio dio = getDio(database, env);

    var restClient = RestClient(dio);

    GetIt.I.registerSingleton<RestClient>(restClient);
    GetIt.I.registerSingleton<Dio>(dio);
    GetIt.I.registerSingleton<Database>(database);

    //bloc
    GetIt.I.registerSingleton<SplashBloc>(SplashBloc());
    sl.registerFactory<RegisterAsBloc>(
      () => RegisterAsBloc(),
    );
    sl.registerFactory<SuccessBloc>(
      () => SuccessBloc(),
    );
  }

  Future<Database> getDatabase(Map<String, String> env) async {
    var dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    var dbPath = join(dir.path, env['LOCAL_DB']);

    return await databaseFactoryIo.openDatabase(dbPath);
  }

  Dio getDio(Database database, Map<String, String> env) {
    BaseOptions options = new BaseOptions(
      baseUrl: env['API_URL'],
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      connectTimeout: 15000,
      receiveTimeout: 15000,
    );

    Dio dio = Dio(options);

    return dio;
  }
}
