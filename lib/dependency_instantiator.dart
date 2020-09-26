import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:radar_qrcode_flutter/core/architecture/radar_app_architecture.dart';
import 'package:radar_qrcode_flutter/core/utils/app/env_util.dart';
import 'package:radar_qrcode_flutter/core/utils/navigation/navigation_service.dart';
import 'package:radar_qrcode_flutter/data/repositories_impl/address_repository_impl.dart';
import 'package:radar_qrcode_flutter/data/repositories_impl/rapidpass_contact_repository_impl.dart';
import 'package:radar_qrcode_flutter/data/sources/data/rest_client.dart';
import 'package:radar_qrcode_flutter/domain/repositories/address_repository.dart';
import 'package:radar_qrcode_flutter/domain/repositories/profile_repository.dart';
import 'package:radar_qrcode_flutter/domain/repositories/rapidpass_contact_repository.dart';
import 'package:radar_qrcode_flutter/domain/repositories/transactions_repository.dart';
import 'package:radar_qrcode_flutter/domain/usecases/checkin_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/get_address_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/get_profile_information_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/get_rapidpass_contact_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/get_session_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/listen_for_checkin_data_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/listen_for_session_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/logout_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/otp_verification_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/register_establishment_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/register_individual_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/resend_otp_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/sync_data_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/update_pin_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/upload_profile_image_use_case.dart';
import 'package:radar_qrcode_flutter/domain/usecases/upload_verification_id_use_case.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/address_picker/address_picker_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/change_contact_number/change_contact_number_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/change_pin/change_pin_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/contact_us/contact_us_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/establishment/establishment_bloc.dart';
import 'package:radar_qrcode_flutter/domain/usecases/verify_existing_mobile_number_use_case.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/establishment_signup/establishment_basic_information_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/individual/individual_bloc.dart';
import 'package:radar_qrcode_flutter/domain/usecases/sign_in_use_case.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/individual_signup/individual_basic_information_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/profile/profile_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/register_as/register_as_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/success/success_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/upload_id/upload_id_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/user_details/user_details_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/verification/verification_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/navigation/navigation_bloc.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/verification_identity/bloc/verification_id_bloc.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';

import 'core/network/network_info_impl.dart';
import 'data/local_db/session_db.dart';
import 'data/models/session_model.dart';
import 'data/repositories_impl/authentication_repository_impl.dart';
import 'data/repositories_impl/profile_repository_impl.dart';
import 'data/repositories_impl/transactions_repository_impl.dart';
import 'domain/repositories/authentication_repository.dart';
import 'presentation/bloc/sign_in_verification/sign_in_verification_bloc.dart';
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

    DataConnectionChecker dataConnectionChecker = DataConnectionChecker();
    AuthenticationRepository authenticationRepository =
        AuthenticationRepositoryImpl(database, restClient);
    ProfileRepository profileRepository =
        ProfileRepositoryImpl(database, restClient);
    TransactionsRepository transactionRepository =
        TransactionsRepositoryImpl(database, restClient);
    AddressRepository addressRepository = AddressRepositoryImpl();
    RapidPassContactRepository rapidPassContactRepository =
        RapidPassContactRepositoryImpl(database, restClient);

    //core
    GetIt.I.registerSingleton<RestClient>(restClient);
    GetIt.I.registerSingleton<Dio>(dio);
    GetIt.I.registerSingleton<Database>(database);
    //core
    sl.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(dataConnectionChecker));

    //bloc
    sl.registerFactory<ChangeContactNumberBloc>(() => ChangeContactNumberBloc(
          registerIndividualUseCase:
              RegisterIndividualUseCase(authenticationRepository),
          verifyExistingMobileNumberUseCase:
              VerifyExistingMobileNumberUseCase(authenticationRepository),
        ));
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
        resendOTPUseCase: ResendOTPUseCase(authenticationRepository),
      ),
    );
    sl.registerFactory<IndividualBloc>(
      () => IndividualBloc(
        listenForSessionUseCase:
            ListenForSessionUseCase(authenticationRepository),
        getProfileInformationUseCase:
            GetProfileInformationUseCase(profileRepository),
        networkInfo: NetworkInfoImpl(dataConnectionChecker),
        getSessionUseCase: GetSessionUseCase(authenticationRepository),
      ),
    );
    sl.registerFactory<EstablishmentBloc>(
      () => EstablishmentBloc(
        listenForSessionUseCase:
            ListenForSessionUseCase(authenticationRepository),
        uploadProfileImageUseCase: UploadProfileImageUseCase(profileRepository),
        getProfileInformationUseCase:
            GetProfileInformationUseCase(profileRepository),
        syncDataUseCase: SyncDataUseCase(transactionRepository),
        listenForCheckInDataUseCase:
            ListenForCheckInDataUseCase(transactionRepository),
        networkInfo: NetworkInfoImpl(dataConnectionChecker),
        getSessionUseCase: GetSessionUseCase(authenticationRepository),
      ),
    );
    sl.registerFactory<ProfileBloc>(
      () => ProfileBloc(
        listenForSessionUseCase:
            ListenForSessionUseCase(authenticationRepository),
        uploadProfileImageUseCase: UploadProfileImageUseCase(profileRepository),
        getProfileInformationUseCase:
            GetProfileInformationUseCase(profileRepository),
        getSessionUseCase: GetSessionUseCase(authenticationRepository),
      ),
    );
    sl.registerFactory<ChangePinBloc>(
      () =>
          ChangePinBloc(updatePINUseCase: UpdatePINUseCase(profileRepository)),
    );
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
        logoutUseCase: LogoutUseCase(authenticationRepository),
        getSessionUseCase: GetSessionUseCase(authenticationRepository),
      ),
    );
    sl.registerFactory<UserDetailsBloc>(
      () => UserDetailsBloc(
        checkInUseCase: CheckInUseCase(transactionRepository),
        networkInfo: NetworkInfoImpl(dataConnectionChecker),
      ),
    );
    sl.registerFactory<AddressPickerBloc>(
      () => AddressPickerBloc(
        getAddressUseCase: GetAddressUseCase(addressRepository),
      ),
    );
    sl.registerFactory<UploadIdBloc>(
      () => UploadIdBloc(),
    );
    sl.registerFactory<VerificationIdBloc>(() => VerificationIdBloc(
          uploadVerificationIdUseCase:
              UploadVerificationIdUseCase(profileRepository),
          getProfileInformationUseCase:
              GetProfileInformationUseCase(profileRepository),
        ));

    sl.registerFactory<SignInVerificationBloc>(() => SignInVerificationBloc(
          signInUseCase: SignInUseCase(authenticationRepository),
          getProfileInformationUseCase:
              GetProfileInformationUseCase(profileRepository),
        ));
    sl.registerFactory(() => ContactUsBloc(
        getRapidPassContactUseCase:
            GetRapidPassContactUseCase(rapidPassContactRepository)));

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
    GetIt.I.registerLazySingleton<UploadVerificationIdUseCase>(
        () => UploadVerificationIdUseCase(profileRepository));
    GetIt.I.registerLazySingleton<CheckInUseCase>(
        () => CheckInUseCase(transactionRepository));
    GetIt.I.registerLazySingleton<SyncDataUseCase>(
        () => SyncDataUseCase(transactionRepository));
    GetIt.I.registerLazySingleton<ListenForCheckInDataUseCase>(
        () => ListenForCheckInDataUseCase(transactionRepository));
    GetIt.I.registerLazySingleton<GetAddressUseCase>(
        () => GetAddressUseCase(addressRepository));
    GetIt.I.registerLazySingleton<ResendOTPUseCase>(
        () => ResendOTPUseCase(authenticationRepository));
    GetIt.I.registerLazySingleton<GetRapidPassContactUseCase>(
        () => GetRapidPassContactUseCase(rapidPassContactRepository));

    //repositories
    GetIt.I
        .registerSingleton<AuthenticationRepository>(authenticationRepository);
    GetIt.I.registerSingleton<ProfileRepository>(profileRepository);
    GetIt.I.registerSingleton<TransactionsRepository>(transactionRepository);
    GetIt.I.registerSingleton<AddressRepository>(addressRepository);
    GetIt.I.registerSingleton<RapidPassContactRepository>(
        rapidPassContactRepository);

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
      connectTimeout: 5000,
      receiveTimeout: 5000,
      sendTimeout: 5000,
      followRedirects: true,
      validateStatus: (status) {
        return status < 500;
      },
    );

    Dio dio = Dio(options);
    dio.interceptors.add(
      InterceptorsWrapper(onRequest: (Options options) async {
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
      }),
    );

    return dio;
  }
}
