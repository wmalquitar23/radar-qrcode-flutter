import 'dart:convert';

Map<String, dynamic> qrCodeObject(String userId, String encryptedData) {
  return {
    jsonEncode("key"): jsonEncode(encryptedData),
    jsonEncode("id"): jsonEncode(userId),
  };
}
