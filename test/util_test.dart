import 'dart:convert';

import 'package:radar_qrcode_flutter/core/enums/enums.dart';
import 'package:radar_qrcode_flutter/core/utils/cryptojs_aes/aes.dart';
import 'package:radar_qrcode_flutter/core/utils/cryptojs_aes/encrypt.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:radar_qrcode_flutter/data/models/address/user_address_model.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() async {});

  group("QRCode", () {
    test('Private key', () async {
      User user = User(
        id: "GB5432",
        firstName: "Jesther Jordan",
        middleName: "Sapio",
        lastName: "Minor",
        gender: Gender.male,
        birthDate: DateTime.now(),
        contactNumber: "9451096905",
        address: UserAddress(
          streetHouseNo: "Test",
          brgyCode: "Test",
          brgyName: "Test",
          citymunCode: "Test",
          citymunName: "Test",
          provCode: "Test",
          provName: "Test",
        ),
        role: "individual",
        isVerified: false,
        profileImageUrl: "",
        displayId: "GB5432",
      );
      String qrToJson = qrCodeObject(user);
      var encrypted = await encryptAESCryptoJS(qrToJson);
      dynamic decrypted = await decryptAESCryptoJS(encrypted);

      dynamic jsonDecrypt = jsonDecode(decrypted);

      print(encrypted);
      print(qrToJson);
      print(decrypted);
      print(jsonDecrypt);
      print(jsonDecrypt['id']);
      expect(qrToJson, isNotNull);
      // expect(decrypted, isNotNull);
    });
  });
}
