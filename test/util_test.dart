import 'package:radar_qrcode_flutter/core/utils/cryptojs_aes/aes.dart';
import 'package:radar_qrcode_flutter/core/utils/cryptojs_aes/encrypt.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() async {});

  group("QRCode", () {
    test('Private key', () async {
      String id = 'GB5432';
      var encrypted = await encryptAESCryptoJS(id);
      var decrypted = await decryptAESCryptoJS("U2FsdGVkX18sRY5yK/BbHAvh4ia3oW+rlKyc2KmuMDQ=");
      var qrToJson = qrCodeObject(id, await encryptAESCryptoJS(id));

      print(encrypted);
      print(qrToJson);
      print(decrypted);
      expect(encrypted, isNotNull);
      expect(decrypted, isNotNull);
    });
  });
}
