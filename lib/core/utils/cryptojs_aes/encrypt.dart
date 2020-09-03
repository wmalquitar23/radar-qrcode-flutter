import 'dart:convert';

String qrCodeObject(String userId, String encryptedData) {
  return jsonEncode({
    jsonEncode("key"): jsonEncode(encryptedData),
    jsonEncode("id"): jsonEncode(userId),
  });
}
