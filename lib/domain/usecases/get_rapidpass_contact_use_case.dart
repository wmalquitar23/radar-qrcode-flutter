import 'package:radar_qrcode_flutter/data/models/rapidpass_contact_model.dart';
import 'package:radar_qrcode_flutter/domain/repositories/rapidpass_contact_repository.dart';

class GetRapidPassContactUseCase {
  final RapidPassContactRepository repository;

  GetRapidPassContactUseCase(this.repository);

  Future<RapidPassContact> execute() async {
    return await repository.getRapidPassContact();
  }
}
