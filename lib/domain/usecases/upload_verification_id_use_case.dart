import 'dart:io';
import 'package:radar_qrcode_flutter/domain/repositories/profile_repository.dart';

class UploadVerificationIdUseCase {
  final ProfileRepository repository;

  UploadVerificationIdUseCase(this.repository);

  Future<void> execute(File file) async {
    return await repository.uploadVerificationId(file);
  }
}
