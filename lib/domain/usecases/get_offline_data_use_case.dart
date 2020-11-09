import 'package:radar_qrcode_flutter/data/models/check_in.dart';
import 'package:radar_qrcode_flutter/domain/repositories/transactions_repository.dart';

class GetOfflineUseCase {
  final TransactionsRepository repository;

  GetOfflineUseCase(this.repository);

  Future<List<CheckIn>> execute() async {
    return await repository.getCheckinOfflineData();
  }
}