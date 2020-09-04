import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:radar_qrcode_flutter/core/architecture/freddy_app_architecture.dart';
import 'package:radar_qrcode_flutter/core/utils/app/env_util.dart';
import 'package:radar_qrcode_flutter/core/utils/navigation/navigation_service.dart';
import 'package:radar_qrcode_flutter/data/sources/data/rest_client.dart';
import 'package:radar_qrcode_flutter/domain/repositories/profile_repository.dart';
import 'package:radar_qrcode_flutter/domain/usecases/get_profile_information_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/get_session_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/listen_for_session_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/logout_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/otp_verification_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/register_establishment_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/register_individual_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/update_pin_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/upload_profile_image_use_case.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/change_pin/change_pin_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/establishment/establishment_bloc.dart';
import 'package:radar_qrcode_flutter/domain/usecases/verify_existing_mobile_number_use_case.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/establishment_signup/establishment_basic_information_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/individual/individual_bloc.dart';
import 'package:radar_qrcode_flutter/domain/usecases/sign_in_use_case.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/individual_signup/individual_basic_information_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/profile/profile_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/register_as/register_as_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/success/success_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/verification/verification_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/navigation/navigation_bloc.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';

import 'data/local_db/session_db.dart';
import 'data/models/session_model.dart';
import 'data/repositories_impl/authentication_repository_impl.dart';
import 'data/repositories_impl/profile_repository_impl.dart';
import 'domain/repositories/authentication_repository.dart';
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

    //implementations
    AuthenticationRepository authenticationRepository =
        AuthenticationRepositoryImpl(database, restClient);
    ProfileRepository profileRepository =
        ProfileRepositoryImpl(database, restClient);

    //core
    GetIt.I.registerSingleton<RestClient>(restClient);
    GetIt.I.registerSingleton<Dio>(dio);
    GetIt.I.registerSingleton<Database>(database);

    //bloc
    sl.registerFactory<SplashBloc>(
      () => SplashBloc(
        getSessionUseCase: GetSessionUseCase(authenticationRepository),
      ),
    );
    sl.registerFactory<RegisterAsBloc>(
      () => RegisterAsBloc(),
    );
    sl.registerFactory<SuccessBloc>(
      () => SuccessBloc(
        getSessionUseCase: GetSessionUseCase(authenticationRepository),
      ),
    );
    sl.registerFactory<IndividualBasicInformationBloc>(
      () => IndividualBasicInformationBloc(
        registerIndividualUseCase:
            RegisterIndividualUseCase(authenticationRepository),
        verifyExistingMobileNumberUseCase:
            VerifyExistingMobileNumberUseCase(authenticationRepository),
      ),
    );
    sl.registerFactory<VerificationBloc>(
      () => VerificationBloc(
        otpVerificationUseCase:
            OtpVerificationUseCase(authenticationRepository),
      ),
    );
    sl.registerFactory<IndividualBloc>(
      () => IndividualBloc(
        listenForSessionUseCase:
            ListenForSessionUseCase(authenticationRepository),
      ),
    );
    sl.registerFactory<EstablishmentBloc>(
      () => EstablishmentBloc(
        listenForSessionUseCase:
            ListenForSessionUseCase(authenticationRepository),
      ),
    );
    sl.registerFactory<ProfileBloc>(
      () => ProfileBloc(
        listenForSessionUseCase:
            ListenForSessionUseCase(authenticationRepository),
        uploadProfileImageUseCase: UploadProfileImageUseCase(profileRepository),
        getProfileInformationUseCase:
            GetProfileInformationUseCase(profileRepository),
      ),
    );
    sl.registerFactory<ChangePinBloc>(
      () =>
          ChangePinBloc(updatePINUseCase: UpdatePINUseCase(profileRepository)),);
    sl.registerFactory<EstablishmentBasicInformationBloc>(
      () => EstablishmentBasicInformationBloc(
        registerEstablishmentUseCase:
            RegisterEstablishmentUseCase(authenticationRepository),
        verifyExistingMobileNumberUseCase:
            VerifyExistingMobileNumberUseCase(authenticationRepository),
      ),
    );
    sl.registerFactory<NavigationBloc>(
      () => NavigationBloc(
          logoutUseCase: LogoutUseCase(authenticationRepository)),
    );

    //usecases
    GetIt.I.registerLazySingleton<RegisterIndividualUseCase>(
        () => RegisterIndividualUseCase(authenticationRepository));
    GetIt.I.registerLazySingleton<OtpVerificationUseCase>(
        () => OtpVerificationUseCase(authenticationRepository));
    GetIt.I.registerLazySingleton<GetSessionUseCase>(
        () => GetSessionUseCase(authenticationRepository));
    GetIt.I.registerLazySingleton<ListenForSessionUseCase>(
        () => ListenForSessionUseCase(authenticationRepository));
    GetIt.I.registerLazySingleton<SignInUseCase>(
        () => SignInUseCase(authenticationRepository));
    GetIt.I.registerLazySingleton<UploadProfileImageUseCase>(
        () => UploadProfileImageUseCase(profileRepository));
    GetIt.I.registerLazySingleton<GetProfileInformationUseCase>(
        () => GetProfileInformationUseCase(profileRepository));
    GetIt.I.registerLazySingleton<UpdatePINUseCase>(
        () => UpdatePINUseCase(profileRepository));
    GetIt.I.registerLazySingleton<LogoutUseCase>(
        () => LogoutUseCase(authenticationRepository));

    //repositories
    GetIt.I
        .registerSingleton<AuthenticationRepository>(authenticationRepository);

    //navigator service
    GetIt.I.registerLazySingleton<NavigatorService>(() => NavigatorService());
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
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (Options options) async {
          SessionDb sessionDb = SessionDb(database);
          dio.interceptors.requestLock.lock();
          Session currentSession = await sessionDb.getCurrentSession();
          if (currentSession?.token != null)
            options.headers.addAll(
              {
                "Authorization": "Bearer ${currentSession.token}",
              },
            );
          dio.interceptors.requestLock.unlock();
          return options; //continue
        },
      ),
    );

    return dio;
  }
}
