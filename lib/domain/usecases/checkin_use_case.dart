import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:radar_qrcode_flutter/domain/repositories/transactions_repository.dart';

class CheckInUseCase {
  final TransactionsRepository repository;

  CheckInUseCase(this.repository);

  Future<void> execute(User user, bool hasConnection) async {
    return await repository.checkIn(user, hasConnection);
  }
}
