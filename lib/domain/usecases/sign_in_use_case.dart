import 'package:radar_qrcode_flutter/data/mappers/user_mapper.dart';
import 'package:radar_qrcode_flutter/data/models/standard_response.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:radar_qrcode_flutter/domain/repositories/authentication_repository.dart';

class SignInUseCase {
  SignInUseCase(this.repository);

  final AuthenticationRepository repository;

  Future<User> execute(String contactNumber, String pin) async {
    StandardResponse response = await repository.signIn(contactNumber, pin);

    return UserMapper().fromMap(response.data['user']);
  }
}
