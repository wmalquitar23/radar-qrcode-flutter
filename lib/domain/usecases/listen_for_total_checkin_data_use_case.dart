import 'package:radar_qrcode_flutter/data/models/check_in.dart';
import 'package:radar_qrcode_flutter/domain/repositories/transactions_repository.dart';

class ListenForTotalCheckInDataUseCase {
  final TransactionsRepository repository;

  ListenForTotalCheckInDataUseCase(this.repository);

  Stream<List<CheckIn>> stream() {
    return repository.listenForTotalCheckIn();
  }
}
